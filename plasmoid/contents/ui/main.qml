/*
 * Copyright (C) 2017 by David Baum <david.baum@naraesk.eu>
 *
 * This file is part of plasma-yamaha.
 *
 * plasma-systemd is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * plasma-systemd is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with plasma-codeship.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.2
import Process 1.0

Item {
    id: root

    Component.onCompleted: {
        loadServices()
    }

    Connections {
        target: plasmoid.configuration
        onServicesChanged: loadServices()
    }

    function loadServices() {
        serviceModel.clear()
        var list = plasmoid.configuration.services
        for(var i in list) {
            var item = JSON.parse(list[i])
            serviceModel.append( item )
        }
    }

    Process {
        id: process
    }

    ListModel {
        id: serviceModel
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                width: parent.width
                model: serviceModel
                spacing: 7

                delegate: RowLayout {
                    width: parent.width

                    function update() {
                        statusSwitch.checked = process.isActive(model.service)
                    }

                    Timer {
                        interval: 1000
                        repeat: true
                        triggeredOnStart: true
                        running: true
                        onTriggered: {
                            update()
                        }
                    }

                    Switch {
                        id: statusSwitch
                        Layout.leftMargin: 10
                        onClicked: {
                            if (checked) {
                                process.start2('sudo', [ '/bin/systemctl', 'start', model.service ]);
                            } else {
                                process.start2('sudo', [ '/bin/systemctl', 'stop', model.service ]);
                            }
                        }
                    }

                    Label {
                        id: serviceName
                        text: model.service
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}

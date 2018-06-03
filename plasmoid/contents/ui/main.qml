/*
 * Copyright (C) 2018 by David Baum <david.baum@naraesk.eu>
 *
 * This file is part of plasma-docker.
 *
 * plasma-docker is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * plasma-docker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with plasma-docker.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Styles 1.3
import eu.naraesk.docker.process 1.0

Item {
    id: root

    Component.onCompleted: {
        loadServices()
    }

    Connections {
        target: plasmoid.configuration
        onContainerChanged: loadServices()
    }

    function loadServices() {
        serviceModel.clear()
        var list = plasmoid.configuration.container
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

    ListView {
        id: view
        width: parent.width
        height: parent.height
        model: serviceModel
        spacing: 7
        interactive: false

        delegate: RowLayout {
            width: parent.width

            function update() {
                statusSwitch.checked = process.isActive(model.dir, model.service)
            }

            Timer {
                interval: 1000*60*10
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
                checked: false
                onClicked: {
                    if (checked) {
                        process.start2('docker-compose', [ '-f', model.dir, '-p', model.service, 'up', '-d' ]);
                    } else {
                        process.start2('docker-compose', [ '-f', model.dir, '-p', model.service, 'down']);
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

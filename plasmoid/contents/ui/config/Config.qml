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
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

Item {
    property var cfg_container: []

    id: root
    width: parent.width
    height: parent.height

    Component.onCompleted: {
        var list = plasmoid.configuration.container
        cfg_container = []
        for(var i in list) {
            addService( JSON.parse(list[i]) )
        }
   }

    function addService(object) {
        serviceModel.append( object )
        cfg_container.push( JSON.stringify(object) )
    }

    function removeService(index) {
        if(serviceModel.count > 0) {
            serviceModel.remove(index)
            cfg_container.splice(index,1)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        Layout.fillWidth: true
        GridLayout {
            id: layout
            columns: 2
            rows: 3
            Layout.fillWidth: true
            width: parent.width

            Label {
                text: i18n('Project name')
                Layout.alignment: Qt.AlignRight
            }

            TextField {
                id: name
                Layout.fillWidth: true
                placeholderText: "project name"
            }
            
            Label {
                text: i18n('YAML file')
                Layout.alignment: Qt.AlignRight
            }

            TextField {
                id: dir
                Layout.fillWidth: true
                placeholderText: "Path of YAML file"
            }

            Button {
                anchors.right: layout.right
                text: qsTr('Add container')
                iconName: "list-add"
                Layout.columnSpan: 2
                Layout.alignment: Qt.AlignRight
                onClicked: {
                    var object = ({'service': name.text, 'dir': dir.text})
                    addService(object)
                    name.text = ""
                    dir.text = ""
                }
            }
       }

        ColumnLayout {
            width: parent.width
            height: parent.height

            ListModel {
                id: serviceModel
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    frameVisible: true

                    ListView {
                        width: parent.width
                        model: serviceModel

                        delegate: RowLayout {
                            width: parent.width

                            Label {
                                Layout.fillWidth: true
                                text: model.service
                            }
                            
                            Label {
                                Layout.fillWidth: true
                                text: model.dir
                            }

                            Button {
                                id: removeServiceButton
                                iconName: "list-remove"
                                onClicked: removeService(model.index)
                            }
                        }
                    }
                }
            }
        }
    }
}

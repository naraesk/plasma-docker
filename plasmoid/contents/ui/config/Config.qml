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
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

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

    function up(index, name) {
        serviceModel.move(index, index-1,1)
        var object = cfg_container.splice(index,1)
        cfg_container.splice(index-1, 0, object )
    }

    function down(index, name) {
        serviceModel.move(index, index+1,1)
        var object = cfg_container.splice(index,1)
        cfg_container.splice(index+1, 0, object)
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
            columns: 3
            rows: 3
            Layout.fillWidth: true
            width: parent.width

            Label {
                text: i18n('Title')
                Layout.alignment: Qt.AlignRight
            }

            TextField {
                id: name
                Layout.fillWidth: true
                placeholderText: "Display name"
                Layout.columnSpan: 2
            }
            
            Label {
                text: i18n('Compose file')
                Layout.alignment: Qt.AlignRight
            }

            TextField {
                id: dir
                Layout.fillWidth: true
                placeholderText: "Path of compose file"
            }
            
            Button {
                id: chooseDirectory
                text: i18n("Select")
                onClicked: {
                    fileDialog.visible = true
                }
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
            
            FileDialog {
                id: fileDialog
                title: i18n("Please choose a compose file")
                folder: shortcuts.home
                nameFilters: [ "Docker compose files (*.yml)"]
                selectedNameFilter: "Docker compose files (*.yml)"
                visible: false
                onAccepted: {
                    var folderPath = fileDialog.fileUrl.toString();
                    // remove prefixed "file:///"
                    folderPath = folderPath.replace(/^(file:\/{2})|(qrc:\/{2})|(http:\/{2})/,"");
                    // unescape html codes like '%23' for '#'
                    dir.text = decodeURIComponent(folderPath);
                }
            }
       }

        ColumnLayout {
            width: parent.width
            height: parent.height

            ListModel {
                id: serviceModel
            }

            TableView {
                model: serviceModel
                id: view
                Layout.fillWidth: true
                Layout.fillHeight: true
                sortIndicatorVisible: false

                TableViewColumn {
                    role: "service"
                    title: i18n("Service name")
                    width: parent.width * 0.3
                    horizontalAlignment: Text.AlignHCenter
                    delegate: Component {
                        Text {
                            text: styleData.value
                            color: styleData.textColor
                        }
                    }
                }

                TableViewColumn {
                    role: "dir"
                    title: i18n("Compose file")
                    width: parent.width * 0.58
                    horizontalAlignment: Text.AlignHCenter
                    delegate: Component {
                        Text {
                            text: styleData.value
                            color: styleData.textColor
                        }
                    }
                }

                TableViewColumn {
                    role: "actions"
                    title: i18n("Actions")
                    width: parent.width * 0.1
                    horizontalAlignment: Text.AlignHCenter
                    delegate: Component {
                        Row {
                            id: row
                            Button {
                                iconName: "list-remove"
                                onClicked: removeService(model.index)
                                height: 20
                            }

                            Button {
                                iconName: "arrow-up"
                                onClicked: up(model.index)
                                height: 20
                            }

                            Button {
                                iconName: "arrow-down"
                                onClicked: down(model.index)
                                height: 20
                            }
                        }
                    }
                }
            }
        }
    }
}

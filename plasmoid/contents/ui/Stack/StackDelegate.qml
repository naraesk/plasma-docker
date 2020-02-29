/*
 * Copyright (C) 2020 by David Baum <david.baum@naraesk.eu>
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

import QtQuick 2.12;
import QtQuick.Controls 2.12;
import QtQuick.Dialogs 1.3;
import QtQuick.Extras 1.4;
import QtQuick.Layouts 1.12;
import org.kde.plasma.core 2.0 as PlasmaCore;
import "stack.js" as Stack;

Component {
    id: stack;

    RowLayout {        
        id: stackRow;
        height: stackName.height;
        Layout.alignment: Qt.AlignVCenter;

        property string composeFile: "";
        property bool isExpanded: false;

        Component.onCompleted: {
            composeFile = Stack.getComposeFile(section);
            isExpanded = true;
            statusIndicator.on = Stack.checkStatus(section);
        }

        onIsExpandedChanged: {
            Stack.updateVisibility(section, stackRow.isExpanded);
            Stack.updateIcon(expandButton, stackRow.isExpanded);
        }

        ToolButton {
            id: expandButton;
            flat: true;
            icon.name: "list-add";
            onClicked: {
                stackRow.isExpanded = !stackRow.isExpanded;
            }
        }

        MouseArea {
            height: 15;
            width: 15;
            onClicked: {
                statusIndicator.on = !statusIndicator.on;
                Stack.startAndStopStack(statusIndicator.on, composeFile);
            }

            StatusIndicator {
                id: statusIndicator;
                anchors.fill: parent;
                color: "green";
            }
        }

        PlasmaCore.IconItem {
            id: item;
            source: "stack";
        }

        Label {
            id: stackName;
            text: section;
            Layout.fillWidth: true;
            font.pixelSize: 22;
        }

        Timer {
            interval: 1000 * 30;
            repeat: true;
            triggeredOnStart: true;
            running: true;
            onTriggered: {
                Stack.updateSection(composeFile);
                statusIndicator.on = Stack.checkStatus(section);
            }
        }
    }
}

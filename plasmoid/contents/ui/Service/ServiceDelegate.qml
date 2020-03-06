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
import eu.naraesk.docker.process 1.2;
import org.kde.plasma.core 2.0 as PlasmaCore;
import "service.js" as Service;

Component {
    id: listdelegate;

    RowLayout {
        id: serviceRow;
        visible: aVisible;
        property bool online: model.online;
        Layout.leftMargin: 20;
        Layout.fillWidth: true;
        spacing: 10;
        anchors.fill: parent.left;

        onVisibleChanged: {
            height = Service.getHeight(visible, text.height);
        }

        onOnlineChanged: {
            statusIndicator.on = online;
        }

        Behavior on height {
            NumberAnimation { duration: 100; }
        }

        Rectangle {
            id: spacer;
            width: units.largeSpacing * 3;
        }

        MouseArea {
            id: statusButton;
            height: 15;
            width: 15;
            onClicked: {
                statusIndicator.on = !statusIndicator.on;
                Service.startAndStopService(statusIndicator.on, model.file, model.name);
            }

            StatusIndicator {
                id: statusIndicator;
                anchors.fill: parent;
                color: "green";
                on: online;
            }
        }

        Label {
            Layout.topMargin: units.smallSpacing;
            Layout.bottomMargin: units.smallSpacing;
            id: text;
            text: name;
        }

        ToolButton {
            id: execButton;
            icon.name: "bash";
            ToolTip.text: qsTr("Run shell");
            ToolTip.visible: hovered;
            visible: model.online;
            onClicked: serviceProcess.runShell(model.file, model.name);
        }

        ToolButton {
            id: browserButton;
            icon.name: "browser";
            icon.width: units.iconSizes.small;
            icon.height: units.iconSizes.small;
            ToolTip.text: qsTr("Open in browser");
            ToolTip.visible: hovered;
            visible: model.online && model.port;
            onClicked: serviceProcess.startBrowser(model.file, model.name);
        }

        Process {
            id: serviceProcess;
        }
    }
}

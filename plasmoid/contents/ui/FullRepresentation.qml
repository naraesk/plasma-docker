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
import QtQuick.Layouts 1.12;
import eu.naraesk.docker.process 1.2;
import org.kde.plasma.plasmoid 2.0;
import "model.js" as Model;
import "Service"
import "Stack"

Item {
    id: root;
    Layout.minimumWidth: 170;
    Layout.minimumHeight: 100;
    height: units.gridSize * 4;

    Component.onCompleted: {
        Model.loadServices();
    }

    Connections {
        target: plasmoid.configuration;
        onContainerChanged: Model.loadServices();
    }

    Process {
        id: process;
    }

    ListModel {
        id: serviceModel;
    }

    ListView {
        id: view;
        contentHeight: 100;
        anchors.fill: root;
        anchors.top: root.top;
        model: serviceModel;
        spacing: units.smallSpacing;
        delegate: ServiceDelegate {}
        section.property: 'stack';
        section.delegate: StackDelegate {}
    }
}

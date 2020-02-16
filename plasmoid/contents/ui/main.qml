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
import eu.naraesk.docker.process 1.0

Item {
    id: root
    Layout.minimumWidth: 170;

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

        var numberOfRows = serviceModel.rowCount();

        if(numberOfRows == 0) {
            root.Layout.minimumHeight = view.contentItem.children[0].height;
        } else {
            root.Layout.minimumHeight = view.contentItem.children[0].height + (numberOfRows) * 18 + 10
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
        header: Header {}
        model: serviceModel
        spacing: 7
        interactive: false
        delegate: StackRow {}
    }
}

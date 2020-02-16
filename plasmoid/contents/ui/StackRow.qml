import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Controls 1.3
 
 
RowLayout {
    id: rows
    width: parent.width
    height: serviceName.height

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
    
    ListView.onAdd: console.log("iate")
}

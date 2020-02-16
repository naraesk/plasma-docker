import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Controls 1.3

Component {
    id: component 
    Item {
        id: stackheader
        width: parent.width;
        height: 40;

        Image {
            id: logo
            source: "img/dockerlogo.png"
            height: 24;
            width: 24;
            anchors.right: title.left;
            anchors.rightMargin: 8;
        }   
  
        Label {
            id: title
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Docker Stacks")
            font.bold: true
        }
    }
}

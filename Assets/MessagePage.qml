import QtQuick 2.0

Item {
    id: root

    property string text: messageTxt.text

    Rectangle {
        id: messageRect

        anchors.centerIn: parent

        width: parent.width
        height: 200
        radius: 8

        color: "grey"

        Text {
            id: messageTxt

            anchors.centerIn: parent
            font {
                family: "Ubuntu"
                pixelSize: 18
            }
        }
    }
}

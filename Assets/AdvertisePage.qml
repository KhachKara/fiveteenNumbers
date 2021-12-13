import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: advertisement

        height: 75
        color: "yellow"
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Text {
            id: adverTxt
            text: qsTr("advertisement ")
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}

import QtQuick 2.0

Rectangle {
    id: advertisement

    color: "yellow"
    Text {
        id: adverTxt
        text: qsTr("реклама ")
        font {
            family: "Ubuntu"
            pixelSize: 32
        }
        anchors.centerIn: parent
    }
}


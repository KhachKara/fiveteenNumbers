import QtQuick 2.0

Rectangle {
    id: pauseRect

    width: 250
    height: 100
    radius: 8

    color: Qt.rgba(0,0,0,0.5)

    Image {
        id: pauseBtn
        source: "./icons/pause.svg"
        anchors.centerIn: parent
    }
}


import QtQuick 2.0
Rectangle {
    id: pauseRect

    signal playClicked()

    width: 200
    height: 80
    radius: 8

    color: Qt.rgba(0,0,0,0.5)

    Image {
        id: pauseBtn
        source: "./icons/play.svg"
        anchors.centerIn: parent

        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                playClicked()
            }
        }
    }

}


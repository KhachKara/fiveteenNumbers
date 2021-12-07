import QtQuick 2.0

Item {
    id: header

    property alias pageName: pageName.text
    property alias backVisible: back.visible
    property alias exitVisible: exit.visible
    property alias backIsPause: back.isPause

    anchors.fill: parent

    Image {
        id: back
        property bool isPause: false
        source: isPause ? "./icons/pause.svg" : "./icons/back.svg"
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 30
            topMargin: 32
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                cursorShape = Qt.PointingHandCursor
            }

            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                console.log("back", "pause =", back.isPause)
            }
        }
    }

    Image {
        id: exit
        source: "./icons/exit.svg"
        anchors {
            top: parent.top
            right: parent.right
            rightMargin: 30
            topMargin: 32
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                cursorShape = Qt.PointingHandCursor
            }

            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                Qt.quit()
            }
        }
    }

    Text {
        id: pageName

        color: "#B0A8B9"
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 32
        }

        font {
            family: "Ubuntu"
            pixelSize: 22
        }
    }
}

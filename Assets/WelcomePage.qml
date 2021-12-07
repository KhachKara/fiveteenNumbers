import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.2

Item {
    id: root

    anchors.fill: parent

    property alias index: rep.index

    signal startedGame(int size)
    signal logoClicked()
    signal repClicked()

    Image {
        id: logo

        source: "./icons/logo.svg"
        sourceSize.width: 113
        sourceSize.height: 127
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 67
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
                root.logoClicked()
            }

        }
    }

    property var rectText: ["New game", "Rate", "Settings", "Quit"]

    Column {
        spacing: 11
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 243
        }
        Repeater {
            id: rep

            model: 4
            Rectangle {
                id: rectButton
                width: 300
                height: 70
                color: "#845EC2"
                radius: 8
                Text {
                    id: rectText
                    anchors.centerIn: parent
                    color: "#FFFFFF"
                    text: welcomePage.rectText[index]
                    font {
                        family: "Ubuntu"
                        pixelSize: 32
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        rectButton.color = "#8400C2"
                        cursorShape = Qt.PointingHandCursor
                    }

                    onExited: {
                        rectButton.color = "#845EC2"
                        cursorShape = Qt.ArrowCursor
                    }
                    onClicked: {
                        root.repClicked()
                    }
                }
            }
        }
    }
}

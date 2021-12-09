import QtQuick 2.0

Item {
    id: root

    signal logoClicked()

    signal newGameClicked()
    signal rateClicked()
    signal settingsClicked()
    signal quitClicked()

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

    Column {
        spacing: 11
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 243
        }
        Repeater {
            id: rep

            readonly property var signalsButton: [root.newGameClicked, root.rateClicked,
                                                  root.settingsClicked, root.quitClicked]

            model: ["New game", "Rate", "Settings", "Quit"]
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
                    text: modelData
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
                        rep.signalsButton[index]();
                    }
                }
            }
        }
    }
}

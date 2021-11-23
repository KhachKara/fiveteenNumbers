import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    signal startedGame(int size)


    NewGamePage {
        id: newGamePage

        anchors.fill: parent
        visible: false
    }

    GamePage {
        id: gamePage
        anchors.fill: parent
        visible: false
    }

    Rectangle {
        id: welcomePage

        anchors.fill: parent
        color: "#4B4453"

        Image {
            id: logo
            source: "./icons/logo.png"
            sourceSize.width: 113
            sourceSize.height: 127
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 67
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
                            if (rectText.text === "New game") {
                                welcomePage.visible = false
                                gamePage.visible = false
                                newGamePage.visible = true
                                console.log("new game page")
                            } else if (rectText.text === "Rate") {
                                // welcomePage.visible = false
                                // rate.visible = true
                                console.log("rate page")
                            } else if (rectText.text === "Settings") {
                                // welcomePage.visible = false
                                // setingPage.visible = true
                                console.log("settings page")
                            } else {
                                console.log("quit page")
                            }
                        }
                    }
                }
            }
        }
    }
}

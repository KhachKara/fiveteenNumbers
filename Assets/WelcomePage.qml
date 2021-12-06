import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.2

Rectangle {
    id: welcomePage

    anchors.fill: parent

    signal startedGame(int size)

    color: Qt.rgba(0,0,0,0)

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
                            templatePage.state = "newGamePage"
                            console.log("new game page")
                        } else if (rectText.text === "Rate") {
                            console.log("rate page")
                        } else if (rectText.text === "Settings") {
                            console.log("settings page")
                        } else {
                            console.log("quit page")
                            Qt.quit()
                        }
                    }
                }
            }
        }
        Text {
            id: name
            text: qsTr("welcomePage")
        }
    }
}

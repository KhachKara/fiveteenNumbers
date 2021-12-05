import QtQuick 2.0

Item {
    id: root

    signal startedGame(int size)
    property alias state: templatePage.state

    Rectangle {
        id: templatePage

        property alias pause: pause

        anchors.fill: parent
        color: "#4B4453"

        WelcomePage {
            id: welcomePage
            visible: false
        }

        NewGamePage {
            id: newGamePage
            visible: false
        }

        Image {
            id: pause
            source: "./icons/pause.svg"
            visible: false
            anchors {
                top: parent.top
                left: back.right
                leftMargin: 10
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
                    console.log("pause")
                }
            }
        }

        Image {
            id: back
            source: "./icons/back.svg"
            visible: false
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
                    console.log("back")
                    txtTimeValue.text = "00:00"
                }
            }
        }

        Image {
            id: exit
            source: "./icons/exit.svg"
            visible: false
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

        states: [
            State {
                name: "welcomePage"
                PropertyChanges {
                    target: welcomePage
                    visible: true
                }
            },
            State {
                name: "newGamePage"
                PropertyChanges {
                    target: newGamePage
                    visible: true
                }
                PropertyChanges {
                    target: welcomePage
                    visible: false
                }
            }
        ]
    }
}

import QtQuick 2.0

Item {
    id: root

    signal startedGame(int size)
    property alias state: templatePage.state

    Rectangle {
        id: templatePage

        property alias pause: pause
        property alias back: back
        property alias exit: exit
        property alias pageName: pageName.text

        anchors.fill: parent
        color: "#4B4453"

        AboutPage {
            id: aboutPage

            visible: false
        }

        WelcomePage {
            id: welcomePage
            visible: false
        }

        NewGamePage {
            id: newGamePage

            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }

        GamePage {
            id: gamePage
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
                    welcomePage.visible = true
                    gamePage.text = "00:00"
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

        states: [
            State {
                name: "welcomePage"
                PropertyChanges {
                    target: welcomePage
                    visible: true
                }
            },
            State {
                name: "aboutPage"
                PropertyChanges {
                    target: aboutPage
                    visible: true

                }
                PropertyChanges {
                    target: templatePage
                    back.visible: true
                    exit.visible: true
                    pageName: "About"
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
                PropertyChanges {
                    target: templatePage
                    back.visible: true
                    exit.visible: true
                    pageName: "New game"
                }
            }
        ]
    }
    // #убрать
    Text {
        id: name
        text: qsTr("tamplatePage")
    }
}

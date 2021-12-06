import QtQuick 2.0

Rectangle {
    id: root

    color: "#4B4453"
    state: p.stateWelcome

    QtObject {
        id: p
        readonly property string stateWelcome: "WelcomePage"
        readonly property string stateLevels: "LevelsPage"
        readonly property string stateGame: "GamePage"
        readonly property string stateAbout: "AboutPage"
    }

    AboutPage {
        id: aboutPage
        anchors.fill: parent
        visible: false
    }

    WelcomePage {
        id: welcomePage
        anchors.fill: parent
        visible: false
    }

    // Переименуй компонент в LevelsPage
    NewGamePage {
        id: levelsPage

        anchors.fill: parent
        visible: false
    }

    GamePage {
        id: gamePage
        anchors.fill: parent
        visible: false
    }

    // \todo вынести в отдельный компонент.
    Item {
        id: header

        property alias pageName: pageName.text
        property alias backVisible: back.visible
        property alias exitVisible: exit.visible
        property alias backIsPause: back.isPause

        height: 65
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

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

    states: [
        State {
            name: p.stateWelcome
            PropertyChanges {
                target: welcomePage
                visible: true
            }
            PropertyChanges {
                target: header
                backVisible: false
                exitVisible: false
            }
        },
        State {
            name: p.stateLevels
            PropertyChanges {
                target: levelsPage
                visible: true
            }
            PropertyChanges {
                target: header
                pageName: "New game"
            }
        },
        State {
            name: p.stateGame
            PropertyChanges {
                target: gamePage
                visible: true
            }
            PropertyChanges {
                target: header
                pageName: "gamePage.gameSize нужно добавить"
                backIsPause: true
            }
        }
        // и тд
    ]
}

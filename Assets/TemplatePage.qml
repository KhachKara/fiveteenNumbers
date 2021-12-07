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

    LevelsPage {
        id: levelsPage

        anchors.fill: parent
        visible: false
    }

    GamePage {
        id: gamePage

        anchors.fill: parent
        visible: false
    }

    Header {
        id: header

        anchors.fill: parent
        visible: false
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
                pageName: "New Game"
                backVisible: true
                exitVisible: true
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
    ]
}

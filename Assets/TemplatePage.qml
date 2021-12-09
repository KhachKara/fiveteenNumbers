import QtQuick 2.0

Rectangle {
    id: root

    color: "#4B4453"
    state: p.stateWelcome

    QtObject {
        id: p
        readonly property string stateLogin: "Login"
        readonly property string stateSignIn: "SignIn"
        readonly property string stateHeader: "Header"
        readonly property string stateWelcome: "WelcomePage"
        readonly property string stateLevels: "LevelsPage"
        readonly property string stateGame: "GamePage"
        readonly property string stateScoreBoard: "ScoreBoard"
        readonly property string stateAbout: "AboutPage"
        readonly property string stateRate: "RatePage"
        readonly property string stateSettings: "SettingsPage"
    }

    // СТРАНИЦЫ ____________________________________________________

    GameArea {
        id: gameArea

        visible: false
    }

    Header {
        id: header

        anchors.fill: parent
        visible: false
    }

    WelcomePage {
        id: welcomePage

        anchors.fill: parent
        visible: false

        onLogoClicked: {
            root.state = p.stateAbout
        }

        onNewGameClicked: {
            root.state = p.stateLevels
        }

        onRateClicked: {
            root.state = p.stateRate
        }

        onSettingsClicked: {
            root.state = p.stateSettings
        }

        onQuitClicked: {
            Qt.quit()
        }
    }

    LevelsPage {
        id: levelsPage

        anchors.fill: parent
        visible: false

        onStartGameClicked: function(size) {
            root.state = p.stateGame;
            gamePage.startGame(size);
        }
    }

    GamePage {
        id: gamePage

        anchors.fill: parent
        visible: false

        onFinished: {
            root.state = p.stateScoreBoard
        }
    }

    WinPage {
        id: winPage

        anchors {
            top: parent.top
            bottom: parent.bottom
            topMargin: 134
            bottomMargin: 60
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
        }
        visible: false

        onContinueClicked: {
            root.state = p.stateLevels
        }

        onRateClicked: {
            root.state = p.stateRate
        }
    }

    // СТЕЙТЫ ___________________________________________________________
    states: [

        // WelcomePage ------------------
        State {
            name: p.stateWelcome
            PropertyChanges {
                target: welcomePage
                visible: true
            }
            PropertyChanges {
                target: header
                backVisible: true
                exitVisible: true
            }
            PropertyChanges {
                target: ratePage
                visible: false
            }
            PropertyChanges {
                target: gamePage
                visible: false
            }
        },

        // levelsPage ------------------
        State {
            name: p.stateLevels
            PropertyChanges {
                target: levelsPage
                visible: true
            }
            PropertyChanges {
                target: header
                pageName: "New game"
                enabled: true
                backVisible: true
                exitVisible: true
            }
        },

        // stateGame ------------------
        State {
            name: p.stateGame
            PropertyChanges {
                target: gamePage
                visible: true
            }
            PropertyChanges {
                target: header
                visible: true
            }
        }
    ]
}

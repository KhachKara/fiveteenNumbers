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
        readonly property string stateWin: "WinPage"
        readonly property string statePause: "PausePage"
        readonly property string stateAbout: "AboutPage"
        readonly property string stateRate: "RatePage"
        readonly property string stateSettings: "SettingsPage"
    }

    // СТРАНИЦЫ ____________________________________________________
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
            root.state = p.stateWin
        }
    }

    WinPage {
        id: winPage

        steps: gamePage.steps
        time: gamePage.time

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

    PausePage {
        id: pausePage

        anchors.centerIn: parent
        visible: false
    }

    Header {
        id: header

        anchors.fill: parent
        visible: false

        onBackClicked: {
            if (backIsPause === true) {
                root.state = p.statePause
            }
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
                visible: true
                pageName: "New game"
            }
        },

        // gamePage ------------------
        State {
            name: p.stateGame
            PropertyChanges {
                target: gamePage
                visible: true
            }
            PropertyChanges {
                target: header
                visible: true
                pageName: "%1x%1".arg(gamePage.areaSize)
                backIsPause: true
            }
        },

        // winPage ------------------
        State {
            name: p.stateWin
            PropertyChanges {
                target: winPage
                visible: true
            }
        },

        // pausePage ------------------
        State {
            name: p.statePause
            PropertyChanges {
                target: pausePage
                visible: true
            }
        }

    ]
}

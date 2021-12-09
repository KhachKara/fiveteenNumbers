import QtQuick 2.0

Rectangle {
    id: root

    color: "#4B4453"
    state: p.stateLogin

    QtObject {
        id: p
        readonly property string stateLogin: "Login"
        readonly property string stateHeader: "Header"
        readonly property string stateWelcome: "WelcomePage"
        readonly property string stateLevels: "LevelsPage"
        readonly property string stateGame: "GamePage"
        readonly property string stateAbout: "AboutPage"
        readonly property string stateRate: "RatePage"
        readonly property string stateSettings: "SettingsPage"
    }

    // СТРАНИЦЫ ____________________________________________________
    LoginPage {
        id: loginPage

        anchors.fill: parent
        visible: false

        onLogoClicked: {}
        onSignInButton: {}
        onLoginButton: {}
        onSkip: {}
    }

    SignInPage {
        id: signInPage

        anchors.fill: parent
        visible: false

        onLogoClicked: {}
        onEnterButton: {}
        onSkip: {}

    }

    SocialNetwork {
        id: socialNetwork

        anchors.fill: parent
        visible: false

        onFacebookClicked: {}
        onGoogleClicked: {}
        onAppleClicked: {}
    }

    GameArea {
        id: gameArea

        visible: false
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

        onLogoClicked: {
            root.state = p.stateAbout
        }

        onNewGameClicked: {
            root.state = p.stateGame
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

        onGameStyleClicked: {
            root.state = p.stateGame
        }
    }

    GamePage {
        id: gamePage

        anchors.fill: parent
        visible: false

        onStarted: {
            header.backIsPause = true
        }
        onFinished: {
            scoreBoard.steps = gameArea.stepCount
            scoreBoard.time = formatTime(gameArea.gameTimeSec)
            header.enabled = false
            winPage.visible = true
        }
    }

    RatePage {
        id: ratePage

        anchors.fill: parent
        visible: false
    }

    SettingsPage {
        id: settingsPage

        anchors.fill: parent
        visible: false
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

        time: gamePage.time
        steps: gamePage.steps

        onContinueClicked: {
            root.state = p.stateLevels
        }

        onRateClicked: {
            root.state = p.stateRate
        }

    }

    ScoreBoard {
        id: scoreBoard

        visible: false
    }

    Header {
        id: header

        anchors.fill: parent

        onBackClicked: {
            root.state = p.stateWelcome
            winPage.visible = false
        }
    }

    // СТЕЙТЫ ___________________________________________________________
    states: [
        State {
            // Login
            name: p.stateLogin
            PropertyChanges {
                target: loginPage
                visible: true
            }
            PropertyChanges {
                target: header
                visible: false
            }
        },
        State {
            // Header
            name: p.stateHeader
            PropertyChanges {
                target: header
                visible: true
            }
        },
        State {
            // WelcomePage
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
            PropertyChanges {
                target: ratePage
                visible: false
            }
            PropertyChanges {
                target: gamePage
                visible: false
            }
        },
        State {
            // levelsPage
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
            PropertyChanges {
                target: winPage
                visible: false
            }
            PropertyChanges {
                target: gamePage
                visible: false
            }
        },
        State {
            // stateGame
            name: p.stateGame
            PropertyChanges {
                target: levelsPage
                visible: true
            }
        },
        State {
            // stateRate
            name: p.stateRate
            PropertyChanges {
                target: ratePage
                visible: true
            }
            PropertyChanges {
                target: header
                pageName: "Rate"
            }
            PropertyChanges {
                target: winPage
                visible: false
            }
            PropertyChanges {
                target: header
                enabled: true
                backIsPause: false
            }
        },
        State {
            // stateAbout
            name: p.stateAbout
            PropertyChanges {
                target: aboutPage
                visible: true
            }
            PropertyChanges {
                target: header
                visible: true
                pageName: "Our team"
            }
        },
        State {
            // stateSettings
            name: p.stateSettings
            PropertyChanges {
                target: settingsPage
                visible: true
            }
            PropertyChanges {
                target: header
                visible: true
                pageName: "Settings"
            }
        }
    ]
}

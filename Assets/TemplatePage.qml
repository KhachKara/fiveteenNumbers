import QtQuick 2.0

Rectangle {
    id: root

    color: "#4B4453"
    state: p.stateLogin

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
    LoginPage {
        id: loginPage

        anchors.fill: parent
        visible: false

        onLogoClicked: {
            root.state = p.stateAbout
        }

        onSignInButton: {
            root.state = p.stateSignIn
        }

        onLoginButton: {}

        onSkip: {
            root.state = p.stateWelcome
        }
    }

    SignInPage {
        id: signInPage

        anchors.fill: parent
        visible: false

        onLogoClicked: {
            root.state = p.stateAbout
        }

        onEnterButton: {}
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

    Header {
        id: header

        anchors.fill: parent
        visible: true

        onBackClicked: {
            root.state = p.stateWelcome
            winPage.visible = false
        }
    }

    // СТЕЙТЫ ___________________________________________________________
    states: [

        // Login ------------------
        State {
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

        // SignIn ------------------
        State {
            name: p.stateSignIn
            PropertyChanges {
                target: signInPage
                visible: true
            }
            PropertyChanges {
                target: header
                visible: false
            }
        },

        // Header ------------------
        State {
            name: p.stateHeader
            PropertyChanges {
                target: header
                visible: true
            }
        },

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
//            PropertyChanges {
//                target: winPage
//                visible: false
//            }
//            PropertyChanges {
//                target: gamePage
//                visible: false
//            }
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
        },

        // scoreBoard ------------------
        State {
            name: p.stateScoreBoard
            PropertyChanges {
                target: header
                visible: true
                enabled: false
            }
            PropertyChanges {
                target: winPage
                visible: true
            }
        },

        // stateRate ------------------
        State {
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
                target: header
                enabled: true
                backIsPause: false
            }
        },

        // stateAbout ------------------
        State {
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

        // stateSettings ------------------
        State {
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

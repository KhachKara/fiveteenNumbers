import QtQuick 2.0

Rectangle {
    id: root

    color: "#4B4453"
    state: p.stateWelcome

    QtObject {
        id: p
        readonly property string stateHeader: "Header"
        readonly property string stateWelcome: "WelcomePage"
        readonly property string stateLevels: "LevelsPage"
        readonly property string stateGame: "GamePage"
        readonly property string stateAbout: "AboutPage"
        readonly property string stateRate: "RatePage"
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

        onRepClicked: {
            if (index === 0) { // New game
                root.state = p.stateLevels;
                console.log("new game page")
            } else if (index === 1) { // Rate
                root.state = p.stateRate;
                console.log("rate page")
            } else if (index === 2) { // Settings
                root.state = p.stateSettings;
                console.log("settings page")
            } else {
                console.log("quit page")
                Qt.quit()
            }
        }
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

Header {
    id: header

    anchors.fill: parent

    onBackClicked: {
        root.state = p.stateWelcome
    }
}

states: [
State {  // Header
    name: p.stateHeader
    PropertyChanges {
        target: header
        visible: true
    }
},
State {  // WelcomePage
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
State {  // levelsPage
    name: p.stateLevels
    PropertyChanges {
        target: levelsPage
        visible: true
    }
    PropertyChanges {
        target: header
        pageName: "New game"
        backVisible: true
        exitVisible: true
    }
},
State {  // stateGame
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
},
State {  // stateRate
    name: p.stateRate
    PropertyChanges {
        target: ratePage
        visible: true
    }
    PropertyChanges {
        target: header
        pageName: "Rate"
    }
},
State {  // stateAbout
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
State {  // stateAbout
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

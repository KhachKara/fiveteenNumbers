import "./Assets"

import QtQml 2.2
import QtQuick 2.15
import QtQuick.Controls 2.5

Window {
    id: root

    readonly property int topMargin: 30

    readonly property color mainBgColor: "#4B4453"
    readonly property color grayBgColor: "#B0A8B9"
    readonly property color carrotBgColor: "#C34A36"
    readonly property color lightCarrotBgColor: "#FF8066"

    width: 360
    height: 640
    color: mainBgColor
    visible: true
    title: qsTr("15 Numbers")


    HeaderPage {
        id: headerPage
        anchors.fill: parent
        visible: false

        onBackClicked: {
            console.log(stackView.currentItem)
            if(stackView.currentItem === levelsPage || stackView.currentItem === aboutPage)
            {
                stackView.pop()
                headerPage.visible = false
                logoPage.visible = true
            } else if (stackView.currentItem === gamePage) {
                stackView.pop()
                headerPage.visible = true
                headerPage.pageName = "New game"
                logoPage.visible = false
            }
        }
    }

    AboutPage {
        id: aboutPage

        visible: false
    }

    WelcomePage {
        id: welcomePage

        visible: false
        anchors.top: parent.top
        anchors.topMargin: 160

        onNewGameClicked: {
            stackView.push(levelsPage)
            headerPage.visible = true
            headerPage.z = 1
            headerPage.pageName = "New game"
            logoPage.visible = false
        }
    }

    LevelsPage {
        id: levelsPage

        visible: false
        onStartGameClicked: {
            stackView.push(gamePage)
            headerPage.visible = true
            logoPage.visible = false
        }
    }

    GamePage {
        id: gamePage

        visible: false
    }

    LogoPage {
        id: logoPage

        height: 100
        width: parent.width
        z: 1

        onLogoClicked: {
            stackView.push(aboutPage)
            logoPage.visible = false
            headerPage.visible = true
            headerPage.pageName = "Our team"
            headerPage.z = 1
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: welcomePage
    }

    // ------------------------------------
    GameArea {
        id: gameArea

        visible: false
    }

    GameStyleRect {
        id: gameStyle

        visible: false
    }

    AdvertisePage {
        id: advertisePage

        anchors.bottom: parent.bottom
    }
}

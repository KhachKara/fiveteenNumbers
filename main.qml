import "./Assets"

import QtQml 2.2
import QtQuick 2.15
import QtQuick.Window 2.15
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
            stackView.pop()
            headerPage.visible = false
            logoPage.visible = true
        }
    }

    WelcomePage {
        id: welcomePage

        visible: false
        anchors.top: parent.top
        anchors.topMargin: 160

        onNewGameClicked: {
            stackView.push("qrc:/Assets/LevelsPage.qml")
            headerPage.visible = true
            headerPage.z = 1
            headerPage.pageName = "New game"
            logoPage.visible = false
        }
    }

    LevelsPage {
        id: levelsPage

        visible: false
    }

    GamePage {
        id: gamePage

        anchors.fill: parent
        visible: false
    }

    LogoPage {
        id: logoPage

        height: 100
        width: parent.width
        z: 1

        onLogoClicked: {
            stackView.push("qrc:/Assets/AboutPage.qml")
            logoPage.visible = false
            headerPage.visible = true
            headerPage.pageName = "Our team"
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: welcomePage
    }

    AdvertisePage {
        id: advertisePage

        anchors.bottom: parent.bottom
    }
}

import QtQml 2.2
import QtQuick 2.15
import QtQuick.Controls 2.5

import "./Assets"

ApplicationWindow {
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
        z: 1
        visible: stackView.depth > 1

        onBackClicked: {
            console.log("Out of " + stackView.currentItem)
            logoPage.visible = true
            if(stackView.currentItem === levelsPage || stackView.currentItem === aboutPage)
            {
                stackView.pop()
                logoPage.visible = true
            } else if (stackView.currentItem === gamePage) {
                stackView.pop()
                headerPage.pageName = "New game"
                logoPage.visible = false
                winPage.visible = false
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
            console.log("Frome " + stackView.currentItem)
            stackView.push(levelsPage)
            headerPage.pageName = "New game"
            logoPage.visible = false
            headerPage.backIsPause = false
        }
        onQuitClicked: {
            Qt.quit()
        }
    }

    LevelsPage {
        id: levelsPage

        visible: false
        onStartGameClicked: function (size) {
            console.log("From " + stackView.currentItem)
            stackView.push(gamePage)
            headerPage.pageName = "%1 x %1".arg(size)
            gamePage.startGame(size)
            headerPage.backIsPause = false
        }
    }

    GamePage {
        id: gamePage

        visible: false
        onStarted: {
            headerPage.backIsPause = true
        }

        onFinished: {
            scoreBoard.steps = gameArea.stepCount
            scoreBoard.time = gameArea.gameTimeSec
            headerPage.backIsPause = false
            winPage.visible = true
            visible = false
        }
    }

    LogoPage {
        id: logoPage

        height: 100
        width: parent.width

        onLogoClicked: {
            console.log("From " + stackView.currentItem)
            stackView.push(aboutPage)
            logoPage.visible = false
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

    WinPage {
        id: winPage

        steps: gamePage.steps
        time: gamePage.time

        anchors {
            top: parent.top
            bottom: parent.bottom
            topMargin: 100
            bottomMargin: 100
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
        }
        visible: false
        onContinueClicked: {
            winPage.visible = false
            stackView.pop()
        }
        onRateClicked: {
            // блок проверки наличие игрока в списке рейтингов
            // если есть - показываем новый результ, если рекорд добавляем в список новые данные
            // если нет в списке - авторизуемся и добовляем в список подчеркиваем место и результат
            stackView.push(ratePage)
            winPage.visible = false
            authorizationPage.visible = true
        }
    }

    ScoreBoard {
        id: scoreBoard

        visible: false
    }

    RatePage {
        id: ratePage

        visible: false
    }

    AuthorizationPage {
        id: authorizationPage

        anchors.fill: parent
        anchors.margins: 30
        visible: false
    }

    AdvertisePage {
        id: advertisePage

        anchors.bottom: parent.bottom
    }
}

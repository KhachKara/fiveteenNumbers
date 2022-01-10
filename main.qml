import QtQml 2.2
import QtQuick 2.2
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

        property alias welcomeUser: gamePage.welcomeuser
        onBackClicked: {
            console.log("Out of " + stackView.currentItem)
            logoPage.visible = true
            if(stackView.currentItem === levelsPage ||
                    stackView.currentItem === settingsPage ||
                    stackView.currentItem === ratePage ||
                    stackView.currentItem === winPage ||
                    stackView.currentItem === aboutPage)
            {
                stackView.pop()
                logoPage.visible = true
            } else if (stackView.currentItem === gamePage) {
                stackView.pop()
                headerPage.pageName = "New game"
                logoPage.visible = false
                winPage.visible = false
            } else if (stackView.currentItem === authorizationPage) {
                stackView.pop()
                logoPage.visible = false
                welcomeUser.visuble = true
            }
        }
    }

    AboutPage {
        id: aboutPage

        onSendClicked: {
            messageBox.visible = true

            if (!nickName || !e_mail.acceptableInput || !message) {
                messageBoxTxt = correctFill
            } else {messageBoxTxt = success}
        }

        onMessageCloseClicked: {
            if(messageBoxTxt === success) {
                stackView.pop()
                logoPage.visible = true
                messageBox.visible = false
                state = "getEmpty"
            } else {messageBox.visible = false}
        }

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

        onSettingsClicked: {
            console.log("Frome " + stackView.currentItem)
            stackView.push(settingsPage)
            logoPage.visible = false
            headerPage.pageName = "Settings"
        }

        onRateClicked: {
            console.log("Frome " + stackView.currentItem)
            stackView.push(ratePage)
            logoPage.visible = false
            headerPage.pageName = "Rate"
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

        onFinished: {
            scoreBoard.steps = gameArea.stepCount
            scoreBoard.time = gameArea.gameTimeSec
            headerPage.backIsPause = false
            winPage.visible = true
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
        //        initialItem: testingPage
    }

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
        onRateMeClicked: {
            // блок проверки наличие игрока в списке рейтингов
            // если есть - показываем новый результат, если рекорд - добавляем в список новые данные
            // если нет в списке - авторизуемся и добовляем в список подчеркиваем место и результат
            winPage.visible = false
            stackView.push(authorizationPage)
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

        visible: false

        onEnterClicked: {
            if (core.signIn(nickname, password) === -1) {
                core.registerPlayer(nickname, password)
                gamePage.welcomeuser.visible = true
                core.addResult(gamePage.areaSize, gamePage.steps, gameArea.gameTimeSec)
                stackView.pop()
                console.log(gameArea.gameTimeSec)
            } else if (core.signIn(nickname, password) === -2) {
                messagePage.visible = true
                messagePage.text = messagePage.passwordError
                headerPage.enabled = false
            } else {
                stackView.pop()
                gamePage.welcomeuser.visible = true
                core.addResult(gamePage.areaSize, gamePage.steps, gameArea.gameTimeSec)
            }
        }
    }

    SettingsPage {
        id: settingsPage

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: 400
            leftMargin: 30
            rightMargin: 30
        }
        visible: false
    }

    AdvertisePage {
        id: advertisePage

        anchors.bottom: parent.bottom
    }

    MessagePage {
        id: messagePage

        property string inUse: "This nickname is already in use!"
        property string fillNickname: "Fill the nickname!"
        property string fillPassword: "Fill the password!"
        property string passwordError: "Fill the correct password!"

        anchors.centerIn: parent

        onCloseButtonClicked: {
            messagePage.visible = false
            headerPage.enabled = true
        }

        width: parent.width
        height: 200

        visible: false
    }
    TestingPage {
        id: testingPage

        visible: false
    }
}

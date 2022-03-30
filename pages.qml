import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12

import "./Assets"

ApplicationWindow {
    id: root

    readonly property color mainBgColor: "#4B4453"
    readonly property real bottomGradientSize: 25

    visible: true
    width: 360
    height: 640
    color: mainBgColor
    title: "15 Numbers"

    Component.onCompleted: {
        if (core.existRecoveryGame()) {
            gamePage.recoveryGame(
                        core.recoveryArea()
                        , core.recoverySteps()
                        , core.recoveryTimeSec())
            stackView.push(gamePage);
        }
    }

    /*header: */Item {
        id: headerItem
        anchors {
            left: parent.left
            right: parent.right
        }
        z: 1
        height: 100
        HeaderPage {
            id: headerComponent
            anchors.fill: parent
            visible: stackView.depth > 1
            onBackClicked: {
                stackView.pop();
            }
        }
    }

    /*footer: */Rectangle {
        id: bottomGradient
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        z: 1
        height: 30 + root.bottomGradientSize
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop {
                position: root.bottomGradientSize / bottomGradient.height;
                color: root.mainBgColor
            }
            GradientStop { position: 1.0; color: root.mainBgColor }
        }
    }

    StackView {
        id: stackView
        anchors {
            top: headerItem.bottom
            bottom: bottomGradient.top
            left: parent.left
            right: parent.right
        }
        initialItem: welcomePage

        WelcomePage {
            id: welcomePage
            visible: false
            mainBgColor: root.mainBgColor
            bottomGradientSize: root.bottomGradientSize
            onLogoClicked: {
                stackView.push(aboutPage)
            }
            onNewGameClicked: {
                stackView.push(levelsPage);
            }
            onSettingsClicked: {
                stackView.push(settingsPage)
            }
            onQuitClicked: {
                Qt.quit()
            }
        }
        AboutPage {
            id: aboutPage
            visible: false
            baseStackView: stackView
        }
        LevelsPage {
            id: levelsPage
            visible: false
            onStartGameClicked: function (size) {
                console.log("From " + stackView.currentItem)
                gamePage.startGame(size)
                stackView.push(gamePage)
            }
        }
        SettingsPage {
            id: settingsPage
            visible: false
        }
        GamePage {
            id: gamePage
            visible: false
            onFinished: {
                winPage.visible = true
            }
        }

        states: [
            State {
                when: stackView.currentItem == welcomePage
            },
            State {
                when: stackView.currentItem == aboutPage
                PropertyChanges {
                    target: headerComponent
                    pageName: "Our team"
                }
            },
            State {
                when: stackView.currentItem == levelsPage
                PropertyChanges {
                    target: headerComponent
                    pageName: "New game"
                }
            },
            State {
                when: stackView.currentItem == settingsPage
                PropertyChanges {
                    target: headerComponent
                    pageName: "Settings"
                }
            },
            State {
                when: stackView.currentItem == gamePage
                PropertyChanges {
                    target: headerComponent
                    pageName: "%1 x %1".arg(gamePage.areaSize)
                }
            }
        ]
    }

    WinPage {
        id: winPage
        visible: false
        anchors.fill: parent
        z: 1

        steps: gamePage.steps
        time: gamePage.time
        onContinueClicked: {
            stackView.pop();
        }
    }
}

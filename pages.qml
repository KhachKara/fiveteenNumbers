import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12

import "./Assets"

ApplicationWindow {
    id: root

    readonly property color mainBgColor: "#4B4453"

    visible: true
    width: 360
    height: 640
    color: mainBgColor
    /*header: */Item {
        id: headerItem
        anchors {
            left: parent.left
            right: parent.right
        }
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
    /*footer: */AdvertisePage {
        id: advertisePage
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 75
    }
    StackView {
        id: stackView
        anchors {
//            fill: parent
            top: headerItem.bottom
            bottom: advertisePage.top
            left: parent.left
            right: parent.right
        }
        initialItem: welcomePage

        WelcomePage {
            id: welcomePage
            visible: false
            anchors.fill: parent
            onLogoClicked: {
                stackView.push(aboutPage)
            }
            onNewGameClicked: {
                stackView.push(levelsPage);
            }
            onSettingsClicked: {
                stackView.push(settingsPage)
            }
            onRateClicked: {
                stackView.push(ratePage)
            }
            onQuitClicked: {
                Qt.quit()
            }
        }
        AboutPage {
            id: aboutPage
            visible: false
            anchors.fill: parent
            baseStackView: stackView
        }
        LevelsPage {
            id: levelsPage
            visible: false
            anchors.fill: parent
            onStartGameClicked: function (size) {
                console.log("From " + stackView.currentItem)
                gamePage.startGame(size)
                stackView.push(gamePage)
            }
        }
        RatePage {
            id: ratePage
            visible: false
            anchors.fill: parent
        }
        SettingsPage {
            id: settingsPage
            visible: false
            anchors.fill: parent
        }
        GamePage {
            id: gamePage
            visible: false
            anchors.fill: parent
            onFinished: {
                winPage.visible = true
            }
        }
        AuthorizationPage {
            id: authorizationPage
            visible: false
            anchors.fill: parent
            baseStackView: stackView
            areaSize: gamePage.areaSize
            steps: gamePage.steps
            timeSec: gamePage.timeSec
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
                when: stackView.currentItem == ratePage
                PropertyChanges {
                    target: headerComponent
                    pageName: "Rate"
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
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: stackView.bottom
        }

        steps: gamePage.steps
        time: gamePage.time
        onContinueClicked: {
            stackView.pop();
        }
        onRateMeClicked: {
            stackView.replace(ratePage);
            if (!core.isLogin) {
                stackView.push(authorizationPage);
            } else {
                core.addResult(gamePage.areaSize, gamePage.steps, gamePage.timeSec);
            }
        }
    }
}

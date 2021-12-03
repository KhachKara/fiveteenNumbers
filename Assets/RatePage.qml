import Common 43.21
import QtQuick 2.2


Item {
    id: root

    implicitWidth: ratePage.implicitWidth
    implicitHeight: ratePage.implicitHeight

    property string nickName: "unknown"



    GameArea {
        id: gameArea
        visible: false
    }

    GamePage {
        id: gamePage
        visible: false
    }

    Rectangle {
        id: ratePage

        anchors.fill: parent
        color: "#4B4453"

        Image {
            id: back
            source: "./icons/back.svg"
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: 30
                topMargin: 32
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                }
                onClicked: {
                    console.log("back")
                    welcomePage.visible = true
                    gameArea.enabled = true
                    gameArea.time = "00:00"
                }
            }
        }

        Text {
            id: txtRate
            text: qsTr("Rate")
            color: "#B0A8B9"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 32
            }
            font {
                family: "Ubuntu"
                pixelSize: 22
            }
        }

        Image {
            id: exit
            source: "./icons/exit.svg"
            anchors {
                top: parent.top
                right: parent.right
                rightMargin: 30
                topMargin: 32
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                }
                onClicked: {
                    Qt.quit()
                }
            }
        }

        Column {
            Repeater {
                model: 10
                Row {
                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: 30
                        topMargin: 90
                    }
                    Rectangle {
                        id: rateIndexRect
                        width: 20
                        height: width

                        anchors {
                            top: parent.top
                            left: parent.left
                        }

                        Text {
                            id: rateTxt

                            anchors.centerIn: parent
                            text: index
                        }
                    }
                    Rectangle {
                        id: nicknameRect
                        width: 30
                        height: 20

                        anchors {
                            top: parent.top
                            left: rateIndexRect.right
                        }

                        Text {
                            id: nickTxt

                            anchors.fill: parent
                            text: nickName
                        }
                    }
                    Rectangle {
                        id: steps
                        height: 20

                        anchors {
                            top: parent.top
                            left: nicknameRect.right
                        }
                    }
                    Rectangle {
                        id: time
                        width: 60
                        height: 20

                        anchors {
                            top: parent.top
                            left: steps.right
                        }
                    }
                }
            }
        }
    }
}

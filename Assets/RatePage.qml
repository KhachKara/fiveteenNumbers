import Common 43.21
import QtQuick 2.2


Item {
    id: root

    implicitWidth: ratePage.implicitWidth
    implicitHeight: ratePage.implicitHeight

    property string nickName: "unknown"

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
                    txtTimeValue.text = "00:00"
                }
            }
        }

        Text {
            id: txtNewGame
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
                        width: 20
                        height: width

                        anchors.fill: parent

                        Text {
                            id: rate1

                            anchors.centerIn: parent
                            text: index
                        }
                    }
                    Rectangle {
                        width: 30
                        height: 20
                    }
                    Text {
                        id: nickTxt
                        text: nickName
                    }
                    Rectangle {
                        id: steps
                        height: 20
                    }
                    Rectangle {
                        id: time
                        width: 60
                        height: 20
                    }
                }
            }
        }
    }
}

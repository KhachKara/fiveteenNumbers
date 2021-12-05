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
            id: rateColumn

            spacing: 24

            anchors {
                top: parent.top
                left: parent.left
                topMargin: 87
                leftMargin: 30
            }

            Repeater {
                model: 10

                Row {
                    id: rateRow

                    spacing: 20

                    Rectangle {
                        id: rateIndexRect

                        width: 20
                        height: 20

                        color: Qt.rgba(0,0,0,0)

                        Text {
                            id: rateTxt

                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            text: index + 1
                        }
                    }

                    Rectangle {
                        id: nicknameRect

                        width: 150
                        height: 20

                        color: Qt.rgba(0,0,0,0)

                        Text {
                            id: nickTxt

                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            text: nickName
                        }
                    }

                    Rectangle {
                        id: stepsRect

                        width: 35
                        height: 20

                        color: Qt.rgba(0,0,0,0)

                        Text {
                            id: stepsTxt

                            text: gameArea.stepCount
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Rectangle {
                        id: timeRect

                        width: 35
                        height: 20

                        color: Qt.rgba(0,0,0,0)

                        Text {
                            id: timeTxt

                            text: gameArea.gameTimeSec
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }


            Text {
                width: 2
                height: 2
                text: qsTr("...")
                font.pixelSize: 14
            }


            Row {
                id: myRate

                spacing: 20

                Rectangle {
                    id: myRateIndexRect

                    width: 20
                    height: width

                    color: Qt.rgba(0,0,0,0)

                    Text {
                        id: myRateTxt

                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        text: "9999"
                    }
                }

                Rectangle {
                    id: myNicknameRect

                    width: 150
                    height: 20

                    color: Qt.rgba(0,0,0,0)

                    Text {
                        id: myNickTxt

                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        text: nickName
                    }
                }

                Rectangle {
                    id: myStepsRect

                    width: 35
                    height: 20

                    color: Qt.rgba(0,0,0,0)

                    Text {
                        id: myStepsTxt

                        text: gameArea.stepCount
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Rectangle {
                    id: myTimeRect

                    width: 35
                    height: 20

                    color: Qt.rgba(0,0,0,0)

                    Text {
                        id: myTimeTxt

                        text: gameArea.gameTimeSec
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}

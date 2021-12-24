import QtQuick 2.2

Item {
    id: root


//    property alias rowS: rateRow.spacing

    property string nickName: "unknown"
//    readonly property alias steps: stepsTxt.text
//    readonly property alias time: timeTxt.text
//    readonly property alias myTime: myTimeTxt.text
//    readonly property alias mySteps: myStepsTxt.text

    Rectangle {
        id: ratePage

        Column {
            id: rateColumn

            spacing: 15

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

                            color: "#B0A8B9"
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

                            color: "#B0A8B9"
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

                            color: "#B0A8B9"
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

                            color: "#B0A8B9"
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }


            Text {
                width: 2
                height: 2
                color: "#B0A8B9"
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

                        color: "#B0A8B9"
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

                        color: "#B0A8B9"
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

                        color: "#B0A8B9"
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

                        color: "#B0A8B9"
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}

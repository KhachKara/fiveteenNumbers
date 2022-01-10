import QtQuick 2.2

Item {
    id: root

    implicitWidth: 162
    implicitHeight: 131

    function rate (gameSize, steps) {
        gameSize = gamePage.areaSize
        steps = gamePage.steps

        if (gameSize === 3 && steps <= 30 ) {
            return 3
        } else if (gameSize === 3 && steps <= 40 ) {
            return 2
        } else if (gameSize === 3 && steps <= 50 ) {
            return 1
        } else if (gameSize === 3 && steps > 50 ) {
            return 0
        } else if (gameSize === 4 && steps <= 100 ) {
            return 3
        } else if (gameSize === 4 && steps <= 200 ) {
            return 2
        } else if (gameSize === 4 && steps <= 300 ) {
            return 1
        } else if (gameSize === 4 && steps > 300 ) {
            return 0
        } else if (gameSize === 5 && steps <= 350 ) {
            return 3
        } else if (gameSize === 5 && steps <= 450 ) {
            return 2
        } else if (gameSize === 5 && steps <= 550 ) {
            return 1
        } else if (gameSize === 5 && steps > 550 ) {
            return 0
        } else {
            return 3
        }
    }

    property alias steps: txtStepsValue.text
    property alias time: txtTimeValue.text

    Image {
        id: firstStar
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 10
        }
        source: {
            if (rate() >= 1) {
                "./icons/filledStar.svg"
            } else {
                "./icons/emptyStar.svg"
            }
        }
    }

    Image {
        id: secondStar
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        source: {
            if (rate() >= 2) {
                "./icons/filledStar.svg"
            } else {
                "./icons/emptyStar.svg"
            }
        }

    }

    Image {
        id: thirdtStar
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 10
        }
        source: {
            if (rate() === 3) {
                "./icons/filledStar.svg"
            } else {
                "./icons/emptyStar.svg"
            }
        }
    }

    Text {
        id: txtSteps

        anchors {
            top: firstStar.bottom
            left: firstStar.left
            topMargin: 21
        }
        text: qsTr("Steps")
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    Text {
        id: txtStepsValue

        anchors {
            top: txtSteps.bottom
            bottom: parent.bottom
            left: firstStar.left
        }
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    Text {
        id: txtTime

        anchors {
            top: thirdtStar.bottom
            right: thirdtStar.right
            topMargin: 21
        }
        text: qsTr("Time")
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    Text {
        id: txtTimeValue

        anchors {
            top: txtTime.bottom
            right: thirdtStar.right
            bottom: parent.bottom
        }
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }
}

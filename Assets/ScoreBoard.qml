import Common 43.21
import QtQuick 2.2

Item {
    id: root

    width: 162
    height: 135

    Image {
        id: firstStar
        source: "./icons/filledStar.svg"
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 10
        }
    }

    Image {
        id: secondStar
        source: "./icons/filledStar.svg"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
    }

    Image {
        id: thirdtStar
        source: "./icons/emptyStar.svg"
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 10
        }
    }

    Text {
        id: txtSteps
        text: qsTr("Steps")

        anchors {
            top: firstStar.bottom
            left: firstStar.left
            topMargin: 21
        }
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    Text {
        id: txtStepsValue
        text: gameArea.stepCount

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
        text: qsTr("Time")

        anchors {
            top: thirdtStar.bottom
            right: thirdtStar.right
            topMargin: 21
        }
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    Text {
        id: txtTimeValue
        text: formatTime(gameArea.gameTimeSec)

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
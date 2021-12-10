import QtQuick 2.2

Item {
    id: root

    property alias steps: txtStepsValue.text
    property alias time: txtTimeValue.text

    width: 162
    height: 135

    Image {
        id: firstStar
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 10
        }
        source: "./icons/filledStar.svg"
    }

    Image {
        id: secondStar
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        source: "./icons/filledStar.svg"
    }

    Image {
        id: thirdtStar
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 10
        }
        source: "./icons/emptyStar.svg"
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

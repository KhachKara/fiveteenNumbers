import QtQuick 2.2

Item {
    id: root

    implicitWidth: 162
    implicitHeight: 131

    property int countStars: 0
    property alias steps: txtStepsValue.text
    property alias time: txtTimeValue.text

    function updateScore(_areaSize, _steps, _timeStr) {
        countStars = rate(_areaSize, _steps);
        steps = _steps;
        time = _timeStr;
    }

    function rate(gameSize, steps) {
        switch(gameSize) {
        case 2:
            return steps < 4 ? 3 : steps < 5 ? 2 : steps < 6 ? 1 : 0;
        case 3:
            return steps < 31 ? 3 : steps < 41 ? 2 : steps < 51 ? 1 : 0;
        case 4:
            return steps < 100 ? 3 : steps < 200 ? 2 : steps < 300 ? 1 : 0;
        case 5:
            return steps < 350 ? 3 : steps < 450 ? 2 : steps < 550 ? 1 : 0;
        case 6:
            return steps < 2 * 350 ? 3 : steps < 2 * 450 ? 2 : steps < 2 * 550 ? 1 : 0;
        default:
            console.info('wtf', gameSize);
            return 2;
        }
    }

    Image {
        id: firstStar
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 10
        }
        source: {
            if (countStars >= 1) {
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
            if (countStars >= 2) {
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
            if (countStars === 3) {
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

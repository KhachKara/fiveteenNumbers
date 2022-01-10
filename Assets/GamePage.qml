import QtQuick 2.2
import QtQml 2.2

Item {
    id: root

    readonly property alias steps: txtStepsValue.text
    readonly property alias time: txtTimeValue.text
    readonly property alias timeSec: gameArea.gameTimeSec
    readonly property alias areaSize: gameArea.size
    property alias  pause: gameArea.pause

    signal started()
    signal finished()

    clip: true

    function startGame(size) {
        gameArea.initGame(size);
    }

    function startGameArray(array) {
        gameArea.initGameArray(array);
    }

    function recoveryGame(arrayStr, steps, timeSec) {
        console.log(arrayStr);
        let array = arrayStr.split(",").map(Number);
        gameArea.initGameArray(array, steps, timeSec);
    }

    function formatTime(sec) {
        let m = Math.floor(sec / 60);
        let s = sec % 60;
        return '%1:%2'.arg(m).arg(s > 9 ? s : '0' + s)
    }

    component MyText: Text {
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    MyText {
        id: txtSteps
        anchors {
            bottom: txtStepsValue.top
            left: parent.left
            bottomMargin: 3
            leftMargin: 30
        }
        text: qsTr("Steps")
    }
    MyText {
        id: txtStepsValue
        anchors {
            bottom: gameArea.top
            left: parent.left
            bottomMargin: 3
            leftMargin: 30
        }
        text: gameArea.stepCount
    }

    MyText {
        id: txtTime
        anchors {
            bottom: txtTimeValue.top
            right: parent.right
            bottomMargin: 3
            rightMargin: 30
        }
        text: qsTr("Time")
    }
    MyText {
        id: txtTimeValue
        anchors {
            bottom: gameArea.top
            right: parent.right
            bottomMargin: 3
            rightMargin: 30
        }
        text: formatTime(gameArea.gameTimeSec)
    }

    GameArea {
        id: gameArea

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 30
            rightMargin: gameArea.anchors.leftMargin
            bottomMargin: 5
        }
        height: Math.min(width, parent.height - 2 * (txtSteps.height + txtSteps.anchors.bottomMargin))
        squareUrl: "NewSquare.qml"

        onStarted: {
            core.removeGame();
            root.started();
        }
        onFinished: {
            core.removeGame();
            root.finished();
        }

        onStepCountChanged: {
            let areaStr = getGamePosition();
            if (areaStr.length > 0) {
                core.saveGame(getGamePosition(), stepCount, gameTimeSec);
            }
        }
        onGameTimeSecChanged: {
            core.saveTimeSec(gameTimeSec);
        }
    }
}

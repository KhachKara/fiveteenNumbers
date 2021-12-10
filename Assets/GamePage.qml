import QtQuick 2.15

Rectangle {
    id: root

    readonly property alias steps: txtStepsValue.text
    readonly property alias time: txtTimeValue.text
    readonly property alias areaSize: p.areaSize

    signal started()
    signal finished()

    color: "#4B4453"

    function startGame(size) {
        p.areaSize = size;
        gameArea.initGame(size);
        root.started()
    }

    function startGameArray(array) {
        gameArea.initGameArray(array);
        initOtherFields();
    }

    function formatTime(sec) {
        let m = Math.floor(sec / 60);
        let s = sec % 60;

        return '%1:%2'.arg(m).arg(s > 9 ? s : '0' + s)
    }

    QtObject {
        id: p
        property int areaSize: -1
    }

    Text {
        id: txtSteps
        text: qsTr("Steps")

        anchors {
            top: parent.top
            left: parent.left
            topMargin: 184
            leftMargin: 30
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
            left: parent.left
            topMargin: 3
            leftMargin: 30
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
            top: parent.top
            right: parent.right
            topMargin: 184
            rightMargin: 30
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
            right: parent.right
            topMargin: 3
            rightMargin: 30
        }
        color: "#B0A8B9"
        font {
            family: "Ubuntu"
            pixelSize: 18
        }
    }

    GameArea {
        id: gameArea

        anchors {
            fill: parent
            leftMargin: 30
            rightMargin: gameArea.anchors.leftMargin
            topMargin: 259
            bottomMargin: 81
        }
        squareUrl: "NewSquare.qml"

        onFinished: {
            root.finished()
        }
    }
}

import QtQuick 2.15

Rectangle {
    id: root

    signal started()
    signal finished()

    anchors.fill: parent

    property alias steps: txtStepsValue.text
    property alias text: txtTimeValue.text

    color: "#4B4453"

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

    property string gameSize: ""
    Text {
        id: txtGameStyle
        text: gameSize + " x " + gameSize
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


    function initOtherFields() {
        gameArea.visible = 1;
    }

    function startGame(size) {
        gameArea.initGame(size);
        initOtherFields();
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
            console.log('Game Over! ! !')
            txtTimeValue.text = toString(gameArea.gameTimeSec)
            root.finished()
        }
    }
}

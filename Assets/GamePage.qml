import QtQuick 2.15

Rectangle {
    id: gamePage
    implicitHeight: gameArea.implicitHeight
    implicitWidth: gameArea.implicitWidth

    anchors.fill: parent
    color: "#4B4453"

    GameStyleRect {
        id: gameStyleRect

        visible: false
    }


    Image {
        id: pause
        source: "./icons/pause.svg"
        anchors {
            top: parent.top
            left: back.right
            leftMargin: 10
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
                console.log("pause")
            }
        }
    }

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
                newGamePage.visible = true
                gameArea.enabled = true
                txtGameOver.visible = false
                txtTimeValue.text = "00:00"
            }
        }
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
        text: "00:00"

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
    }

    function startGameArray(array) {
        gameArea.initGameArray(array);
        initOtherFields();
    }

    GameArea {
        id: gameArea

        anchors {
            fill: parent
            leftMargin: 30
            rightMargin: 30
            topMargin: 259
            bottomMargin: 81
        }
        onFinished: {
            console.log('Game Over! ! !')
            txtGameOver.visible = true
            txtTimeValue.text = toString(gameArea.gameTimeSec)
            gameArea.enabled = false
            txtGameOver.visible = true
        }
    }

    // ---------------- Khach -----------------

    Text {
        id: txtGameOver
        text: qsTr("Game Over")
        font {
            pixelSize: 40
            bold: true
        }
        color: Qt.rgba(255,255,255,0.8)
        visible: false
        anchors.centerIn: gameArea
    }
}

import QtQuick 2.15

Rectangle {
    id: root

    implicitHeight: gameArea.implicitHeight
    implicitWidth: gameArea.implicitWidth

    property alias time: txtTimeValue.text
    property alias steps: txtStepsValue.text
    property alias text: txtTimeValue.text

    anchors.fill: parent
    color: "#4B4453"


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
                txtTimeValue.text = "00:00"
            }
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
            pause.visible = false
            winPage.visible = true
        }
    }

    WinPage {
        id: winPage

        anchors {
            top: parent.top
            bottom: parent.bottom
            topMargin: 134
            bottomMargin: 60
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
        }
    }
}

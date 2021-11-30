import QtQuick 2.0

Rectangle {
    id: root
    implicitHeight: gameArea.implicitHeight
    implicitWidth: gameArea.implicitWidth

    anchors.fill: parent
    color: "#4B4453"

    function initOtherFields() {
        gameArea.visible = 1;
        //        infoBoard.visible = 1;
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

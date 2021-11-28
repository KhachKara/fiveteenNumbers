import QtQuick 2.0

Item {
    id: root
    implicitHeight: gameArea.implicitHeight
    implicitWidth: gameArea.implicitWidth

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
        color: Qt.rgba(208,141,45,0.5)
        visible: false
        anchors.centerIn: gameArea
    }
}

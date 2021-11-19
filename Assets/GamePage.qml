import QtQuick 2.0

Item {
    id: root
    implicitHeight: gameArea.implicitHeight + infoBoard.implicitHeight
    implicitWidth: gameArea.implicitWidth + infoBoard.implicitWidth

    function initOtherFields() {
        gameArea.visible = 1;
        infoBoard.visible = 1;
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

        visible: false
        anchors {
            left: root.left
            right: infoBoard.left
            top: root.top
            bottom: root.bottom
        }
    }

    InfoBoard {
        id: infoBoard

        visible: false
        anchors {
            bottom: root.bottom
            top: root.top
            right: root.right
            margins: ProjectStyles.projectMargins
        }
    }
}

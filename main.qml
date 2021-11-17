import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15
import "./Assets/componentCreation.js" as SquareCreationScript

Window {
    id: root

    minimumWidth: ProjectStyles.gameSide + ProjectStyles.infoBoardWidth
    minimumHeight: ProjectStyles.gameSide
    maximumWidth: ProjectStyles.gameSide + ProjectStyles.infoBoardWidth
    maximumHeight: ProjectStyles.gameSide

    visible: true
    title: qsTr("15 Numbers")

    GameArea {
        id: gameArea

        visible: false
        anchors {
            left: root.left
            top: root.top
            bottom: root.bottom
        }
    }

    InfoBoard {
        id: infoBoard

        visible: false
        anchors {
            left: gameArea.right
            bottom: root.bottom
            top: root.top
            right: root.right
            margins: ProjectStyles.projectMargins
        }
    }

    WelcomePage {
        id: welcomePage
        anchors.fill: parent
        onStartedGame: function(size){
            console.log('size = ', size);
            gameArea.initGame(size);
        }
    }
    Component.onCompleted: {
        console.log(_arguments);
        if (_arguments.length === 1) {
            return;
        }
        let numbers = _arguments.slice(1);
        let size = Math.sqrt(numbers.length)
        if (size !== parseInt(size)) {
            console.log('Не верный формат аргументов');
            return;
        }
        gameArea.initGameArray(numbers);
        welcomePage.visible = false;
    }
}

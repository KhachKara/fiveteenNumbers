import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15
import "./Assets/componentCreation.js" as SquareCreationScript

Window {
    id: root

    minimumWidth: ProjectStyles.gameSide
    minimumHeight: ProjectStyles.gameSide
    maximumWidth: ProjectStyles.gameSide
    maximumHeight: ProjectStyles.gameSide

    visible: true
    title: qsTr("15 Numbers")

    GameArea {
        id: gameArea
        anchors.fill: parent
    }

    WelcomePage {
        id: welcomePage
        anchors.fill: parent
        onStartedGame: {
            gameArea.initGame(size);
        }
    }
    Component.onCompleted: {
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

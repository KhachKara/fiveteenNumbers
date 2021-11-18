import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15
import "./Assets/componentCreation.js" as SquareCreationScript

Window {
    id: root

    width: 400
    height: 400

    visible: true
    title: qsTr("15 Numbers")

    GamePage {
        id: game
        anchors.fill: parent
    }


    WelcomePage {
        id: welcomePage
        anchors.fill: parent
        onStartedGame: function(size){
            game.startGame(size);
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

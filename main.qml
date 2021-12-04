import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15
import "./Assets/componentCreation.js" as SquareCreationScript

Window {
    id: root

    width: 360
    height: 640

    visible: true
    title: qsTr("15 Numbers")

    WelcomePage {
        id: welcomePage

        anchors.fill: parent
        onStartedGame: function(size){
            game.startGame(size);
        }
    }
}

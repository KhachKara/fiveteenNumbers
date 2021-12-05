import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root

    width: 360
    height: 640

    visible: true
    title: qsTr("15 Numbers")

    TemplatePage {
        id: templatePage

        anchors.fill: parent
        onStartedGame: function(size){
            game.startGame(size);
        }
        Component.onCompleted: templatePage.state = "welcomePage"

    }
}

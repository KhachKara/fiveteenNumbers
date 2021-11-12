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
        anchors.fill: parent
        onStartedGame: {
            gameArea.initGameDemo(size);
        }
    }
}

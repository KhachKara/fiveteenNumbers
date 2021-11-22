import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    implicitWidth: gamePage.implicitWidth
    implicitHeight: gamePage.implicitHeight

    function startGame(size) {
        gameArea.initGame(size);
        initOtherFields();
    }

    function startGameArray(array) {
        gameArea.initGameArray(array);
        initOtherFields();
    }

    Rectangle {
        id: gamePage

        anchors.fill: parent
        color: "#4B4453"

        GameArea {
            id: gameArea

            visible: false
            anchors.centerIn: parent
        }
    }
}

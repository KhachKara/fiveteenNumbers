import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root
    signal startGameClicked(int size)
    clip: true

    ListView {
        id: listView
        anchors.horizontalCenter: parent.horizontalCenter
        width: 140
        height: parent.height
        spacing: 8
        model: 3
        delegate: GameStyleRect {
            width: listView.width
            gameSize: index + 2
            txtGameMode: gameSize + "x" + gameSize
            CursorShapeMouseArea {
                anchors.fill: parent
                onClicked: {
                    root.startGameClicked(gameSize)
                }
            }
        }
    }
}

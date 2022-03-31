import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: root
    signal startGameClicked(int size)
    property real headerGradientSize: 0
    property real bottomGradientSize: 0

    ListView {
        id: listView
        width: 140
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: -root.headerGradientSize
            bottom: parent.bottom
            bottomMargin: -root.bottomGradientSize
        }
        bottomMargin: root.bottomGradientSize

        Binding on topMargin {
            value: Math.max(listView.height - (listView.contentHeight
                                               + root.headerGradientSize)
                            , root.headerGradientSize)
            delayed: true
        }

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

import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    implicitWidth: welcomePage.implicitWidth
    implicitHeight: welcomePage.implicitHeight

    Rectangle {
        id: welcomePage

        implicitWidth: ProjectStyles.gameSide
        implicitHeight: ProjectStyles.gameSide

        color: Qt.rgba(1, 1, 1, 0.95)

        anchors.fill: parent

        Button {
            id: newGameBtn

            anchors.centerIn: parent
            text: "New Game"

            onClicked: {
                GameArea.activeFocus = true
                welcomePage.visible = false

                if (rbt1.checked === true) {
                    ProjectStyles.columnRowCount = 3
                } else if (rbt3.checked === true) {
                    ProjectStyles.columnRowCount = 5
                }
            }
        }

        Row {
            spacing: 20
            anchors {
                top: newGameBtn.bottom
                horizontalCenter: newGameBtn.horizontalCenter
                topMargin: 20
            }
            RadioButton {
                id: rbt1
                text: "3 X 3"
            }
            RadioButton {
                id: rbt2
                checked: true
                text: "4 X 4"
            }
            RadioButton {
                id: rbt3
                text: "5 X 5"
            }
        }
    }
}

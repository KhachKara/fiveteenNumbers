import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    implicitWidth: infoBoard.implicitWidth
    implicitHeight: infoBoard.implicitHeight

    Rectangle {
        id: infoBoard

        implicitWidth: 130
        implicitHeight: 400
        anchors.fill: parent
        radius: width * 0.1
        color: "lightgrey"
        Row {
            spacing: ProjectStyles.projectMargins
            anchors {
                top: parent.top
            }

            Text {
                id: lblSteps
                text: "Steps"
                font.pixelSize: ProjectStyles.infoTextFontPixel
            }
            Text {
                id: valueSteps
                text: qsTr("text")
                font.pixelSize: ProjectStyles.infoTextFontPixel
            }
        }
    }
}

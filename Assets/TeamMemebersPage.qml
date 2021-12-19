import QtQuick 2.0

Item {
    id: root

    anchors.fill: parent

    Column {
        id: staffColumn

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        spacing: 5
        Text {
            id: design
            text: "<i><u>Design by Anastacia Karapetyan</u></i>"
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 16
            }
            CursorShapeMouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://www.behance.net/bo4koanast8de6")
                }
            }
        }
        Text {
            id: backend

            color: "#B0A8B9"
            text: qsTr("Backend  by Mher Karapetyan")
            font {
                family: "Ubuntu"
                pixelSize: 16
            }
        }
        Text {
            id: frontend

            text: qsTr("Frontend by Khachatur Karapetyan")
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 16
            }
        }
    }
}

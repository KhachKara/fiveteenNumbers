import QtQuick 2.0

Item {
    id: root

    anchors.fill: parent

    Rectangle {
        id: aboutPage

        anchors.fill: parent
        color: "#4B4453"

        Column {
            id: staffColumn

            anchors {
                top: parent.top
                left: parent.left
                topMargin: 87
                leftMargin: 30
            }
            spacing: 5
            Text {
                id: design
                text: qsTr("design")

                color: "#B0A8B9"
                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
            Text {
                id: backend

                color: "#B0A8B9"
                text: qsTr("backend")
                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
            Text {
                id: frontend

                text: qsTr("frontend")
                color: "#B0A8B9"
                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
        }

        FeedbackForm {
            id: feedbackForm

            anchors {
                top: parent. bottom
                left: parent.left
                right: parent.right
                leftMargin: 30
                rightMargin: 30
            }
        }
    }
}
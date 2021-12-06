import QtQuick 2.0

Item {
    id: root

    implicitWidth: aboutPage.implicitWidth
    implicitHeight: aboutPage.implicitHeight

    Rectangle {
        id: aboutPage

        anchors.fill: parent

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

                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
            Text {
                id: backend
                text: qsTr("backend")

                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
            Text {
                id: frontend
                text: qsTr("frontend")

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
    // #убрать ---------
    Text {
        id: name
        anchors.top: aboutPage.bottom
        text: qsTr("aboutPage")
    }
    // -----------------
}

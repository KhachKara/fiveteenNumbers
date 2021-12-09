import QtQuick 2.0

Item {

    signal facebookClicked()
    signal googleClicked()
    signal appleClicked()

    width: 230
    height: 65

    Row {
        anchors.centerIn: parent
        spacing: 21
        Image {
            id: facbook
            source: "./icons/facebook.svg"

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onClicked: {
                    facebookClicked()
                }
            }
        }

        Image {
            id: google
            source: "./icons/Google.svg"

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onClicked: {
                    googleClicked()
                }
            }
        }

        Image {
            id: apple
            source: "./icons/apple.svg"

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onClicked: {
                    appleClicked()
                }
            }
        }
    }
}

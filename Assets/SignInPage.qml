import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root

    signal logoClicked()
    signal enterButton()
    signal skip()


    Image {
        id: logo

        source: "./icons/logo.svg"
        sourceSize.width: 113
        sourceSize.height: 127
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 67
        }

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
                root.logoClicked()
            }

        }
    }

    Rectangle {
        id: nickNameResct

        width: 300
        height: 70
        radius: 8

        anchors {
            top: logo.bottom
            left: parent.left
            right: parent.right
            topMargin: 50
            leftMargin: 30
            rightMargin: 30
        }

        TextInput {
            id: nickNameInp

            anchors.centerIn: parent
            echoMode: TextInput.Normal
            text: "nickname"
            color: "#CCCCCC"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
        }
        MouseArea {
            property int k: 0

            anchors.fill: nickNameResct
            hoverEnabled: true
            onEntered: {
                cursorShape = Qt.IBeamCursor
                focus: true
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                if(k === 0) {
                    nickNameInp.text = ""
                    ++k
                }
            }

        }
    }

    Rectangle {
        id: passwordRect

        width: 300
        height: 70
        radius: 8

        anchors {
            top: nickNameResct.bottom
            left: parent.left
            right: parent.right
            topMargin: 11
            leftMargin: 30
            rightMargin: 30
        }

        TextInput {
            id: passwordInp

            anchors.centerIn: parent
            echoMode: TextInput.Password
            text: "password"
            color: "#CCCCCC"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
        }
        MouseArea {
            anchors.fill: passwordRect
            hoverEnabled: true
            onEntered: {
                cursorShape = Qt.IBeamCursor
                focus: true
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }

            onClicked: {
                passwordInp.text = ""
            }

        }
    }

    SocialNetwork {
        id: socialNetwork

        anchors {
            top: passwordRect.bottom
            left: parent.left
            right: parent.right
            topMargin: 14
            leftMargin: 70
            rightMargin: 70
        }
    }

    Rectangle {
        id: entreBtn
        width: 300
        height: 70
        color: "#845EC2"
        radius: 8

        anchors {
            top: socialNetwork.bottom
            left: parent.left
            right: parent.right
            topMargin: 11
            leftMargin: 30
            rightMargin: 30
        }
        Text {
            anchors.centerIn: parent
            color: "#FFFFFF"
            text: "Enter"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
        }



        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                entreBtn.color = "#8400C2"
                cursorShape = Qt.PointingHandCursor
            }

            onExited: {
                entreBtn.color = "#845EC2"
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                root.enterButton()
            }
        }
    }

    Rectangle {
        id: skipRect

        width: 300
        height: 37
        color: Qt.rgba(0,0,0,0)

        anchors {
            top: entreBtn.bottom
            left: parent.left
            right: parent.right
            topMargin: 11
            leftMargin: 30
            rightMargin: 30
        }
        Text {
            id: skipTxt

            anchors.centerIn: parent
            text: qsTr("skip")
            color: "#FFFFFF"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onEntered: {
                skipTxt.color = "#8400C2"
                cursorShape = Qt.PointingHandCursor
            }

            onExited: {
                skipTxt.color = "#CCCCCC"
                cursorShape = Qt.ArrowCursor
            }

            onClicked: {
                root.skip()
            }
        }
    }
}


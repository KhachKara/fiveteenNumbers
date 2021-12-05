import QtQuick 2.0

Item {
    id: root

    signal startedGame(int size)

    Rectangle {
        id: templatePage

        anchors.fill: parent
        color: "#4B4453"

        states: [
               State {
                   name: "welcomePage"
                   PropertyChanges {
                       target: welcomePage
                       color: "red"
                   }
               }
           ]

    }

}

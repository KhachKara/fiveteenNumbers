import QtQuick 2.0
import QtQuick.Controls 2.5


Item {
    id: aboutPage

    FeedbackForm {
        id: feedbackForm

        anchors.fill: parent
        visible: true
    }
    TeamMemebersPage {
        id: teamMemebersPage

        anchors.fill: parent
        visible: true
    }


    StackView {
        id: aboutPageStack

        anchors.fill: parent
        initialItem: teamMemebersPage
    }
}



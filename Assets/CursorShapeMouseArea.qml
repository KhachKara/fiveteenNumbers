import QtQuick 2.0

MouseArea {
    hoverEnabled: true

    onEntered: {
        cursorShape = Qt.PointingHandCursor;
    }
    onExited: {
        cursorShape = Qt.ArrowCursor;
    }
}

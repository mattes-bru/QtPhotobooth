import QtQuick 2.0
import QtMultimedia 5.5

Item {
    id: rootItem
    anchors.fill: parent

    property alias countdown: countdownText.text
    property alias source: preview.source


    //signal finished(var images);



    Timer {
        id: flashReset
        repeat: false
        interval: 200
        onTriggered:  {
            flashRect.visible = false;
        }
    }



    function flash() {
        flashRect.visible = true;
        flashReset.start()
    }

    VideoOutput {
        id: preview
        anchors.fill: parent

    }



    Text {
        id: countdownText
        anchors.centerIn: parent
        font.pointSize: 64
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        text: triggerTimer.count

    }





    Rectangle {
        anchors.fill: parent
        color: "white"
        id: flashRect

        visible: false

    }

}

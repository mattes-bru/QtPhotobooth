import QtQuick 2.0
import QtMultimedia 5.5
import QtGraphicalEffects 1.0


Item {
    id: rootItem

    signal begin()

    property alias source: blur.source



    FastBlur {
        id: blur
        anchors.fill: parent
        source: preview
        radius: 32
    }




    Text {
        color: "#ffffff"

        text: qsTr("Klicken zum beginnen!")
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 18
        anchors.fill: parent

    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            rootItem.begin();
        }

    }

}

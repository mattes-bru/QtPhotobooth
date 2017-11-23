import QtQuick 2.0

Rectangle {
    id: rootItem

    color: "white"
    //anchors.fill: parent
    height: parent.height
    width: height * (landscape ? 1.0/formatRatio : formatRatio)

    property double formatRatio: 2/3
    property bool landscape: true

    property variant images: null

    signal finished


    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        color: "black"




        Grid {
            id: imageGrid
            columns: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.margins: 10

            spacing: 10

            Image {
                width: rootItem.width/2.0 -20
                fillMode: Image.PreserveAspectFit
                source: images ? "file:/" + images[0] : ""

            }
            Image {
                width: rootItem.width/2.0 -20
                fillMode: Image.PreserveAspectFit
                source: images ? "file:/" + images[1] : ""

            }
            Image {
                width: rootItem.width/2.0 -20
                fillMode: Image.PreserveAspectFit
                source: images ? "file:/" + images[2] : ""

            }
            Image {
                width: rootItem.width/2.0 -20
                fillMode: Image.PreserveAspectFit
                source: images ? "file:/" + images[3] : ""

            }
        }

        Rectangle {
            anchors.top: imageGrid.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            color: "white"

            Text {
                id: label
                text: "Hier könnte Ihre Werbung stehen ;-)"
                font.bold: true
                font.pointSize: 32
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
            }


        }
    }



    onImagesChanged: {
        console.log("now showing: " + images )
        if(images.length === 4) {
            console.log("Saving combined image");
            rootItem.grabToImage(function(result) {
                result.saveToFile("/Users/kll/photobooth.png");
            });
        }
    }


    Timer {
        id: timeout
        repeat: false
        running: rootItem.visible
        interval: 30000

        onTriggered: {
            rootItem.finished();
        }

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            rootItem.finished();
        }
    }

    Component.onCompleted:  {

    }


}

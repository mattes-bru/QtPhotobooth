import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.6

Window {
    visible: true
    color: "black"
    width: 1280
    height: 720



    Camera {
        id: cam

        property int count: 0
        property variant images

        imageCapture {
            onImageCaptured: {
                console.log("Image captured");
                //previewImage.source = preview;

            }
            onImageSaved: {
                console.log("Image saved: " + path);
                cam.images.push(path);
                cam.count++;
                if(cam.count == 4) {
                    //finish
                    triggerTimer.stop();
                    //main.state = "idle"
                    console.log("Finished, images are: " , images);
                    presentation.images = images;
                    main.state = "presenting";


                }
            }
        }

    }

    Timer {
        id: triggerTimer
        repeat: true
        interval: 1000
        property int count: 3
        onTriggered:  {
            count--;
            if(count == 0) {
                if(cam.imageCapture.ready) {
                    live.flash();
                    cam.imageCapture.capture();
                    count = 3;
                }
                else {
                    console.log("Cam not ready...waiting...")
                    count = 0;
                }


            }


        }
    }



    Item {
        id: main
        anchors.fill: parent


        state: "idle"


        states: [
            State {
                name: "idle"

            },
            State {
                name: "active"
                PropertyChanges {
                    target: welcome
                    visible: false


                }
                PropertyChanges {
                    target: live
                    visible: true
                }
                PropertyChanges {
                    target: liveView
                    visible: true
                }

            },
            State {
                name: "presenting"
                PropertyChanges {
                    target: welcome
                    visible: false

                }
//                PropertyChanges {
//                    target: live
//                    visible: false
//                }
               PropertyChanges {

                   target:  presentation
                   visible: true
               }

            }
        ]

        VideoOutput {
            id: liveView
            anchors.fill: parent
            source: cam
            visible: false

        }


        WelcomeScreen {
            id: welcome
            anchors.fill: parent
            visible: true;
            source: liveView

            onBegin: {
                parent.state = "active";
            }
        }

        PhotoScreen {
            id: live
            visible: false

            //source: cam
            countdown: triggerTimer.count


            onVisibleChanged:  {
                if(visible) {
                    //new round
                    cam.count = 0;
                    cam.images = new Array();
                    triggerTimer.start();
                }
            }

        }



        PresentationScreen {
            id: presentation
            visible: false

            anchors.centerIn: parent

            onFinished:  {
                parent.state = "idle"
            }


        }



    }

}

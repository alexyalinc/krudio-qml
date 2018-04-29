import QtQuick 2.5
import QtQuick.Controls 2.0
import "ui"

Item {
    property alias albumImage: albumImage
    property alias albumImageLoading: albumImageLoading
    property alias titleSong: titleSong
    property alias buttonBack: buttonBack
    property alias buttonPlayPause: buttonPlayPause
    property alias buttonNext: buttonNext
    property alias buttonSearch: buttonSearch
    property alias buttonAddFavourites: buttonAddFavourites
    property alias volume: volume
    property alias buttonCategory: buttonCategory
    property alias buttonStations: buttonStations
    property alias buttonFavourites: buttonFavourites
    property alias listsView: listsView
    property alias listCategory: listCategory
    property alias listStations: listStations
    property alias listFavourites: listFavourites
    property alias lineView: lineView
    Column{
        anchors.fill: parent
        Row {
            id: playerControl
            width: parent.width
            anchors.left:parent.left

            Rectangle {
                id: rectAlbum
                width: parent.width/2
                height: (infoAndControl.height>(albumImage.height+20))?infoAndControl.height:(albumImage.height+20)
                color: "#00000000"

                Image {
                    id: albumImage
                    width: 150
                    height: 150
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/icons/no-image-icon.png"
                    z:1
                }
                Image {
                    id: albumImageLoading
                    width: 150
                    height: 150
                    z:0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/icons/image-loading.png"
                }
            }

            Column {
                id: infoAndControl
                width: parent.width/2
                height: ((titleSong.height+controlButton.height+volume.height)>(albumImage.height+20))?(titleSong.height+controlButton.height+volume.height):(albumImage.height+20)
                Column{
                    height: ((titleSong.height+controlButton.height+volume.height)>(albumImage.height+20))?(titleSong.height+controlButton.height+volume.height):(albumImage.height+20)

                    anchors.left:parent.left
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    Label {
                        id: titleSong
                        width: parent.width
                        height: parent.height-controlButton.height-volume.height
                        text: qsTr("Name song")
                        font.pointSize: 10
                        font.family: "Tahoma"
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Row {
                        id: controlButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 5

                        KrButton {
                            id: buttonBack
                            iconURL: "qrc:/icons/media-skip-backward.svg"
                        }
                        KrButton {
                            id: buttonPlayPause
                            iconURL: "qrc:/icons/media-playback-start.svg"
                        }
                        KrButton {
                            id: buttonNext
                            iconURL: "qrc:/icons/media-skip-forward.svg"
                        }
                        KrButton {
                            id: buttonSearch
                            iconURL: "qrc:/icons/search.svg"
                        }
                        KrButton {
                            id: buttonAddFavourites
                            iconURL: "qrc:/icons/list-add.svg"
                        }
                    }

                    Slider {
                        id: volume
                        width: controlButton.width+12
                        anchors.horizontalCenter: parent.horizontalCenter
                        value: 0.5
                    }
                }
            }
        }
        Row{
            id: tabBarPlay
            width: parent.width
            anchors.left:parent.left
            z:1
            KrButton {
                id:buttonCategory
                width: parent.width/3
                text: qsTr("Category")
                center:true
                bg.radius: 0
                active: listsView.currentIndex==0
            }

            KrButton {
                id:buttonStations
                width: parent.width/3
                text: qsTr("Stations")
                center:true
                bg.radius: 0
                active: listsView.currentIndex==1
            }

            KrButton {
                id:buttonFavourites
                width: parent.width/3
                text: qsTr("Favourites")
                center:true
                bg.radius: 0
                active: listsView.currentIndex==2
            }
        }
        Rectangle{
            id:lineView
            width: parent.width
            height:4
            anchors.left:parent.left
            z:1
        }

        SwipeView{
            id:listsView
            z:0
            clip: true
            width: parent.width
            height:krWindow.height - playerControl.height-tabBar.height-tabBarPlay.height
            topPadding: 0.1
            anchors.left:parent.left
            ListView {
                id: listCategory
                interactive: true
                boundsBehavior: Flickable.DragAndOvershootBounds
                highlightFollowsCurrentItem: true
                ScrollBar.vertical: ScrollBar {
                    id: hbarCategory;
                    active:true
                }
                model:ListModel{}
            }
            ListView {
                id: listStations
                ScrollBar.vertical: ScrollBar {
                    id: hbarStations;
                    active:true
                }
                model:ListModel{}
            }
            ListView {
                id: listFavourites
                ScrollBar.vertical: ScrollBar {
                    id: hbarFavourites;
                    active:true
                }
                model:ListModel{}
            }
        }
    }

}


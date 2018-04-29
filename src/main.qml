import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import cpp.krudio 2.0
import "ui"

Window {
    id:krWindow
    visible: true
    width: 380
    height: 470
    title: qsTr("Krudio")
    property var category:[]
    property var stations:[]
    property var favourites:[]
    ListModel {id:globalModelCategory}
    ListModel {id:globalModelStations}
    ListModel {id:globalModelFavourites}
    property alias krudio:krudio
    Krudio{id:krudio}

    Column{
        width:parent.width

        Row{
            id: tabBar
            width: parent.width
            KrButton {
                width: parent.width/3
                text: qsTr("Player")
                iconURL:"qrc:/icons/media-playback-start.svg"
                center:true
                bg.radius: 0
                active: pagesView.currentIndex==0
                onClick: {
                    pagesView.setCurrentIndex(0)
                }
            }

            KrButton {
                width: parent.width/3
                text: qsTr("Edit")
                iconURL:"qrc:/icons/document-edit.svg"
                center:true
                bg.radius: 0
                active: pagesView.currentIndex==1
                onClick: {
                    pagesView.setCurrentIndex(1)
                }
            }

            KrButton {
                width: parent.width/3
                text: qsTr("Settings")
                iconURL:"qrc:/icons/configure.svg"
                center:true
                bg.radius: 0
                active: pagesView.currentIndex==2
                onClick: {
                    pagesView.setCurrentIndex(2)
                }
            }
        }



        SwipeView {
            id:pagesView
            height:parent.height-tabBar.height
            width:parent.width
            Rectangle{
                PagePlay{anchors.fill: parent}
            }
            Rectangle{
                EditStations{anchors.fill: parent}
            }
            Rectangle{
                Text{
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    text:"WAIT NEXT UPDATE"
                }

            }
        }


    }
}

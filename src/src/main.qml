import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import krudioqml 1.0
import krudioqmltray 1.0
import "MenuBar"
import "PlayerView"
import "PageEdit"

ApplicationWindow {
    id:app
    property var    settings        : ({})
    property var    database        : ({})
    property var    favourites       : ({})
    property bool   statePlay       : false
    property alias  krudioqml       : krudioqml
    property alias  player          : player
    property alias  krudioqmltray   : krudioqmltray
    property alias  playerView      : playerView
    property alias  modelGroup      : modelGroup
    property alias  modelStation    : modelStation
    visible: true
    width: 350
    height: 480
    title: qsTr("Krudio qml")
    onClosing: app.visible = false
    Component.onCompleted: function(){
        settings        = JSON.parse(krudioqml.getJson("settings"));
        database        = JSON.parse(krudioqml.getJson("database"));
        favourites      = JSON.parse(krudioqml.getJson("favourites"));
    }
    KrudioQml{id:krudioqml}
    KrudioQmlTray{
        id:krudioqmltray;
        onTray_onClick: menuBar.playPause();
        onTray_onExit: Qt.quit();
        onTray_onMiddleClick: app.visible = !app.visible;
        onTray_showWindow: app.visible = true;
    }
    MediaPlayer{
        id:player
        onAudioRoleChanged:   function(){
            krudioqmltray.tray_showMessage("Krudio",player.metaData.title)
        }
    }

    ListModel {
        id: modelGroup
    }
    ListModel {
        id: modelStation
    }
    ListModel {
        id: modelFavourites
    }

    Rectangle{
        anchors.fill: parent
        color:settings.colors.bgWindow

        Rectangle{
            id:menuBarMain
            width: parent.width
            height: 33
            MenuBar{id:menuBar}
        }

        Rectangle{
            y:menuBarMain.height
            width: parent.width
            height: parent.height - menuBarMain.height
            color:"#00000000"
            SwipeView {
                id: pageView
                interactive: false
                anchors.fill: parent
                Rectangle{
                    color:"#00000000"
                    PlayerView{
                        id:playerView
                    }
                }
                Rectangle{
                    color:"#00000000"
                    PageEdit{}
                }

            }

        }
    }
}

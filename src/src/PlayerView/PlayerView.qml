import QtQuick 2.9
import QtQuick.Controls 2.2
import "../Button"
PlayerViewForm {
    id:playerView
    property string currentView: "listStation"
    nameSongText.text: qsTr(player.metaData.title !== undefined ? player.metaData.title : "");
    nameSongText.onTextChanged: function(){
        loadUrlAlbum(player.metaData.title);
        krudioqmltray.tray_showMessage("Krudio", player.metaData.title);

    }

    function loadUrlAlbum(track) {
        if(track!=="none"){
            playerView.albumImage.source="qrc:/src/icons/image-loading.png";
            playerView.albumImageBack.source="";
            var http1 = Qt.atob("aHR0cDovL3dzLmF1ZGlvc2Nyb2JibGVyLmNvbS8yLjAvP21ldGhvZD10cmFjay5zZWFyY2gmdHJhY2s9");
            var http2 = Qt.atob("JmFwaV9rZXk9MGQ4ZjM2NjIzMDE0NjEyYjAyNjQ0ZjM1OGRlNmE1MDQmZm9ybWF0PWpzb24=");
            var xhr = new XMLHttpRequest();
            xhr.open("GET", http1 + escape(track) + http2, true);
            xhr.onreadystatechange = function(){
                if (xhr.readyState == xhr.DONE){
                    if (xhr.status == 200){
                        var jsonObject = JSON.parse(xhr.responseText);
                        var imageUrl=(jsonObject.results.trackmatches.track.length===0)? "": jsonObject.results.trackmatches.track[0].image[2]["#text"];
                        if(imageUrl!==""){
                            playerView.albumImage.source=imageUrl;
                            playerView.albumImageBack.source=imageUrl;
                        }else{
                            playerView.albumImage.source="qrc:/src/icons/no-image-icon.png";
                        }
                    }
                }
            }
            xhr.send();
        }else{
            playerView.albumImage.source="qrc:/src/icons/no-image-icon.png";
        }
    }

    sliderVolume.onValueChanged: function(){
        player.volume = sliderVolume.value;
    }

    Component {
        id:delegateStation
        Rectangle {
            id:itemStation
            width: parent.width
            height: 40
            border.color: settings.colors.borderColor
            color:"#00000000"

            Rectangle {
                id:itemStationText
                width: itemStation.width
                color:"#00000000"
                height: itemStation.height
                Button {
                    text: name
                    textPosition: "left"
                    nameIcon: (listStation.currentIndex === index) && statePlay ? "media-playback-pause":"media-playback-start"
                    active:  listStation.currentIndex === index
                    clicked: function(){
                        player.stop();
                        player.source = modelStation.get(index).url;
                        if(statePlay){
                            menuBar.playPause();
                        }
                        menuBar.playPause();
                        listStation.currentIndex = index;
                    }
                }
            }
            Rectangle{
                color:"#00000000"
                id:itemStationButton
                x:itemStationText.width
                width:40
                height: itemStation.height
            }
        }
    }

    Component {
        id:delegateFavourites
        Rectangle {
            id:itemStation
            width: parent.width
            height: 40
            border.color: settings.colors.borderColor
            color:"#00000000"

            Rectangle {
                id:itemStationText
                width: itemStation.width-itemStationButton.width-itemStationButtonDelete.width
                color:"#00000000"
                height: itemStation.height
                Button {
                    x:5
                    text: name
                    textPosition: "left"
                }
            }
            Rectangle{
                color:"#00000000"
                id:itemStationButton
                x:itemStationText.width
                width:40
                height: itemStation.height
                Button{
                    nameIcon: "search"
                    clicked: function(){
                        krudioqml.search(escape(name));
                   }
                }
            }
            Rectangle{
                color:"#00000000"
                id:itemStationButtonDelete
                x:itemStationText.width+itemStationButton.width
                width:40
                height: itemStation.height
                Button{
                    nameIcon: "edit-delete"
                    clicked: function(){
                        favourites.splice(index,1);
                        modelFavourites.remove(index);
                        krudioqml.saveJson("favourites",JSON.stringify(favourites));
                   }
                }
            }
        }
    }

    buttonFavourites.clicked: function(){
        if(currentView === "listStation"){
            swipePlayerList.currentIndex = 1;
            currentView = "listFavourites";
            buttonFavourites.active = true;
        }else if(currentView === "listFavourites"){
            swipePlayerList.currentIndex = 0;
            currentView = "listStation";
            buttonFavourites.active = false;
        }

    }

    swipePlayerList.onCurrentIndexChanged:function(){
        if(swipePlayerList.currentIndex === 0){
            currentView = "listStation";
            buttonFavourites.active = false;
        }else{
            currentView = "listFavourites";
            buttonFavourites.active = true;
        }
    }

    selectGroupMouse.onClicked: selectGroup.popup.visible = !selectGroup.popup.visible;
    selectGroup.currentIndex: 0;
    selectGroup.onCurrentTextChanged: function(){
        var keyIndex = -1;
        database.forEach(function(category){
            if(selectGroup.currentText === category.name){
                modelStation.clear();
                category.stations.forEach(function(stations,key){
                    modelStation.append({name:stations.name, url:stations.url});
                    if(stations.url === player.source.toString()){
                        keyIndex = key;
                    }
                });
                listStation.currentIndex = keyIndex;
            }
        })
    }



    Component{
        id:delegateGroup
        ItemDelegate {
                    width: parent.width
                    height: 40
                    contentItem: Rectangle{
                        id: delegateGroupText
                        color: "#00000000"
                        anchors.fill: parent
                        Button{
                            text:category
                            clicked: function(){
                                selectGroup.currentIndex = index;
                                groupIndex = index;
                                selectGroup.popup.close();
                            }
                        }
                    }
                    highlighted: parent.highlightedIndex === index
                }
    }


    Component.onCompleted: function(){
        player.volume = sliderVolume.value;
        favourites.forEach(function(fav){
            modelFavourites.append({name:fav.name});
        })
    }

}

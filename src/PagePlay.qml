import QtQuick 2.7
import QtMultimedia 5.6
import QtQuick.Controls 2.0
import cpp.krudio 2.0
import "ui"
PagePlayForm {
    id:parentPlay
    property bool statePlay: false
    property var titleNameSong: player.metaData.title
    volume.value: 1;
    lineView.color: "#54758f"
    MediaPlayer{
        id:player
        volume: 1
    }
    //**Load Data from file
    function loadDataBase(opts) {
        var jsonObject;
        var index
        if(opts==="category"){
            globalModelCategory.clear();
            listCategory.currentIndex=0;
            category.length=0;
            jsonObject = JSON.parse(krudio.getJson(opts));
            for (index in jsonObject){
                category.push({name:jsonObject[index].category.name});
                globalModelCategory.append({name:decodeURIComponent(jsonObject[index].category.name)});
            }
            loadDataBase("stations");
        }
        if(opts==="stations"){
            globalModelStations.clear();
            listStations.currentIndex=-1;
            stations.length=0;
            var categoryIndex;
            jsonObject = JSON.parse(krudio.getJson(opts));
            categoryIndex=listCategory.currentIndex;
            if(jsonObject.length > 0){
                for (index in jsonObject[categoryIndex].category.stations){
                    stations.push({name:jsonObject[categoryIndex].category.stations[index].name,
                                      url:jsonObject[categoryIndex].category.stations[index].url});
                    globalModelStations.append({name:jsonObject[categoryIndex].category.stations[index].name});
                    if(jsonObject[categoryIndex].category.stations[index].url===player.source.toString()){
                        listStations.currentIndex=index;
                    }
                }
            }
        }
        if(opts==="favourites"){
            globalModelFavourites.clear();
            listFavourites.currentIndex=-1;
            favourites.length=0;
            jsonObject = JSON.parse(krudio.getJson(opts));
            for (index in jsonObject){
                favourites.push({name:jsonObject[index].name});
                globalModelFavourites.append({name:jsonObject[index].name});
            }
        }
    }
    //Load Data from file

    //**Array favourites to string save
    function arrayFavouritesToString(array){
        var jsonData="";
        jsonData+="[\n";
        for(var i=0;i<array.length;i++){
            jsonData+='{"name":"'+array[i].name+'"}';
            if(i!=array.length-1){jsonData+=',\n';}else{jsonData+='\n';}
        }
        jsonData+="]";
        return jsonData;
    }
    function addFavourites(name){
        if(name !== qsTr("Name song")){
            globalModelFavourites.append({name:name});
            favourites.push({name:name});
            krudio.saveJson(arrayFavouritesToString(favourites),"favourites");
            listsView.setCurrentIndex(2);
            listFavourites.currentIndex=listFavourites.count-1;
        }
    }
    function deleteFavourites(index){
        favourites.splice(index,1);
        globalModelFavourites.remove(index);
        krudio.saveJson(arrayFavouritesToString(favourites),"favourites");
    }
    //Array favourites to string save

    //**Set url player
    function setSource(index){
        player.source=stations[index].url;
        statePlay=!statePlay;
        playPause();
    }
    //Set url player

    //**Play or Pause player
    function playPause(){
        if(!statePlay){
            player.play();
            statePlay=!statePlay;
        }else{
            player.stop()
            statePlay=!statePlay;
        }
    }
    //Play or Pause player

    //**Play or Pause player
    function backOrNext(opts){
        var index;
        var count=listStations.count-1;
        index=listStations.currentIndex;
        if(opts){
            index++;
            if(index>count){
                index=0;
            }
        }else{
            index--;
            if(index<0){
                index=count;
            }
        }

        listStations.currentIndex=index;
        setSource(index);
    }
    //Play or Pause player

    //**Get image url for track
    function loadUrlAlbum(track) {
        if(track!=="none"){
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
                            albumImage.source=imageUrl;
                            //console.log("Image url: "+imageUrl);
                        }else{
                            //console.log("No image");
                            albumImage.source="qrc:/icons/no-image-icon.png";
                        }
                    }
                }
            }
            xhr.send();

        }else{
            //console.log("No image");
            albumImage.source="qrc:/icons/no-image-icon.png";
        }
    }


    //**Item for Category list
    Component{
        id:itemListCategory
        Item{
            width:parent.width
            height:32
            KrButton {
                width:parent.width
                height:parent.height
                anchors.left: parent.left
                text: name
                center:false
                bg.radius: 0
                active: listCategory.currentIndex==index
                onClick: {
                    listCategory.currentIndex=index;
                    loadDataBase("stations");
                    listsView.setCurrentIndex(1);
                }
            }
        }
    }
    //Item for Category list

    //**Item for Stations list
    Component{
        id:itemListStations
        Item{
            width:parent.width
            height:32
            KrButton {
                width:parent.width
                height:parent.height
                anchors.left: parent.left
                text: name
                iconURL:(listStations.currentIndex===index)?(statePlay?"qrc:/icons/media-playback-start.svg":"qrc:/icons/media-playback-pause.svg"):undefined
                center:false
                bg.radius: 0
                active: listStations.currentIndex===index
                onClick: {
                    listStations.currentIndex=index;
                    setSource(index);
                }
                onDbClick: {
                    playPause()
                }
            }
        }
    }
    //Item for Stations list

    //**Item for Favourites list
    Component{
        id:itemListFavourites
        Item{
            width:parent.width
            height:32
            Row{
                width:parent.width
                height:32
                TextField {
                    width:parent.width-32*2
                    height:parent.height
                    text: name
                    readOnly: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    onFocusChanged: {
                        //console.log(focus)
                        if(focus){
                            listFavourites.currentIndex===index
                            select(0,length)
                        }
                    }
                    selectByMouse: true
                }
                KrButton {
                    width:32
                    height:parent.height
                    iconURL: "qrc:/icons/search.svg"
                    center:false
                    bg.radius: 0
                    active: listFavourites.currentIndex===index
                    onClick: {
                        krudio.search(escape(favourites[index].name));
                    }
                }
                KrButton {
                    width:32
                    height:parent.height
                    iconURL: "qrc:/icons/edit-delete.svg"
                    center:false
                    bg.radius: 0
                    active: listFavourites.currentIndex===index
                    onClick: {
                        deleteFavourites(index)
                    }
                }
            }
        }
    }
    //Item for Favourites list

    listCategory.model:globalModelCategory
    listCategory.delegate:itemListCategory
    listStations.model:globalModelStations
    listStations.delegate:itemListStations
    listFavourites.model:globalModelFavourites
    listFavourites.delegate:itemListFavourites
    albumImage.onStatusChanged: {
        if(albumImage.status===2){
            albumImageLoading.z=1;
            albumImage.z=0;
        }else{
            albumImageLoading.z=0;
            albumImage.z=1;
        }
    }

    buttonAddFavourites.onClick: {
        addFavourites(titleSong.text);
    }

    onTitleNameSongChanged: {
        if(titleNameSong!==undefined){
            titleSong.text=titleNameSong;
            loadUrlAlbum(titleSong.text);
        }else{
            if(player.metaData.publisher!==undefined){
                titleSong.text=player.metaData.publisher;
            }else{
                //titleSong.text=stations[listStations.currentIndex].name;
            }
        }
    }

    onStatePlayChanged: {
        if(statePlay){
            buttonPlayPause.iconURL="qrc:/icons/media-playback-pause.svg";
        }else{
            buttonPlayPause.iconURL="qrc:/icons/media-playback-start.svg";
        }
    }

    buttonSearch.onClick: {
        krudio.search(escape(titleSong.text));
    }

    volume.onValueChanged: {
        player.volume=volume.value;
    }

    buttonPlayPause.onClick: {
        playPause();
        listsView.setCurrentIndex(1);
    }

    buttonBack.onClick: {
        backOrNext(false);
        listsView.setCurrentIndex(1);
    }

    buttonNext.onClick: {
        backOrNext(true);
        listsView.setCurrentIndex(1);
    }

    Component.onCompleted: {
        loadDataBase("category");
        loadDataBase("favourites");
    }

    buttonCategory.onClick:{
        listsView.setCurrentIndex(0)
    }
    buttonStations.onClick:{
        listsView.setCurrentIndex(1)
    }
    buttonFavourites.onClick:{
        listsView.setCurrentIndex(2);
    }

}

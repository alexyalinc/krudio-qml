import QtQuick 2.9

MenuBarForm {
    property string currentPage: "main"
    id:menuBar
    function playPause(){
        playerView.swipePlayerList.currentIndex = 0;
        pageView.currentIndex = 0;
        if(statePlay){
            player.pause();
            krudioqmltray.tray_setState(false);
            buttonPlay.nameIcon = "media-playback-start";
        }else{
            if(modelStation.count > 0){
                player.source = modelStation.get(0).url;
                playerView.listStation.currentIndex = 0;
            }
            player.play();
            krudioqmltray.tray_setState(true);
            buttonPlay.nameIcon = "media-playback-pause";

        }
        statePlay = !statePlay;
    }
    buttonPlay.clicked: function (){playPause();}
    buttonAdd.clicked: function (){
        var nameSong = playerView.nameSongText.text;
        var clear = true;
        if(nameSong !== ""){
            favourites.forEach(function(fav){
                if(fav.name === nameSong){
                    clear = false;
                }
            });
            if(clear){
                modelFavourites.append({name: nameSong });
                favourites.push({name: nameSong });
                krudioqml.saveJson("favourites",JSON.stringify(favourites));
                playerView.swipePlayerList.currentIndex = 1;
            }
        }
    }
    buttonSearch.clicked: function (){ krudioqml.search(escape(playerView.nameSongText.text)) }
    buttonEdit.clicked: function(){
        if(pageView.currentIndex === 1){
            pageView.currentIndex = 0;
        }else{
            pageView.currentIndex = 1;
        }

    }

}

import QtQuick 2.9

MenuBarForm {
    property string currentPage: "main"
    id:menuBar
    function playPause(){
        if(statePlay){
            player.pause();
            krudioqmltray.tray_setState(false);
            buttonPlay.nameIcon = "media-playback-start";
        }else{
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
        if(currentPage === "edit"){
            buttonEdit.nameIcon = "document-edit";
            currentPage = "main";
            pageView.setCurrentIndex(0);
        }else{
            buttonEdit.nameIcon = "media-playback-back";
            currentPage = "edit";
            pageView.setCurrentIndex(1);
        }

    }


}

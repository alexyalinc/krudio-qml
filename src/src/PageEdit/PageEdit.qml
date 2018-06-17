import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import "../Button"
PageEditForm {
    id:pageEdit
    property int i:0;

    MediaPlayer{id:playerFindStation}
    function deleteGroup(index){
        database.forEach(function(category,key){
            if(index === key){ database.splice(key,1)}
        });
        for (var i=0; i<modelGroup.count; ++i)
        {
            if (index === i){
                modelGroup.remove(i);
            }
        }
        krudioqml.saveJson("database",JSON.stringify(database));
    }

    function deleteStation(index){

        database.forEach(function(category,key){
            if(selectGroup.currentText === category.name){
                database[key].stations.forEach(function(station,keyStation){
                    if(index === keyStation){
                        database[key].stations.splice(keyStation,1);
                    }
                });
            }
        });


        for (var i=0; i<modelStation.count; ++i)
        {
            if (index === i){
                modelStation.remove(i);
            }
        }
        krudioqml.saveJson("database",JSON.stringify(database));
    }

    Timer {
        id:timerAddStation
        running: false
        repeat: true
        interval: 500
        onTriggered: addStation()
    }

    function addStation(){
        if(stationUrl.text ===  "The station is not unique" || stationUrl.text === ""){
            return;
        }
        timerAddStation.running = true;
        if(i === 0){
            playerFindStation.source = stationUrl.text;
            playerFindStation.volume = 0;
            playerFindStation.play();
        }

        if(playerFindStation.metaData.publisher !== undefined){
            database.forEach(function(category,key){
                if(selectGroup.currentText === category.name){
                    var uniqStationInGroup = true;
                    database[key].stations.forEach(function(station,keyStation){
                        if(station.url === stationUrl.text){
                            uniqStationInGroup = false;
                        }
                    })
                    console.log(uniqStationInGroup);
                    if(uniqStationInGroup){
                        modelStation.append({name:playerFindStation.metaData.publisher,url:stationUrl.text});
                        database[key].stations.push({
                                                        name:playerFindStation.metaData.publisher,
                                                        url:stationUrl.text
                                                    });
                        stationUrl.text =  "";
                        krudioqml.saveJson("database",JSON.stringify(database));
                    }else{
                        stationUrl.text =  "The station is not unique";
                        timerAddStation.running = false;
                        playerFindStation.stop();
                        i=0;
                    }

                }
            });
            timerAddStation.running = false;
            playerFindStation.stop();
            i=0;
        }else{
            if(i === 10){
                stationUrl.text =  "Invalid Url";
                timerAddStation.running = false;
                playerFindStation.stop();
                i=0;
            }else{
                i++;
            }
        }

    }

    stationUrl.onFocusChanged: stationUrl.text = ""

    buttonAddStation.clicked: function(){ addStation(); }
    selectGroupMouse.onClicked: selectGroup.popup.visible = !selectGroup.popup.visible;
    Component {
        id:delegateGroup
        ItemDelegate{
            id:delCurr
            width: parent.width
            height: 40
            Rectangle{
                id: delegateGroupText
                width: parent.width-40
                height: 40
                color: "#00000000"
                Button{
                    text:category
                    clicked: function(){
                        selectGroup.currentIndex = index;
                        selectGroup.popup.close();
                    }
                }
            }
            Rectangle{
                x:delegateGroupText.width
                width: 40
                height: 40
                color: "#00000000"
                Button{
                    nameIcon: "edit-delete"
                    clicked: function(){
                        deleteGroup(index);
                    }
                }
            }
        }
    }

    Popup {
        id:popupGroup
        y: selectGroup.count*40+inputGroup.height+selectGroup.height > app.height ? 0:rectangleSelectGroup.height*2
        x: selectGroup.count*40+inputGroup.height+selectGroup.height > app.height ? 0:rectangleSelectGroup.x
        width: selectGroup.count*40+inputGroup.height+selectGroup.height > app.height ? app.width:selectGroup.width
        height: Math.min(contentSelectGroup.implicitHeight+inputGroup.height, app.height)
        onActiveFocusChanged: function(){
               if(!popupGroup.activeFocus){
                   selectGroup.popup.close()
               }
        }
            contentItem:
            Rectangle{
            anchors.fill: parent
            ListView {
                id:contentSelectGroup
                clip: true
                implicitHeight: contentHeight
                model: selectGroup.delegateModel
                currentIndex: selectGroup.highlightedIndex
                highlightMoveDuration: 0
                width: parent.width
                height: parent.height - inputGroup.height
                Rectangle {
                    z: 10
                    width: parent.width
                    height: parent.height
                    color: "transparent"
                    border.color: selectGroup.palette.mid
                }

                ScrollIndicator.vertical: ScrollIndicator { }
            }
            Rectangle{
                id:inputGroup
                color:"#00000000"
                width: parent.width
                height: 30
                y:contentSelectGroup.height
                z: 999
                Rectangle{
                    height: parent.height
                    width: parent.width - buttonAddGroup.width
                    color: settings.colors.bgInput
                    border.width: 1
                    border.color: settings.colors.bgInput
                    TextField {
                        id: nameGroup
                        anchors.fill: parent
                        text: qsTr("Name group")
                        color: settings.colors.inputColor
                        onFocusChanged: nameGroup.text = ""
                        background: Rectangle {
                            radius: 0
                            color:"#00000000"
                        }
                    }
                }
                Rectangle{
                    height: parent.height
                    width: 100
                    x:nameGroup.width
                    color:"#00000000"
                    border.width: 1
                    border.color: settings.colors.bgColorPressed
                    Button{
                        id:buttonAddGroup
                        anchors.fill: parent
                        text:qsTr("Add Group")
                        clicked: function(){
                            if(nameGroup.text !== "Name group" && nameGroup.text !== ""){
                                var clear = true;
                                database.forEach(function(category){
                                    if(nameGroup.text === category.name){clear = false;}
                                });
                                if(clear){
                                    modelGroup.append({ category: nameGroup.text});
                                    database.push({name:nameGroup.text,stations:[]});
                                    nameGroup.text = "";
                                    krudioqml.saveJson("database",JSON.stringify(database));
                                }
                            }

                        }
                    }
                }
            }
        }
        background: Rectangle { }

    }

    Component {
        id:delegateStation
        Rectangle {
            id:itemStation
            width: parent.width
            height: 40
            border.color: settings.colors.borderColor
            color:"#00000000"
            Rectangle{
                color:"#00000000"
                id:itemStationButton
                width:40
                height: itemStation.height
                Button{
                    nameIcon: "edit-delete"
                    clicked: function(){
                        deleteStation(index)
                    }
                }
            }
            Rectangle {
                id:itemStationText
                x:itemStationButton.width
                width: itemStation.width - itemStationButton.width
                color:"#00000000"
                height: itemStation.height
                Button {
                    textPosition: "left"
                    text: name
                }
            }
        }
    }

    selectGroup.onCurrentTextChanged: function(){
        database.forEach(function(category){
            if(selectGroup.currentText === category.name){
                modelStation.clear();
                category.stations.forEach(function(stations){
                    modelStation.append({name:stations.name, url:stations.url});
                })
            }
        })
    }

    Component.onCompleted: function(){
        database.forEach(function(category){
            modelGroup.append({ category: category.name})
        });
        selectGroup.currentIndex = 0;
    }
}

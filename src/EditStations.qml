import QtQuick 2.7
import QtMultimedia 5.9
import "ui"

EditStationsForm {
    lineViewCategory.color: "#54758f"
    property variant backStations: []
    property variant varGlobalModelEditStations:[]
    ListModel{id:globalModelEditStations}
    property int indexCategory: 0
    property variant jsonDataBase;
    lineEditView.color: "#54758f"
    property alias editPlayer: editPlayer
    property var allJsonDate;

    MediaPlayer{
        id:editPlayer
        volume:0
    }


    //**Load Data from file
    function loadDataBase(opts) {
        var jsonObject;
        var index;
        allJsonDate=JSON.parse(krudio.getJson("category"));
        if(opts==="category"){
            globalModelCategory.clear();
            listEditCategory.currentIndex=0;
            category.length=0;
            for (index in allJsonDate){
                category.push({name:allJsonDate[index].category.name});//?
                globalModelCategory.append({name:allJsonDate[index].category.name});
            }
            loadDataBase("stations")
        }
        if(opts==="stations"){
            globalModelEditStations.clear();
            listEditStations.currentIndex=-1;
            varGlobalModelEditStations.length=0;
            var categoryIndex;
            //console.log(indexCategory)
            if(allJsonDate.length > 0){
                for (index in allJsonDate[indexCategory].category.stations){
                    varGlobalModelEditStations.push({name:allJsonDate[indexCategory].category.stations[index].name,
                                                        url:allJsonDate[indexCategory].category.stations[index].url});
                    globalModelEditStations.append({name:allJsonDate[indexCategory].category.stations[index].name});
                }
            }
        }
    }
    function loadBackStations(index){
        backStations.length=0;
        if(allJsonDate[index]!==undefined){
            if(allJsonDate[index].category.stations.length!==0){

                for (var indexg in allJsonDate[index].category.stations){
                    backStations.push({name:allJsonDate[index].category.stations[indexg].name,
                                          url:allJsonDate[index].category.stations[indexg].url});
                }
                return backStations;
            }else
                return undefined;
        }else{

            return undefined;
        }
    }

    //Load Data from file
    //**Array favourites to string save
    function addCategory(name){
        if(name !== qsTr("Name Category") && name!==""){
            nameCategory.text=qsTr("Loading...");
            nameCategory.enabled=false;
            globalModelCategory.append({name:name});
            category.push({name:name});
            allJsonDate.push({
                                 "category":{
                                     "name":name,
                                     "stations":[]
                                 }
                             });
            krudio.saveJson(JSON.stringify(allJsonDate, null, '\t'),"category");
            listEditCategory.currentIndex=listEditCategory.count-1;
            nameCategory.enabled=true;
            nameCategory.text="";
        }
    }
    function delCategory(index){
        category.splice(index,1);
        globalModelCategory.remove(index);
        allJsonDate.splice(index,1);
        krudio.saveJson(JSON.stringify(allJsonDate, null, '\t'),"category");
        listEditCategory.currentIndex=listEditCategory.count-1;
    }

    function delStations(index){
        backStations.splice(index,1);
        globalModelEditStations.remove(index);
        allJsonDate[comboBoxCategory.currentIndex].category.stations.splice(index,1);
        krudio.saveJson(JSON.stringify(allJsonDate, null, '\t'),"category");
    }

    property var dataEdit:undefined;
    property variant namePublisher:editPlayer.metaData.publisher;

    function findPublisherForAddStations(){
        var dateNows=new Date;
        if(urlStations.text!==qsTr("URL Station")
                && urlStations.text!==qsTr("Invalid URL")
                && urlStations.text!==""){
            if(dataEdit===undefined){
                dataEdit=new Date;
                editPlayer.source=urlStations.text
                editPlayer.play();
                urlStations.enabled=false;
                comboBoxCategory.enabled=false;

                //console.log("undef")
            }else {
                //console.log("Else"+dateNows-dataEdit)
                if((dateNows-dataEdit)>=10000){
                    //console.log(">5000")
                    dataEdit=undefined;
                    editPlayer.stop();
                    findPublisher.running=false;
                    urlStations.enabled=true;
                    comboBoxCategory.enabled=true;
                    urlStations.text=qsTr("Invalid URL");
                }else {

                    //console.log("<5000")
                    if(namePublisher!==undefined){
                        jsonDataBase=JSON.parse(krudio.getJson("stations"));
                        jsonDataBase[comboBoxCategory.currentIndex].category.stations.push({name:namePublisher,
                                                                                               url:urlStations.text});
                        globalModelEditStations.append({name:namePublisher});
                        krudio.saveJson(JSON.stringify(jsonDataBase, null, '\t'),"category");
                        urlStations.enabled=true;
                        comboBoxCategory.enabled=true;
                        dataEdit=undefined;
                        editPlayer.stop();
                        findPublisher.running=false;
                        urlStations.text="";
                        indexCategory=comboBoxCategory.currentIndex;
                        loadDataBase("stations");
                        listsEditStationsView.setCurrentIndex(1);
                        listEditStations.currentIndex=listEditStations.count-1;
                    }
                }
            }
        }else{
            findPublisher.running=false;
        }
    }

    Timer {
        id:findPublisher
        interval:10
        running: false
        repeat: true
        onTriggered: findPublisherForAddStations()
    }

    function addEditStations(){
        if(!findPublisher.running){
            findPublisher.running=true;
        }
    }


    //**Item for Category list
    Component{
        id:itemListEditCategory
        Item{
            width:parent.width
            height:32
            Row{
                width:parent.width
                height:32
                KrButton {
                    width:parent.width-32
                    height:parent.height
                    text: name
                    center:false
                    bg.radius: 0
                    active: listEditCategory.currentIndex==index
                    onClick: {
                        listEditCategory.currentIndex=index;
                    }
                }
                KrButton {
                    width:32
                    height:parent.height
                    iconURL:"qrc:/icons/edit-delete.svg"
                    center:false
                    bg.radius: 0
                    active: listEditCategory.currentIndex==index
                    onClick: {
                        delCategory(index);
                    }
                }
            }
        }
    }
    //Item for Category list

    //**Item for Stations list
    Component{
        id:itemListEditStationsStations
        Item{
            width:parent.width
            height:32
            Row{
                width:parent.width
                height:32
                KrButton {
                    width:parent.width-32
                    height:parent.height
                    text: name
                    center:false
                    bg.radius: 0
                    active: listEditStations.currentIndex==index
                    onClick: {
                        listEditStations.currentIndex=index;
                    }
                }
                KrButton {
                    width:32
                    height:parent.height
                    iconURL:"qrc:/icons/edit-delete.svg"
                    center:false
                    bg.radius: 0
                    active: listEditStations.currentIndex==index
                    onClick: {
                        delStations(index);
                    }
                }
            }
        }
    }
    //Item for Stations list

    Component.onCompleted: {
        loadDataBase("category")
    }

    comboBoxCategory.onCurrentIndexChanged: {
        if(comboBoxCategory.currentIndex===-1){
            comboBoxCategory.currentIndex=0;
        }
        indexCategory=comboBoxCategory.currentIndex;
        listsEditStationsView.setCurrentIndex(1)
        loadDataBase("stations");
    }


    listEditCategory.delegate:itemListEditCategory
    listEditCategory.model:globalModelCategory

    listEditStations.model: globalModelEditStations
    listEditStations.delegate: itemListEditStationsStations

    buttonEditStationsAdd.onClick: {
        addEditStations()
    }

    nameCategory.onAccepted: {
        addCategory(nameCategory.text);
    }

    buttonEditCategoryAdd.onClick: {
        addCategory(nameCategory.text);
    }

    buttonEditCategory.onClick:{
        listsEditView.setCurrentIndex(0)
    }
    buttonEditStations.onClick:{
        listsEditView.setCurrentIndex(1)
    }
}

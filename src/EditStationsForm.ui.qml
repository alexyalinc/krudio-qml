import QtQuick 2.7
import QtQuick.Controls 2.0
import "ui"

Item {

    property alias buttonEditCategory: buttonEditCategory
    property alias buttonEditStations: buttonEditStations
    property alias lineViewCategory: lineViewCategory
    property alias listsEditView: listsEditView
    property alias listEditCategory: listEditCategory
    property alias buttonEditCategoryAdd: buttonEditCategoryAdd
    property alias nameCategory: nameCategory
    property alias listEditStations:listEditStations
    property alias listsEditStationsView:listsEditStationsView
    property alias lineEditView:lineEditView
    property alias comboBoxCategory:comboBoxCategory
    property alias buttonEditStationsAdd:buttonEditStationsAdd
    property alias urlStations:urlStations
    Column {
        id: column1
        width: parent.width
        height: parent.height
        Row{
            id: tabBarPlay
            width: parent.width
            anchors.left:parent.left
            z:1
            KrButton {
                id:buttonEditCategory
                width: parent.width/2
                text: qsTr("Edit category")
                center:true
                bg.radius: 0
                active: listsEditView.currentIndex==0
            }

            KrButton {
                id:buttonEditStations
                width: parent.width/2
                text: qsTr("Edit stations")
                center:true
                bg.radius: 0
                active: listsEditView.currentIndex==1
            }
        }

        SwipeView{
            id:listsEditView
            z:0
            clip: true
            width: parent.width
            height:krWindow.height - tabBarPlay.height - tabBar.height
            topPadding: 0.1
            anchors.left:parent.left
            Rectangle{

                Column {
                    width: parent.width
                    height:parent.height
                    TextField {
                        id: nameCategory
                        selectByMouse: true
                        width: parent.width
                        font.family: "Tahoma"
                        font.pointSize: 10
                        placeholderText: qsTr("Name Category")
                    }
                    Row{
                        id: buttonCategoryName
                        width: parent.width
                        z:1
                        KrButton {
                            id:buttonEditCategoryAdd
                            width: parent.width
                            iconURL: "qrc:/icons/list-add.svg"
                            text: qsTr("Add category")
                            center:true
                            bg.radius: 0
                        }
                    }
                    Rectangle{
                        id:lineViewCategory
                        width: parent.width
                        height:4
                        anchors.left:parent.left
                        z:1
                    }
                    ListView {
                        id: listEditCategory
                        width: parent.width
                        height: parent.height-nameCategory.height-buttonCategoryName.height
                        interactive: true
                        boundsBehavior: Flickable.DragAndOvershootBounds
                        highlightFollowsCurrentItem: true
                        ScrollBar.vertical: ScrollBar {
                            id: hbarCategory;
                            active:true
                        }
                        model:ListModel{}
                    }
                }
            }

            Rectangle{
                Column {
                    id: row2
                    width: parent.width
                    height: parent.height
                    ComboBox {
                        id: comboBoxCategory
                        currentIndex: 0
                        width:parent.width
                        model:globalModelCategory
                    }
                    TextField {
                        id: urlStations
                        selectByMouse: true
                        width: parent.width
                        placeholderText: qsTr("URL Station")
                    }
                    Row{
                        id: buttonEditCategoryName
                        width: parent.width
                        z:1
                        KrButton {
                            id:buttonEditStationsAdd
                            width: parent.width
                            iconURL: "qrc:/icons/list-add.svg"
                            text: qsTr("Add station")
                            center:true
                            bg.radius: 0
                        }
                    }
                    Rectangle{
                        id:lineEditView
                        width: parent.width
                        height:4
                        anchors.left:parent.left
                        z:1
                    }
                    SwipeView{
                        id:listsEditStationsView
                        z:0
                        clip: true
                        width: parent.width
                        height:krWindow.height - comboBoxCategory.height-tabBarPlay.height-buttonEditStationsAdd.height-tabBar.height-urlStations.height-lineEditView.height-buttonEditCategoryName.height
                        topPadding: 0.1
                        anchors.left:parent.left
                        ListView {
                            id: listEditStations
                            ScrollBar.vertical: ScrollBar {
                                id: hbarEditStations;
                                active:true
                            }
                            model:ListModel{}
                        }
                    }
                }
            }

        }
    }
}

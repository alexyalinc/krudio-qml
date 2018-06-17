import QtQuick 2.9
import "../Button"
Rectangle {
    property alias buttonPlay   : buttonPlay
    property alias buttonAdd    : buttonAdd
    property alias buttonSearch : buttonSearch
    property alias buttonEdit   : buttonEdit
    anchors.fill: parent
    Row {
        id:rowMenuBar
        anchors.fill: parent
        Rectangle{
            width: parent.width/4
            height: parent.height
            Button{
                id:buttonPlay
                nameIcon: "media-playback-start"
                anchors.fill: parent
            }
        }

        Rectangle{
            width: parent.width/4
            height: parent.height
            Button{
                id:buttonAdd
                nameIcon: "heart"
                anchors.fill: parent
            }
        }

        Rectangle{
            width: parent.width/4
            height: parent.height
            Button{
                id:buttonSearch
                nameIcon: "search"
                anchors.fill: parent
            }
        }

        Rectangle{
            width: parent.width/4
            height: parent.height
            Button{
                id:buttonEdit
                nameIcon: "document-edit"
                anchors.fill: parent
            }
        }
    }
    Rectangle{
        width: parent.width
        height: 1
        y:rowMenuBar.height
        color:settings.colors.hrTopBar
    }
}

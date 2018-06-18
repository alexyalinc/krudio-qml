import QtQuick 2.9
import QtQuick.Controls 2.2
import "../Button"
Rectangle {
    property alias nameSongText         : nameSongText
    property alias albumImage           : albumImage
    property alias selectGroupMouse     : selectGroupMouse
    property alias selectGroup          : selectGroup
    property alias listStation          : listStation
    property alias buttonFavourites     : buttonFavourites
    property alias swipePlayerList      : swipePlayerList
    property alias listFavourites       : listFavourites


    anchors.fill: parent
    color:"#00000000"
    Row {
        id:playerInfo
        width: parent.width
        height: 200
        Rectangle {
            id: rectangle
            width: parent.width / 2
            height: parent.height
            color:"#00000000"
            Image {
                id: albumImage
                width: 150
                height: 150
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/src/icons/no-image-icon.png"
            }
        }

        Rectangle {
            width: parent.width / 2
            height: parent.height
            color:"#00000000"
            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                id: nameSongText
                textFormat: Text.RichText
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }
    }

    Rectangle{
        id:selectGroupPlayer
        y:playerInfo.height
        width: parent.width
        height: 30
        Rectangle{
            id:selectGroupViewPlayerHr
            width: parent.width
            height: 1
            color:settings.colors.hrMainPageSelectGroupColor1
        }
        Rectangle{
            id:selectGroupViewPlayer
            width: parent.width - rectButtonFavourites.width
            height: parent.height - selectGroupViewPlayerHrBotoom.height
            color:settings.colors.bgSelect
            y:selectGroupViewPlayerHr.height
            ComboBox {
                MouseArea {
                    id:selectGroupMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
                id: selectGroup
                anchors.fill: parent
                model:modelGroup
                delegate: delegateGroup
                contentItem: Text {
                              leftPadding: 0
                              rightPadding: selectGroup.indicator.width + selectGroup.spacing
                              font.pixelSize:13;
                              font.family: "Tahoma"
                              font.weight: Font.Normal
                              text: selectGroup.displayText
                              verticalAlignment: Text.AlignVCenter
                              elide: Text.ElideRight
                              color: settings.colors.selectColor
                          }
                background: Rectangle{
                    color:"#00000000"
                }

                textRole: 'category'
            }
        }
        Rectangle{
            id:rectButtonFavourites
            x:selectGroupViewPlayer.width
            width: 40
            height: parent.height - selectGroupViewPlayerHrBotoom.height
            y:selectGroupViewPlayerHr.height
            Button{
                id:buttonFavourites
                nameIcon: "heart"
            }
        }

        Rectangle{
            id:selectGroupViewPlayerHrBotoom
            width: parent.width
            height: 1
            y:selectGroupPlayer.height-selectGroupViewPlayerHrBotoom.height
            color:settings.colors.hrMainPageSelectGroupColor2
        }
    }

    Rectangle {
        width: parent.width
        y:playerInfo.height + selectGroupPlayer.height
        height: parent.height - playerInfo.height - selectGroupPlayer.height
        color:"#00000000"
        SwipeView {
            id:swipePlayerList
            anchors.fill: parent
            Rectangle {
                color:"#00000000"
                ScrollView {
                    anchors.fill: parent
                    ListView {
                        id: listStation
                        anchors.fill: parent
                        model: modelStation
                        delegate: delegateStation
                    }
                }
            }
            Rectangle {
                color:"#00000000"
                ListView {
                    id: listFavourites
                    anchors.fill: parent
                    model: modelFavourites
                    delegate: delegateFavourites
                }
            }
        }
    }
}

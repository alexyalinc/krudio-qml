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
    property alias sliderVolume         : sliderVolume
    property alias albumImageBack       : albumImageBack

    anchors.fill: parent
    color:"#00000000"
    Rectangle {
        id:playerInfo
        width: parent.width
        height: 200
        y:1
        color:"#00000000"
        Image {
            id:albumImageBack
            anchors.fill: parent
            z:0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectCrop
        }
        Rectangle{
            color: settings.colors.bgImageBack
            anchors.fill: parent
            z:2
        }

        Rectangle {
            id: rectangleAlbum
            width: parent.width / 2
            height: parent.height
            color:"#00000000"
            z:3
            Image {
                id: albumImage
                width: 150
                height: 150
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/src/icons/no-image-icon.png"
                sourceSize.width: 150
                sourceSize.height: 150
            }
        }

        Rectangle {
            width: parent.width / 2
            height: parent.height
            x:rectangleAlbum.width
            color:"#00000000"
            z:3
            Rectangle{
                id:rectTextSong
                width: parent.width
                height: 130
                y:25
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
            Rectangle{
                id:rectSlider
                width: parent.width
                height: 20
                y:155
                color:"#00000000"
                Slider {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    id:sliderVolume
                    from: 0.1
                    value: 0.5
                    to: 1
                    background: Rectangle {
                            x: sliderVolume.leftPadding
                            y: sliderVolume.topPadding + sliderVolume.availableHeight / 2 - height / 2
                            implicitWidth: 200
                            implicitHeight: 4
                            width: sliderVolume.availableWidth
                            height: implicitHeight
                            radius: 2
                            color: settings.colors.sliderColor

                            Rectangle {
                                width: sliderVolume.visualPosition * parent.width
                                height: parent.height
                                color: settings.colors.sliderColor2
                                radius: 2
                            }
                        }

                        handle: Rectangle {
                            x: sliderVolume.leftPadding + sliderVolume.visualPosition * (sliderVolume.availableWidth - width)
                            y: sliderVolume.topPadding + sliderVolume.availableHeight / 2 - height / 2
                            implicitWidth: 16
                            implicitHeight: 16
                            radius: 13
                            color: sliderVolume.pressed ? settings.colors.sliderColorButtonPressed : settings.colors.sliderColorButton
                            border.color: settings.colors.sliderColorButtonBorder
                        }
                }
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
                contentItem:
                    Text {
                    width: selectGroup.width
                    height: selectGroup.height
                    id:textSelectGroup
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
                    Rectangle{
                        width: 32
                        height: 32
                        y:-2
                        color:"#00000000"
                        x:selectGroup.width-height
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: "qrc:/src/icons/list-add.svg"
                            sourceSize.width: 16
                            sourceSize.height: 16
                        }
                    }
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

import QtQuick 2.9
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Private 1.0
import "../Button"
Rectangle {
    property alias selectGroup          : selectGroup
    property alias stationUrl           : stationUrl
    property alias buttonAddStation     : buttonAddStation
    property alias selectGroupMouse     : selectGroupMouse
    property alias rectangleSelectGroup : rectangleSelectGroup

    anchors.fill: parent
    color:"#00000000"

    Rectangle{
        id:rowEdit
        width: parent.width
        height: selectGroup.height + inputStation.height + rectangleText.height
        color:"#00000000"
        Rectangle{
            id: rectangleText
            height: 30
            width: parent.width
            color:settings.colors.bgColor
            y:1
            Text {
                id: labelBox
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Select group:")
                anchors.fill: parent
                font.pixelSize: settings.colors.textSize
                color:settings.colors.textColor
            }
        }
        Rectangle{
            id:labelEditHrTop
            width: parent.width
            height: 1
            y:rectangleText.height+1
            color:settings.colors.hrLabelGroup
        }
        Rectangle{
            id:rectangleSelectGroup
            width: parent.width
            y:rectangleText.height+labelEditHrTop.height+1
            height: 30
            color:settings.colors.bgSelect
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
                popup:popupGroup
                contentItem: Text {
                        leftPadding: 0
                        rightPadding: selectGroup.indicator.width + selectGroup.spacing
                        text: selectGroup.displayText
                        font.pixelSize: settings.colors.textSize
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
            id:inputStation
            width: parent.width
            height: 30
            y: selectGroup.height + rectangleText.height -1
            color:  settings.colors.bgInput
            Rectangle{
                id:stationUrlHrTop
                width: parent.width
                height: 1
                color:settings.colors.hrStationUrl1
            }
            Rectangle{
                y:stationUrlHrTop.height
                height: parent.height-stationUrlHrBottom.height
                width: parent.width - buttonAddGroup.width
                color:"#00000000"
                border.width: 0
                border.color: "#00000000"
                TextField {
                    id: stationUrl
                    anchors.fill: parent
                    text: qsTr("Url station")
                    color: settings.colors.inputColor
                    font.pixelSize: settings.colors.textSize
                    background: Rectangle {
                        border.width: 0
                        border.color: "#00000000"
                        radius: 0
                        color:"#00000000"
                    }
                }
            }
            Rectangle{
                height: parent.height-stationUrlHrBottom.height
                width: 100
                x:stationUrl.width + inputStation.border.width
                y:stationUrlHrTop.height
                color:"#00000000"
                Button{
                    id:buttonAddStation
                    anchors.fill: parent
                    anchors.margins: 1
                    text:qsTr("Add Station")
                }
            }
            Rectangle{
                id:stationUrlHrBottom
                width: parent.width
                height: 1
                y:parent.height-stationUrlHrBottom.height
                color:settings.colors.hrStationUrl2
            }
        }
    }

    Rectangle{
        width: parent.width
        y:rowEdit.height-1
        height: parent.height - rowEdit.height
        color:settings.colors.bgWindow
        ScrollView {
            id: scrollView
            anchors.fill: parent
            ListView {
                id: stationView
                anchors.fill: parent
                delegate: delegateStation
                model: modelStation
            }
        }
    }
}

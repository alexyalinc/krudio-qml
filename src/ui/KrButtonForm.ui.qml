import QtQuick 2.4

Rectangle {
    property alias textButton: textButton
    property alias buttonArea: buttonArea
    property alias bg: bg
    property alias sourceIcon:buttonIcon.source
    property alias icon:buttonIcon
    property alias textHide:textHide
    property alias rectIcon:rectIcon
    id: bg
    border.color: "#00000000"
    opacity:1
    radius: 4
    Text {
        id:textHide
        anchors.left: parent.left
        font.family: "Tahoma"
        font.pixelSize: 15
        visible:false
    }

    Rectangle{
        id: rectIcon
        color: "#00000000"
        anchors.left: parent.left
        Image {
            id: buttonIcon
            clip: true
            width: 16
            height: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle {
        id: rectText
        color: "#00000000"
        height:parent.height
        anchors.right: parent.right
        anchors.left: parent.left
        Text {
            clip: true
            id: textButton
            anchors.fill: parent
            horizontalAlignment: center?Text.AlignHCenter:Text.AlignLeft
            font.family: "Tahoma"
            font.pixelSize: 15
            text:qsTr("Button")
            textFormat: Text.RichText
            verticalAlignment: Text.AlignVCenter

        }
    }
    MouseArea {
        id: buttonArea
        hoverEnabled:true
        anchors.fill: parent
    }


}

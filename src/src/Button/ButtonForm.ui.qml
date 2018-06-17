import QtQuick 2.9

Rectangle {
    property alias textButton: textButton
    property alias nameImageButton: nameImageButton
    property alias buttonRectangleImage: buttonRectangleImage
    property alias buttonRectangle: buttonRectangle
    property alias mouseAreaButton: mouseAreaButton
    property alias textButtonRectangle: textButtonRectangle
    id: buttonRectangle
    anchors.fill: parent
    MouseArea {
        id: mouseAreaButton
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        Rectangle {
            id: buttonRectangleImage
            width: textButton.text === "" ? parent.width : 60
            height: mouseAreaButton.height
            color: "#00000000"
            visible: true
            Image {
                id: nameImageButton
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: 32
                sourceSize.height: 32
            }
        }
        Rectangle {
            id: textButtonRectangle
            x: buttonRectangleImage.width
            width: buttonRectangleImage.visible
                   === false ? mouseAreaButton.width : mouseAreaButton.width
                               - buttonRectangleImage.width
            height: mouseAreaButton.height
            color: "#00000000"
            Text {
                id: textButton
                text: qsTr(text)
                font.weight: Font.Normal
                font.family: "Tahoma"
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
            }
        }
    }
}

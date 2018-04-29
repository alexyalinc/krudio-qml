import QtQuick 2.4
import QtQuick.Window 2.0
import Qt.labs.settings 1.0

KrButtonForm {
    id:krButtonForm
    property variant text:undefined;
    property var iconURL:undefined;
    property bool active: false
    property bool center:false;
    //Colors
    property color colorBG:"#FFFFFF"
    property color colorFT:"#1E1014"
    property color colorBR:"#F1F1F1"
    property color colorBGHover:"#7badcf"
    property color colorFTHover:"#FFFFFF"
    property color colorBRHover:"#7badcf"
    property color colorBGActive:"#6d99ba"
    property color colorFTActive:"#FFFFFF"
    property color colorBRActive:"#6d99ba"
    property int   iconW:16
    property int   radius

    signal click
    buttonArea.onClicked:krButtonForm.click()
    signal dbClick
    buttonArea.onDoubleClicked:krButtonForm.dbClick()

    Component.onCompleted: {
        alignMagrin();
    }
    textButton.text: (text===undefined)?"":text
    textHide.text: (text===undefined)?"":text
    icon.source: (iconURL!==undefined)?iconURL:""
    bg.color: colorBG
    bg.radius: radius?radius:0
    bg.border.color: colorBR
    bg.height: 32
    bg.width: (text===undefined)?32:0
    textButton.visible: (text===undefined)?false:true
    textButton.color: colorFT
    textButton.width: parent.width-iconW
    rectIcon.width: iconW*2
    rectIcon.height: iconW*2

    function alignMagrin(){
        if(text!==undefined){
            if(iconURL!==undefined){
                if(textHide.width+iconW*2+(iconW-iconW/3)+iconW/4>textButton.width){
                    textButton.horizontalAlignment=Qt.AlignLeft
                    textButton.anchors.leftMargin= iconW*2
                    textButton.anchors.rightMargin= 0
                }
                if(textHide.width+iconW+iconW/2<textButton.width){
                    if(center){
                        textButton.horizontalAlignment=Qt.AlignHCenter
                        textButton.anchors.leftMargin= iconW/2
                        textButton.anchors.rightMargin= 0
                    }else{
                        textButton.anchors.leftMargin= iconW*2
                    }
                }
            }else{
                textButton.anchors.rightMargin= 0
                textButton.anchors.leftMargin= iconW/2
                if(textHide.width+iconW>textButton.width){
                    textButton.horizontalAlignment=Qt.AlignLeft
                }
                if(textHide.width<textButton.width){
                    if(center){
                        textButton.horizontalAlignment=Qt.AlignHCenter
                    }
                }
            }
        }
    }
    function setColors(opts){
        if(opts==="active"){
            textButton.color=colorFTActive;
            bg.color=colorBGActive;
            bg.border.color=colorBRActive;
        }else if(opts==="hover"){
            textButton.color=colorFTHover;
            bg.color=colorBGHover;
            bg.border.color=colorBRHover;
        }else{
            textButton.color=colorFT;
            bg.color=colorBG;
            bg.border.color=colorBR;
        }
    }
    onActiveChanged: {
        if(active){
            setColors("active")
        }else{
            setColors("")
        }
    }

    onTextChanged: {
        if(text===""){
            textButton.visible=false;
            bg.width=32
        }else{
            textButton.text= (text===undefined)?"":text
            textHide.text= (text===undefined)?"":text
            textButton.visible=true
            bg.width.valueOf()
        }
    }

    textHide.onTextChanged: {
        alignMagrin();
    }

    bg.onWidthChanged: {
        alignMagrin();
    }
    onIconURLChanged: {
        alignMagrin();
    }

    buttonArea.onHoveredChanged: {
        if(buttonArea.containsMouse){
            if(buttonArea.pressed){
                setColors("active")
            }else{
                setColors("hover")
            }
        }else{
            if(active){
                setColors("active")
            }else{
                setColors("")
            }
        }
    }
    buttonArea.onPressedChanged: {
        if(buttonArea.pressed){
            setColors("active")
        }else{
            if(active){
                setColors("active")
            }else{
                if(!buttonArea.containsMouse){
                    setColors("")
                }else{
                    setColors("hover")
                }
            }
        }
    }

}

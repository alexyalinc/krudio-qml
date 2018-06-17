import QtQuick 2.9

ButtonForm {
    id:button
    property string text                :""
    property int    textSize            :13
    property string textColor           :settings.colors.textColor
    property string textColorHover      :settings.colors.textColorHover
    property string textColorPressed    :settings.colors.textColorPressed
    property string bgColor             :settings.colors.bgColor
    property string bgColorHover        :settings.colors.bgColorHover
    property string bgColorPressed      :settings.colors.bgColorPressed
    property string borderColor         :settings.colors.borderColor
    property string borderHoverColor    :settings.colors.borderHoverColor
    property string borderPressedColor  :settings.colors.borderPressedColor
    property string nameIcon            :""
    property int    sizeIcon            :16
    property var    clicked             :function(){}
    property bool   active              :false
    property string textPosition        :"center"



    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing.type: Easing.InOutQuad
        }
    }

    //Click
    mouseAreaButton.onClicked: clicked()
    //Hover
    mouseAreaButton.hoverEnabled: true

    mouseAreaButton.onEntered   : { button.state='Hovering'}
    mouseAreaButton.onExited    : { if(!active){button.state=''}}
    mouseAreaButton.onPressed   : { button.state="Pressed" }
    mouseAreaButton.onReleased  : {
        if (mouseAreaButton.containsMouse)
            button.state="Hovering";
        else
            if(!active){ button.state="";}
    }

    onActiveChanged:  if(!active){ button.state="";}else{button.state="Hovering";}

    //Text
    textButton.text: text
    textButton.color: textColor
    textButton.font.pixelSize: textSize

    nameImageButton.sourceSize.width:sizeIcon
    nameImageButton.sourceSize.height:sizeIcon

    function start(){
        if(nameIcon!=="" && text === ""){
            nameImageButton.source = "qrc:/src/icons/"+ nameIcon +".svg";
            textButtonRectangle.visible = false;
        }
        else{
            if(nameIcon!==""){
                nameImageButton.source = "qrc:/src/icons/"+ nameIcon +".svg";
            }else{
                buttonRectangleImage.visible = false;
                textButtonRectangle.x = 0;
            }
        }
    }

    onNameIconChanged: function(){
        start();
    }

    function getAlignText(){
        if(textPosition === "center"){
            return Qt.AlignCenter;
        }

        if(textPosition === "left"){
            textButton.leftPadding = 5;
            return Qt.AlignLeft;
        }

        if(textPosition === "right"){
            return Qt.AlignRight;
        }

        if(textPosition === "top"){
            return Qt.AlignTop;
        }

        if(textPosition === "bottom"){
            return Qt.AlignBottom;
        }
    }

    onTextPositionChanged: textButton.horizontalAlignment = getAlignText();

    Component.onCompleted: function(){
        start();
        textButton.horizontalAlignment = getAlignText();
    }

    //Style
    buttonRectangle.color: bgColor
    buttonRectangle.border.width: 1
    buttonRectangle.border.color: borderColor
    //change the color of the button in differen button states
    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: buttonRectangle
                color: bgColorHover
                border.color:borderHoverColor
            }
            PropertyChanges {
                target: textButton
                color: textColorHover
            }
        },
        State {
            name: ""
            PropertyChanges {
                target: buttonRectangle
                color: bgColor
                border.color:borderColor
            }
            PropertyChanges {
                target: textButton
                color: textColor
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: buttonRectangle
                color: bgColorPressed
                border.color:borderPressedColor
            }
            PropertyChanges {
                target: textButton
                color: textColorPressed
            }
        }
    ]

    //define transmission for the states
    transitions: [
        Transition {
            from: ""; to: "Hovering"
            ColorAnimation { duration: 200 }
        },
        Transition {
            from: "Hovering"; to: ""
            ColorAnimation { duration: 200 }
        },
        Transition {
            from: "*"; to: "Pressed"
            ColorAnimation { duration: 200 }
        }
    ]
}

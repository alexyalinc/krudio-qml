import QtQuick 2.9

ButtonForm {
    id:button
    property string text                :""
    property int    textSize            :settings.colors.textSize
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
    property bool   active              :false
    property string textPosition        :"center"
    property int    speedCircle         : 500
    property real   typeAnimation       : Easing.Linear
    property int    mx                  : 0;
    property int    my                  : 0;

    signal  clicked;

    circle.color:settings.colors.bgColorCircle

    //Click
    mouseAreaButton.onClicked: function(){
        button.clicked()
    }
    circle.states:[
        State {
            name: "Active"
            PropertyChanges {
                target: circle
                width: mouseAreaButton.width > mouseAreaButton.height ? mouseAreaButton.width*3:mouseAreaButton.height*3
                height:mouseAreaButton.width > mouseAreaButton.height ? mouseAreaButton.width*3:mouseAreaButton.height*3
                x:mx - circle.width/2
                y:my - circle.height/2
                opacity:1
            }

        },
        State {
            name: "NextActive"
            PropertyChanges {
                target: circle
                width: mouseAreaButton.width > mouseAreaButton.height ? mouseAreaButton.width*3:mouseAreaButton.height*3
                height:mouseAreaButton.width > mouseAreaButton.height ? mouseAreaButton.width*3:mouseAreaButton.height*3
                x:mx - circle.width/2
                y:my - circle.height/2
                opacity:0
            }

        },
        State {
            name: ""
            PropertyChanges {
                target: circle
                width: 0
                height:0
                x:mx - circle.width/2
                y:my - circle.height/2
                opacity:1
            }
        }
    ]


    circle.transitions:   [
        Transition {
            from: ""; to: "Active"
            NumberAnimation { properties: "x,y"; duration:speedCircle; easing.type:typeAnimation }
            NumberAnimation { properties: "width,height";duration:speedCircle; easing.type:typeAnimation }
            NumberAnimation { properties: "opacity";duration:speedCircle; easing.type:typeAnimation }
        },
        Transition {
            from: "NextActive"; to: "Active"
            NumberAnimation { properties: "x,y"; duration:speedCircle; easing.type:typeAnimation }
            NumberAnimation { properties: "width,height";duration:speedCircle; easing.type:typeAnimation }
            NumberAnimation { properties: "opacity";duration:speedCircle; easing.type:typeAnimation }
        },
        Transition {
            from: "Active"; to: "NextActive"
            NumberAnimation { properties: "x,y"; duration:speedCircle; easing.type:typeAnimation }
            NumberAnimation { properties: "width,height";duration:speedCircle; easing.type:typeAnimation }
            NumberAnimation { properties: "opacity";duration:speedCircle; easing.type:typeAnimation }
            onRunningChanged: function(){
                if(circle.state === "NextActive" && !running){
                    circle.state = "";
                }
            }
        }
    ]
    //Hover
    mouseAreaButton.hoverEnabled: true

    mouseAreaButton.onEntered   : { button.state='Hovering'}
    mouseAreaButton.onExited    : { if(!active){button.state=''}else{button.state="Pressed";}}
    mouseAreaButton.onPressed   : {
        circle.state=""
        mx = mouseAreaButton.mouseX ;
        my = mouseAreaButton.mouseY ;
        circle.x = mx ;
        circle.y = my;
        button.state="Pressed"
        circle.width = 0;
        circle.height = 0;
        circle.state="Active"

    }

    mouseAreaButton.onReleased  : {
        circle.state="NextActive"
        if (mouseAreaButton.containsMouse)
            button.state="Pressed";
        else
            if(!active){ button.state="";}
    }

    onActiveChanged:  if(!active){ button.state="";}else{button.state="Pressed";}

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
        },
        Transition {
            from: "Pressed"; to: ""
            ColorAnimation { duration: 200 }
        }
    ]
}

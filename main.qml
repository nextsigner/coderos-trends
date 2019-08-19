import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id:app
    visible: true
    width: 800
    height: 600
    visibility: 'FullScreen'
    color: 'black'
    title: 'Coderos Trends'
    property int fs: width>height?width*0.03:height*0.03
    property color c1: '#65b5b2'
    Item{
        id: xApp
        width: app.width>app.height?parent.width:parent.height
        height: app.width>app.height?parent.height:parent.width
        rotation: app.width>app.height?0:-90
        anchors.centerIn: parent
        Image {
            id: logo
            source: "maxresdefault.jpg"
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: app.fs*4
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: app.fs*2
            width: app.fs*16
            height: app.fs*10
        }

        Column{
            anchors.right: parent.right
            anchors.rightMargin: app.fs
            anchors.verticalCenter: parent.verticalCenter
            width: app.fs*20
            height: parent.height
            spacing: app.fs
            Text {
                id: tit1
                text: '<b>Coderos Trends</b>'
                font.pixelSize: app.fs*1.2
                color: app.c1
            }
            Item{width: 1;height: app.fs*2}
            Text {
                id: labelLevel
                font.pixelSize: app.fs
                color: app.c1
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                id: labelLenguajes
                font.pixelSize: app.fs*0.5
                color: app.c1
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                id: labelTec
                font.pixelSize: app.fs*0.5
                color: app.c1
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                id: labelProtocolo
                font.pixelSize: app.fs*0.5
                color: app.c1
                width: parent.width
                wrapMode: Text.WordWrap
            }
        }
        TriLevel{
            id: triLevel
            width: app.fs*8
            height: app.fs*4
            anchors.verticalCenter: parent.verticalCenter
            x:app.fs*2
            onLevelChanged: {
                var d=getLevelData()
                labelLevel.text='<b>'+d[1]+'</b>'
                labelLenguajes.text='<b>Lenguajes: </b>'+d[2]
                labelTec.text='<b>Tecnologìas vinculadas: </b>'+d[3]
                labelProtocolo.text='<b>Protocolos: </b>'+d[4]

            }
        }
    }
    Image{
        width: app.fs*8
        height: app.fs*4
        source: 'camera_area.png'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: app.fs
        anchors.left: parent.left
        anchors.leftMargin: app.fs
        Text {
            color: 'white'
            text:'Area de WebCam'
            font.pixelSize: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0-app.fs
        }
    }
    UnikSettings{id: unikSettings}
    UWarnings{}
    Shortcut {
        sequence:'Esc'
        onActivated:{
            if(app.visibility===ApplicationWindow.FullScreen){
                app.visibility="Windowed"
            }else{
                Qt.quit()
            }
        }
    }
    Shortcut {
        sequence:'Up'
        onActivated:{
            if(triLevel.level>0){
                triLevel.level--
            }
        }
    }
    Shortcut {
        sequence:'Down'
        onActivated:{
            if(triLevel.level<triLevel.arrayLevels.length-1){
                triLevel.level++
            }
        }
    }
}


import QtQuick 2.0

Item {
    id: r
    property int alturaFila
    property var coords:[]
    property var arrayLevels: []
    property int level: 0
    property int borderWidth: 2
    property var jsonLevels
    onLevelChanged: updateLevels()
    onWidthChanged: {
        setData()
    }
    onHeightChanged: {
        setData()
    }
    Rectangle{
        width:  r.width*1.1
        height: r.height*1.1
        anchors.centerIn: r
        color:app.c2
        opacity: 0.5
    }
    Column{
        id: col
        anchors.centerIn: r
        //width: r.width-(r.coords[r.coords.length-1][4]-r.coords[r.coords.length-1][6])
        spacing: 0
        Repeater{
            id: rep
            Canvas{
                id:canvas
                width: r.width
                height: r.alturaFila
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.horizontalCenterOffset: 0-width*0.01
                function setDim(){
                    width= r.width+app.fs*2
                    height= r.alturaFila
                }
                onPaint:{
                    var ctx = getContext("2d");
                    ctx.beginPath();
                    if(index===r.level){
                        ctx.fillStyle = app.c2;
                    }else{
                        ctx.fillStyle = "black";
                    }

                    ctx.beginPath();
                    ctx.strokeStyle = app.c2;
                    ctx.lineWidth = r.borderWidth;

                    ctx.moveTo(r.coords[index][0], r.coords[index][1]);
                    ctx.lineTo(r.coords[index][2],r.coords[index][3]);
                    ctx.lineTo(r.coords[index][4], r.coords[index][5]);
                    ctx.lineTo(r.coords[index][6], r.coords[index][7]);

                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }
                Rectangle{
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    color:'transparent'
                    border.width: 4
                    border.color: 'red'
                    visible: false
                }
                Text {
                    id: num
                    text: '<b>'+parseInt(index+1)+'</b>'
                    font.pixelSize: canvas.height*0.5
                    anchors.centerIn: parent
                    color: index===r.level?'black':app.c2

                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        r.level=index

                    }
                }
            }
        }
    }
    Rectangle{
        width:  r.width*1.1
        height: r.height*1.1
        anchors.centerIn: r
        color:'transparent'
        border.width: 4
        border.color: app.c2
    }
    Component.onCompleted: {
        var j=unik.getFile('levels.json')
        var json = JSON.parse(j)
        r.jsonLevels=json
        //console.log('JSON: '+JSON.stringify(json))
        for(var i=0;i<Object.keys(json).length;i++){
            var item=json['nivel-'+parseInt(i+1)]
            r.arrayLevels.push(item.num)
        }
        setData()
    }
    function getLevelData(){
        var item=r.jsonLevels['nivel-'+parseInt(r.level+1)]
        var d=[]
        d.push(item.num)
        d.push(item.nombre)
        d.push(item.lenguajes)
        d.push(item.tecno)
        d.push(item.protocolos)
        d.push(item.sueldo)
        return d;
    }
    function setData(){
        r.coords=[]
        rep.model=[]
        //r.arrayLevels=['red',  'yellow', 'pink', 'blue', 'green', 'green', 'green', 'green', 'green', 'green']
        //r.arrayLevels=['red',  'yellow', 'pink', 'blue']

        r.alturaFila=parseInt(r.height/(arrayLevels.length))
        var fac=r.width/arrayLevels.length*0.4
        for(var i=0;i<r.arrayLevels.length;i++){
            var c=[]
            for(var i2=0;i2<4;i2++){
                if(i2===0){
                    c.push(r.width/2-(fac*i))
                }
                if(i2===1){
                    c.push(r.width/2+(fac*i))
                }
                if(i2===2){
                    c.push(r.width/2+(fac*i)+fac)
                }
                if(i2===3){
                    c.push(r.width/2-(fac*i)-fac)
                }
                if(i2===0||i2===1){
                    c.push(0)
                }else{
                    c.push(r.alturaFila)
                }
            }
            r.coords.push(c)
        }
        //col.width=r.width-(r.coords[r.coords.length-1][4]-r.coords[r.coords.length-1][6])
        rep.model=r.arrayLevels
    }
    function updateLevels(){
        for(var i=0;i<r.arrayLevels.length;i++){
            col.children[i].height=r.alturaFila
            col.children[i].requestPaint()
        }
    }
}


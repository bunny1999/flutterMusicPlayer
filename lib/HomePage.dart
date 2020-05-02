import 'package:flutter/material.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'dart:math'as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  ScrollController _scrollController1;
  AnimationController _animationController;

  var isPlaying=new List<bool>.filled(20, false);
  bool startScool=true;
  // int holdPlayingVal=-1;
  double bottomBarPadding=200.0;
  bool showPaddingUpper=false;

  void refill(){
    setState(() {
      isPlaying=List<bool>.filled(20, false);
    });
  }

  int isPlayingCheck(){
    int i=-1;
    i=isPlaying.indexOf(true);
    return i;
  }

  @override
  void initState(){
    super.initState();
    _scrollController=ScrollController();
    _scrollController.addListener(forCustomScrollControl);
    _scrollController1=ScrollController();
    _scrollController1.addListener(forListViewScrollControl);
    _animationController=AnimationController(duration:Duration(seconds: 10),vsync: this)..repeat();
    print("value"+_animationController.value.toString());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  forCustomScrollControl(){
    if(_scrollController.offset == _scrollController.position.maxScrollExtent){
      setState(() {
        startScool=false;
        bottomBarPadding=0.0;
        showPaddingUpper=true;
      });
    }
    if(_scrollController.offset == _scrollController.position.minScrollExtent){
      setState(() {
        bottomBarPadding=200.0;
        showPaddingUpper=false;
      });
    }
  }

  forListViewScrollControl(){
    if(_scrollController1.offset== _scrollController.position.minScrollExtent){
      setState(() {
        startScool=true;
      });
    }
  }

  cdImage(String image){
    return CircleAvatar(
      maxRadius: 40.0,
      backgroundImage: AssetImage(image),
      // backgroundColor: Colors.orange,
      child:CircleAvatar(
        maxRadius: 10.0,
        backgroundColor: Colors.white,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(49, 60, 149, 1.0),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(Icons.music_note,size: 40.0,color: Color.fromRGBO(68, 74, 179, 1.0),),
            backgroundColor: Color.fromRGBO(49, 60, 149, 1.0),
            pinned:true,
            expandedHeight:170.0,
            flexibleSpace:FlexibleSpaceBar(
              title:Text("MyTune",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
              background: Container(
                color:Color.fromRGBO(49, 60, 150, 2.0),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width/5,
                    right: MediaQuery.of(context).size.width/5,
                  ),
                  child: Image.asset('images/musicBck.png')
                ),  
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0), 
                ),
                border: Border.all(
                  width: 3.0,color:Color.fromRGBO(68, 74, 179, 1.0)
                )
              ),
              child: Column(
                    children: <Widget>[
                      showPaddingUpper?Container(height:50.0):Container(),
                      Expanded(
                        child: 
                        ListView.builder(
                          controller: _scrollController1,
                          physics: startScool?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
                          itemCount: 20,
                          shrinkWrap: true,
                          itemBuilder: (context,i){
                           return 
                           ListTile(
                              leading: 
                              // Icon(Icons.graphic_eq),
                              AnimatedBuilder(
                                animation: _animationController,
                                child:cdImage('images/musicBck.png'), 
                                builder: (BuildContext context,Widget child){
                                  if(isPlaying[i]){
                                    return Transform.rotate(
                                      angle: _animationController.value * 2.0 * math.pi,
                                      child: child,
                                    );
                                  }else{
                                    return cdImage('images/musicBck.png');
                                  }
                                },
                              ),
                              title: Row(
                                children: <Widget>[
                                  isPlaying[i]?Icon(Icons.graphic_eq,color: Colors.orange,size: 25.0,):Container(),
                                  Text("Sothing ${i}",style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  isPlaying[i]?SizedBox(width: 25.0,):Container(),
                                  Text("sub ${i}",style:TextStyle(color: Colors.grey)),
                                ],
                              ),
                              trailing: Text("2:34",style:TextStyle(fontWeight:FontWeight.bold)),
                              onTap: (){
                                if(!isPlaying[i]){
                                  refill();    
                                  setState(() {
                                    isPlaying[i]=true;
                                  });
                                }else if(isPlaying[i]){
                                  setState(() {
                                    isPlaying[i]=false;
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                      // Container(height:70.0),
                    ],
                  )
                // ),
              ),
          ),
        ],
      ),
      bottomSheet:isPlayingCheck()>-1?BottomAppBar(
        elevation: 0.0,
        child:Padding(
          padding: EdgeInsets.only(
            //_animatedController.value
            left: bottomBarPadding
          ),
          child: Container(
            padding: EdgeInsets.only(left:10.0,),
            height:70.0,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(150.0),
              )
            ),
            child:ListTile(
              leading:AnimatedBuilder(
                animation: _animationController,
                child: CircleAvatar(
                  // backgroundColor: Colors.blue,
                  backgroundImage: AssetImage('images/musicBck.png'),
                  maxRadius: 20.0,
                ),
                builder: (BuildContext context,Widget child){
                  return Transform.rotate(
                    angle: _animationController.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Text("Sothing ${isPlayingCheck()}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                  bottomBarPadding==0.0?Text("00:35"):Text(""),
                ],
              ),
              subtitle: Row(
                children: <Widget>[
                  Expanded(child: Text("sub ${isPlayingCheck()}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                  bottomBarPadding==0.0?Text("02:35"):Text(""),
                ],
              ),
              trailing: GestureDetector(
                onTap: (){

                },
                child: CircleAvatar(
                  maxRadius:18.0,
                  backgroundColor:Colors.white,
                  child:CircleAvatar(
                    maxRadius: 16.0,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.stop,color: Colors.white,),
                  )
                ),
              ),
            ) 
          ),
        ),
      ):null,
    );
  }
}
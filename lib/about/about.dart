
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
      children : <Widget> [

      buildTop(),

        buildContent()


      ]));

  }

  Widget buildTop() {
return
    Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children : [

          buildCoverImage() ,
          Positioned (
              top: MediaQuery.of(context).size.height*0.22,
              child: buildProfilePic()),
        ]


    );

  }



Widget buildCoverImage() => Container(
  color:Colors.white,
  child: Image.asset('Asset/cover.JPG',  fit: BoxFit.cover,),
  width: double.infinity,

  height: MediaQuery.of(context).size.height*0.3,
  

  
);

  Widget buildProfilePic() => CircleAvatar(
    radius: MediaQuery.of(context).size.height*0.2/2.5,
    backgroundColor: Colors.white,
    backgroundImage: AssetImage('Asset/me.JPG'),


  );


  Widget buildContent() => Container(
    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),

    child: Column (
      children: [
        Text( "Ashish Rana Magar",textAlign: TextAlign.center,style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),),
        SizedBox(
         height: 30
        ),
        Text( "If you have any questions about the usage of app;modification as per the need; and want any custom build apps,please feel free to contact me",style: TextStyle(fontSize:16),textAlign: TextAlign.center,),
        SizedBox(
            height: 30
        ),
        Text( "Contact",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
        Text( "Email : aresrana1992@gmail.com",style: TextStyle(fontSize:16),textAlign: TextAlign.left,),


      ],

    )



    );








}
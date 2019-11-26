import 'package:flutter/material.dart';
class HomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
  
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage>
{
   //methods
   logoutUser(){
    
   }

  //UI
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: Container(

      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.pink,

        child: Container(
          margin: const EdgeInsets.only(left: 70,right: 70),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.local_car_wash),
                iconSize: 50,
                color: Colors.white,
                onPressed: logoutUser,
              ),
               IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 50,
                color: Colors.white,
                 onPressed: logoutUser,
              ),
          
            ],
          ),
        ),
      ),
    );
  }
  
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PostDetailsPage extends StatefulWidget {
    DocumentSnapshot snapshot;
PostDetailsPage({this.snapshot});
  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('Post Details'),
        backgroundColor: Colors.green,
      
      ),
      body: Card(elevation: 10,
      margin: const EdgeInsets.all(10),
      child: ListView(
         children: <Widget>[
           Container(
         
             padding: const EdgeInsets.all(10),
             child: Row(
               children: <Widget>[
                 CircleAvatar(
                   child: Text(widget.snapshot.data['title'][0]),
                   backgroundColor: Colors.green,
                   foregroundColor: Colors.white,
                 ),
                 SizedBox(width: 10,),
                 Text(widget.snapshot.data['title'],style: TextStyle(fontSize:22,color: Colors.orange ),)
               ],
             ),
           ),
           SizedBox(height: 10,),
           Container(
             margin: const EdgeInsets.all(10),
             child: Text(widget.snapshot.data['content'],style: TextStyle(fontSize: 18),),
           ),
         ],
      ),),
    );
  }
}

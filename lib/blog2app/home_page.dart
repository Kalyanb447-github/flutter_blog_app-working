import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'dart:async';

import 'package:flutter_blog_app/blog2app/post_detail_page.dart';
class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

   StreamSubscription<QuerySnapshot> subscription;
   List<DocumentSnapshot> snapshot;


   CollectionReference collectionReference=Firestore.instance.collection('Post');


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {

       snapshot=datasnapshot.documents; 
      });
    });
  }

  passsData(DocumentSnapshot snap){
      
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return PostDetailsPage(snapshot: snap,);
                }
              ));
            
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: Text('Flutter blog app'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      //drawer
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Kalyan biswas'),
              accountEmail: Text('kalyan447@gmail.com'),
              decoration: BoxDecoration(color: Colors.purple),
            ),
            ListTile(
              title: Text('First Page'),
              leading: Icon(
                Icons.cake,
                color: Colors.purple,
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Second Page'),
              leading: Icon(
                Icons.search,
                color: Colors.redAccent,
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Third Page'),
              leading: Icon(
                Icons.cached,
                color: Colors.orange,
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Forth Page'),
              leading: Icon(
                Icons.menu,
                color: Colors.green,
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.purple,
              ),
            ),

            Divider(
              height: 10,
              color: Colors.black,
            ),
               ListTile(
              title: Text('Close'),
             
              trailing: Icon(
                Icons.close,
                color: Colors.red,
                
              ),

              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      //body
      body: ListView.builder(
        itemCount: snapshot.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              passsData(snapshot[index]);
            },
                      child: Card(
              elevation: 10,
              margin: const EdgeInsets.all(10),
              child: Container(
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //for dingle letter
                    CircleAvatar(
                      child: Text(snapshot[index].data['title'][0]),
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                     SizedBox(width: 10,),
                    Container(
                      width: 210, 
                    padding: const EdgeInsets.all(10),
                      child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          Text(snapshot[index].data['title'],style: TextStyle(fontSize: 22,color: Colors.green),maxLines: 1,),
                          SizedBox(height: 5,),
                          Text(snapshot[index].data['content'], maxLines: 2,),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class FirebaseCloudCrud extends StatefulWidget {
  
  @override
  _FirebaseCloudCrudState createState() => _FirebaseCloudCrudState();
}

class _FirebaseCloudCrudState extends State<FirebaseCloudCrud> {

    final DocumentReference documentReference=Firestore.instance.document('myData/dummy');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  // Future<FirebaseUser> _signIn() async {
  //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

  //   FirebaseUser user = await _auth.signInWithGoogle(
  //       idToken: gSA.idToken, accessToken: gSA.accessToken);

  //   print("User Name : ${user.displayName}");
  //   return user;
  // }

  // void _signOut() {
  //   googleSignIn.signOut();
  //   print("User Signed out");
  // }
    _add(){
        //defining a map
    Map<String,String> data=<String,String>{
      'name':'kalyan biswas',
       'Desc':'Android dev',
    };

     documentReference.setData(data).whenComplete((){
       print('Document Added');
     }).catchError((e){
       print(e);
     });
  }
    _update(){
              //defining a map
    Map<String,String> data=<String,String>{
      'name':'Pawan Kumar',
       'Desc':'Android dev',
    };

      documentReference.updateData(data).whenComplete((){
       print('Updated data');
     }).catchError((e){
       print(e);
     });

    
  }
    _delete(){
    documentReference.delete().whenComplete((){
      print('deleted successfully');
      setState(() {
        
      });
    }).catchError((e){
      print(e);
    });
  }
   _fetch(){
     documentReference.get().then((dataSnapshot){
       if (dataSnapshot.exists) {
              setState(() {
                  myText=dataSnapshot['name']; 
              });
       }
     
     });
    
  }
   String myText=null;
   StreamSubscription<DocumentSnapshot>  subscription;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription=documentReference.snapshots().listen((dataSnapshot){
             if (dataSnapshot.exists) { 
              setState(() {
                  myText=dataSnapshot['name']; 
              });
       }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Firebase Demo"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              // onPressed: () => _signIn()
              //     .then((FirebaseUser user) => print(user))
              //     .catchError((e) => print(e)),
              child: new Text("Sign In"),
            //  onPressed: ()=>_signIn(),
              color: Colors.green,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
          //    onPressed: _signOut,
              child: new Text("Sign out"),
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _add,
              child: new Text("Add"),
              color: Colors.cyan,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _update,
              child: new Text("Update"),
              color: Colors.lightBlue,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _delete,
              child: new Text("Delete"),
              color: Colors.orange,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _fetch,
              child: new Text("Fetch"),
              color: Colors.lime,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            myText == null
                ? new Container()
                : new Text(
                    myText,
                    style: new TextStyle(fontSize: 20.0),
                  )
          ],
        ),
      ),
    );
  }
}
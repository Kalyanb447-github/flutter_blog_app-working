import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'homePage.dart';
import 'authentication.dart';

class MappingPage extends StatefulWidget{
  final AuthImplementation auth;
  MappingPage({this.auth});

  State<StatefulWidget> createState(){
    return _MappingPageState();
  }
}


enum AuthStatus{
  notSignedIn,
  signedIn
}
class _MappingPageState extends State<MappingPage>{
  AuthStatus _authStatus=AuthStatus.notSignedIn;

  @override
  void initState() { 
    
    super.initState();

    widget.auth.getCurrentUser().then((firebaseUserId){
      setState(() {
      // _authStatus= firebaseUserId  null?AuthStatus.notSignedIn:AuthStatus.signedIn;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
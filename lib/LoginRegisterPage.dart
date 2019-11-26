import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormType { login, register }

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = '';
  String _password = '';

  //methods
  bool validateAndSave() {
    final form=formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
       
    }
    else{
      return false;
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  //designs
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Blog app')),
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButton(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'email'),
        validator: (value) {
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value) {
          return _email = value;
        },

        
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
         validator: (value) {
          return value.isEmpty ? 'password is required' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/app_logo.png'),
      ),
    );
  }

  List<Widget> createButton() {
    if (_formType == FormType.register) {
      return [
        RaisedButton(
          onPressed: validateAndSave,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          color: Colors.pink,
        ),
        FlatButton(
          onPressed: moveToRegister,
          child: Text(
            'not have an account? Create Account',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          color: Colors.white,
        ),
      ];
    }

    else{
         return [
      RaisedButton(
        onPressed: validateAndSave,
        child: Text('Create Account ',style: TextStyle(fontSize: 20.0,color: Colors.white),),
        color: Colors.pink,
      ),

        FlatButton(
                  onPressed: moveToLogin,

        child: Text('Already have an Account? Login',style: TextStyle(fontSize: 14.0,color: Colors.grey),),
        color: Colors.white,
      ),
    ];
    }
  }
}

import 'package:brewfinfin/services/auth.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView}); //optional argument

  @override
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService(); //private final obj of AuthService class
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email="";
  String password ="";
  String error = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    
     return loading? Loading() : SafeArea( 
       child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text('Sign in to Brew Crew'),
            actions: <Widget>[
              TextButton.icon(
                onPressed: (){
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Register'),
                ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
            child: Form(
              key:_formKey,
              child:Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "email"),
                    validator: (String?value){
                        if(value!=null && value.isEmpty)
                        {
                          return "Username can't be empty";
                        }
                        else
                        {
                            return null; //no prob
                        }
                    },
                    onChanged: (val){ //whenever value changes
                         setState(() {
                           email=val;
                         });
                    },
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "password"),
                    obscureText: true,  //password
                    validator: (String?value){
                        if(value!=null && value.isEmpty)
                        {
                          return "Password can't be empty";
                        }
                        else
                        {
                            if(value!=null && value.length < 6)
                            {
                              return "Password must be at least 6 characters long";
                            }
                            return null; //no prob
                        }
                    },
                    onChanged: (val){
                         setState(() {
                           password=val;
                         });
                    },
                  ),
                  SizedBox(height:20.0),
                  ElevatedButton(
                    child: Text('Sign In',
                           style: TextStyle(color:Colors.white)
                           ),
                    onPressed: () async{
                        if(_formKey.currentState!.validate())
                        {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = _auth.signInWithEmailAndPassword(email, password);

                          if(result==null)
                          {
                              setState(() {
                                error = "Invalid credentials";
                                loading = false;
                              });
                          }
                        }
                    },
                  ),
                  SizedBox(height:20),
                  Text(
                     error,
                     style: TextStyle(color: Colors.red, fontSize: 14)
                  ),
                ]
              )
            ),
     
          ),
       ),
     );
  }
  
}
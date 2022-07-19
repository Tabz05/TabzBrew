import 'package:brewfinfin/screens/home/settings_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:brewfinfin/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:brewfinfin/services/database.dart';
import 'package:brewfinfin/screens/home/brew_list.dart';

import '../../models/brew_model.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

     void _showSettingsPanel(){
      showModalBottomSheet(context: context,
       builder: (context){
           return Container(
                 padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 60.0),
                 child: SettingsForm(),
           );
       });
     }

    return StreamProvider<List<Brew>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
         backgroundColor: Colors.brown[50],
         appBar: AppBar(
          title: Text('Brew crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
             TextButton.icon(
              onPressed: () async{
              await _auth.signOut();
             },
              icon: Icon(Icons.person,color: Colors.black,),
               label: Text('Log out',style: TextStyle(color: Colors.black),)),
               TextButton.icon(
                 icon: Icon(Icons.settings,color: Colors.black,),
                 label: Text('settings',style: TextStyle(color: Colors.black),),
                 onPressed: () => _showSettingsPanel(),
               )
          ],
         ),
         body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()
          ),
      ),
    );
  }
}
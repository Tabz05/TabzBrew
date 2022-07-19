import 'package:brewfinfin/models/user_model.dart';
import 'package:brewfinfin/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brewfinfin/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
 
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String? currentName;
  String? currentSugars;
  int? currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

      return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {  //snapshot is flutter's not firebase

          if(snapshot.hasData)
          {
            
            UserData? userData = snapshot.data;

            return Form(
             key:_formKey,
             child: Column(
              children: <Widget>[
                Text('Update your brew Settings',style: TextStyle(fontSize: 18.0)),
                SizedBox(height:20.0),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (String?value){
                            if(value!=null && value.isEmpty)
                            {
                              return "Please enter a name";
                            }
                            else
                            {
                                return null; //no prob
                            }
                        },
                        onChanged: (val){
                             setState(() {
                               currentName=val;
                             });
                        },
                ),
                SizedBox(height:20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: currentSugars ?? userData.sugars,
                   items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                        );
                   }).toList(),
                   onChanged: (val){ //whenever value changes
                      setState(() 
                      {
                        currentSugars = val.toString();
                      });
                   }
                ),
                
                Slider(
                  value:currentStrength!=null ? currentStrength!.toDouble() : userData.strength.toDouble(),
                  activeColor: currentStrength!=null ?Colors.brown[currentStrength!] : Colors.brown[100],
                  inactiveColor: Colors.brown[50],
                  min:100,
                  max:900,
                  divisions: 8,
                  onChanged: (val) => setState(() {
                     currentStrength = val.round();
                  }),
                ),
      
                ElevatedButton(
                   child: Text('update',style: TextStyle(color: Colors.white)),
                   onPressed: () async{
                    
                    if(_formKey.currentState!.validate())
                    {
                      await DatabaseService(uid:user.uid).updateUserData(
                         currentSugars ?? userData.sugars,
                         currentName ?? userData.name,
                         currentStrength ?? userData.strength,
                      );

                      Navigator.pop(context); //remove bottom sheet
                    }
                   },
                )
              ],
             )
          );
          }

          else
          {
             //throw (""); 
             return SizedBox(height: 20,);
          }

        }
      );

  }
}
import 'package:brewfinfin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/brew_model.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({this.uid});
  //DatabaseService(this.uid);

  //collection reference (brew)
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");
  
  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot)
  {
    try
    {
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get("name") ?? '',
        strength: doc.get("strength") ?? 0,
        sugars: doc.get("sugars") ?? '0',
      );
    }).toList();
    }catch(e)
    {
      print(e.toString());
      return [];
    }
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid:uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  //get brews stream

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream

  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
           .map(_userDataFromSnapshot);
  }
}
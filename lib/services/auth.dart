import 'package:brewfinfin/models/user_model.dart';
import 'package:brewfinfin/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user

  UserModel? _userFromFirebaseUser(User? user)
  {
    if(user!=null)
    {
      return UserModel(user.uid);
    }
    else
    {
       return null;
    }
  }

  //auth change user stream
  Stream<UserModel?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon

  Future signInAnon() async{
    try{
       UserCredential result = await _auth.signInAnonymously();
       User? user = result.user;
       return _userFromFirebaseUser(user);
    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

  //sign in email pass

  Future signInWithEmailAndPassword(String email,String password) async{
    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

  //register email & pass

  Future registerWithEmailAndPassword(String email,String password) async{
    try{

      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      //create firestore document for the user
      await DatabaseService(uid:user!.uid).updateUserData('0','new crew member',100);

      return _userFromFirebaseUser(user);

    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

  //sign out

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

}
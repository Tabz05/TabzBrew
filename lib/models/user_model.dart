class UserModel{
  
  final String uid;

  UserModel(this.uid);  

}

class UserData{
  
  final String? uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({required this.uid,required this.sugars, required this.strength, required this.name});
}
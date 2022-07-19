import 'dart:developer';

import 'package:brewfinfin/screens/authenticate/authenticate.dart';
import 'package:brewfinfin/screens/home/home.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    print(user);
    
    if(user==null)
    {
      return Authenticate();
    }
    else
    {
      return Home();
    }

  }
}
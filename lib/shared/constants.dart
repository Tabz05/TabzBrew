import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    hintText: 'Enter email',
    fillColor: Colors.white, //background color white
    filled:true, //to enable background color,
    enabledBorder: OutlineInputBorder(  //when not in focus
                   borderSide: BorderSide(color:Colors.white, width:2.0)
                  ),
    focusedBorder: OutlineInputBorder(  //when field is in focus
                        borderSide: BorderSide(color:Colors.purple, width:2.0)
                  ),
);


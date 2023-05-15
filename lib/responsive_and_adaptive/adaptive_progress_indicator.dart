import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AdaptiveProgressIndicator extends StatelessWidget {
   AdaptiveProgressIndicator(this.os, {super.key});
   String os;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if(os=='android'){
        return  const Center(child:CircularProgressIndicator() );
      }
      return const Center(child: CupertinoActivityIndicator());
      },);
  }
}
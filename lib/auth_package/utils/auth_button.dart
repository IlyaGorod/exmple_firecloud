import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_process.dart';


class AuthButton extends StatelessWidget{

  final String providerName;
  final String icon;
  final GestureTapCallback? onPressed;
  final Color? buttonColor;



  AuthButton ({required this.providerName, required this.icon,  required this.onPressed, this.buttonColor});

  @override
  Widget build (BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: (60),
          vertical: (10)
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
         child: ElevatedButton(
          style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(15.0))),
            ),
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
          onPressed: onPressed,
          child: Row(
           children: <Widget>[
             Image.asset(icon, width: (15.0), height: (15.0)),
             Padding(
                 padding: EdgeInsets.only(left: 30),
               child: Text('$providerName')
             ),
          ],
        ),
      ),
    );
  }
}


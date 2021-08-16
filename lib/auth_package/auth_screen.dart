import 'package:example_cloud/constants/assets_name.dart';
import 'package:example_cloud/auth_package/utils/transition_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import 'utils/auth_button.dart';
import 'utils/auth_process.dart';


   class AuthScreen extends StatefulWidget {

     @override
     _AuthScreenState createState() => _AuthScreenState();
   }

   class _AuthScreenState extends State<AuthScreen> {


     @override
     Widget build(BuildContext context) {

       return Scaffold(
          appBar: AppBar(
            title: Text('Authentication Screen ' + Provider.of<TransitionAuth>(context, listen: false).provider),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: (){
                  initiateSocialLogout(context, Provider.of<TransitionAuth>(context, listen: false).provider);
                  setState(() {});
                },
              )
            ],
          ),
         body: Center(
           child: Column(
             children: <Widget> [
               AuthButton(
                 icon: AssetsName.iconGoogle,
                 buttonColor: Colors.blue,
                 providerName: AppConstants.googleProvider,
                 onPressed: () {
                   Provider.of<TransitionAuth>(context, listen: false).transitionAuth(AppConstants.googleProvider);
                    initiateSocialLogin(context, AppConstants.googleProvider);
                   setState(() { });
                 },
                ),
               AuthButton(
                 icon: AssetsName.iconFacebook,
                 buttonColor: Colors.blue,
                 providerName: AppConstants.facebookProvider,
                   onPressed: () {
                     Provider.of<TransitionAuth>(context, listen: false).transitionAuth(AppConstants.facebookProvider);
                     initiateSocialLogin(context, AppConstants.facebookProvider);
                     setState(() { });
                   },
               ),
             ],
           ),
         ),
       );
     }

}





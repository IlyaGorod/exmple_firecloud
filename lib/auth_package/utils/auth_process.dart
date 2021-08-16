import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../add_product_package/add_product_screen.dart';
import '../../constants/app_constants.dart';

     bool isLoading = false;

   _googleSignInProcess (BuildContext context) async{
     GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.signIn();
   }

   _facebookSignInProcess (BuildContext context) async{
     final result = await FacebookAuth.i.login(permissions: ["email"]);
      if(result.status == LoginStatus.success){
        await FacebookAuth.i.getUserData(fields: "email, name");
     }

   }

   Future initiateSocialLogin(BuildContext context, String provider) async {
     try {
       if (provider == AppConstants.googleProvider) {
         isLoading ? Center(child: CircularProgressIndicator())
             :Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddingProductsPage()));
           _googleSignInProcess(context);

       } else if (provider == AppConstants.facebookProvider) {
         isLoading ? Center(child: CircularProgressIndicator())
             : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddingProductsPage()));
           _facebookSignInProcess(context);
       }

     } on Exception catch (e) {
       print("$e");
     }
   }


   Future initiateSocialLogout(BuildContext context, String provider) async {
     try {
       if (provider == AppConstants.googleProvider) {
          GoogleSignIn().signOut();
       } else if (provider == AppConstants.facebookProvider){
         await FacebookAuth.instance.logOut();
       }
     } on Exception catch (e) {
       print("$e");
      }
   }
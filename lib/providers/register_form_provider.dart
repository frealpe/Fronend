import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';
  String nombre = '';  

  
  validateForm(){
      if (formKey.currentState!.validate()){
        return true;

      } else{
        print('No valido');
        return false;
      }
      
  }

}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> setDataToLink(String name) async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('name', name);
}

Future<String> getStoredData() async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  if(pref.getString('name')==null){
    pref.setString('name', '');
    return '';
  }
  return pref.getString('name')!;
}

Future<void> resetStoredData() async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.clear();
}
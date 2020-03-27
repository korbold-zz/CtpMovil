import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProv with ChangeNotifier {
  bool _isLogin = false;

  bool logen() => _isLogin;
  login() async {
    _isLogin = true;
    notifyListeners();
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: 'korbold@live.com', password: 'get321');
          

      // print('RESULTADO-------' + resp.toString());
    } catch (e) {
      return e.toString();
      
    } finally {
      _isLogin = false;
    }
    
  }

  

  void logout() {
    _isLogin = false;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:flutterappchat/widget/user_imag_picer.dart';
import 'dart:io';
class AuthForm extends StatefulWidget {
  final bool isloading;
  final void Function(String email,String username,String password,bool islogin,BuildContext ctx,File image) submitfn;
  AuthForm(this.submitfn,this.isloading);

  @override
  State<StatefulWidget> createState()=>AuthFormState();
}

class AuthFormState extends State<AuthForm> {

  final _formkey=GlobalKey<FormState>();
  bool _isLogin=true;
  String _email='';
  String _password;
  String _username='';
  File userFile;

  void _subemit(){
    final isValid= _formkey.currentState.validate();
    FocusScope.of(context).unfocus();//الاغلاق الكيبورد
    if(!_isLogin&& userFile==null)
      {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('الرجاء  قم اختيار صورة شخصية '),
          backgroundColor: Theme.of(context).primaryColor,)

        );
        return;}
    if(isValid){
      _formkey.currentState.save();
      widget.submitfn(_email.trim(),_username.trim(),_password.trim(),_isLogin,context,userFile);
    }
  }

  void _pickedImage(File pickedImage){

      userFile=pickedImage;

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(!_isLogin)
                  UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  validator: (val){
                    if(val.isEmpty||!val.contains('@'))
                      {
                        return 'ايميلك غير صحيح هي! كلاو';
                      }
                    return null;
                  },
                  onSaved: (val)=>_email=val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "ادخل الايميل "),
                ),
                if(!_isLogin)
                TextFormField(
                  autocorrect: true,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.words,
                  key: ValueKey('username'),
                  validator: (val){
                    if(val.isEmpty||val.length>6)
                    {
                      return 'عيني كلاو لازم اقصى طول 6 (أحرف,أرقام,رموز)';
                    }
                    return null;
                  },
                  onSaved: (val)=>_username=val,
                  decoration: InputDecoration(labelText: "ادخل اسم المستخدم "),
                ),

                TextFormField(
                  key: ValueKey('password'),
                  validator: (val){
                    if(val.isEmpty||val.length<7)
                    {
                      return 'عزيزي  كلاو. لازم اقل شيء 7 (أحرف,أرقام,رموز)';
                    }
                    return null;
                  },
                  onSaved: (val)=>_password=val,
                  decoration: InputDecoration(labelText: "ادخل كلمة السر "),
                  obscureText: true,
                ),
                SizedBox(height: 12,),
                if(widget.isloading)
                CircularProgressIndicator(),
                if(!widget.isloading)
                RaisedButton(
                    onPressed: _subemit,
                  child: Text(_isLogin?'تسجيل الدخول ':'انشاء تسجيل الدخول'),
                ),
                if(!widget.isloading)
                FlatButton(
                    onPressed: (){
                  setState(() {
                    _isLogin=!_isLogin;
                  });
                },
                    child: new Text(_isLogin?'انشاء حساب جديد':'هل لديك حساب مسبقا '),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

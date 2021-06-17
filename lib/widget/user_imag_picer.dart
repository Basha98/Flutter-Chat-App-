import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage)imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  State<StatefulWidget> createState()=>UserImagePickerState();
}

class UserImagePickerState extends State<UserImagePicker> {

File _pickedImage;
final ImagePicker _picker=ImagePicker();

void _pickImage(ImageSource src)async{
  final PickedImageFile =await _picker.getImage(source: src,imageQuality: 50,maxWidth: 150);
  if(PickedImageFile!=null)
    {
      setState(() {
        _pickedImage=File(PickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage);
    }
  else{
    print('No Selected image');
  }
}

  @override
  Widget build(BuildContext context) {
    return new Column(
children: [
  CircleAvatar(
    radius: 40,
    backgroundColor: Colors.grey,
    backgroundImage: _pickedImage!=null?FileImage(_pickedImage):null,
  ),
  SizedBox(height: 10),
  Row(
    mainAxisAlignment:MainAxisAlignment.spaceAround,
    children: [
      FlatButton.icon(
          onPressed: ()=>_pickImage(ImageSource.camera),
        icon:Icon(Icons.photo_camera_outlined),
        textColor:Colors.pink ,
        label: Text('التقاط صورة  \nمن الكاميرة',textAlign: TextAlign.center,style:TextStyle(color: Colors.pink)),
      ),

      FlatButton.icon(
        onPressed: ()=>_pickImage(ImageSource.gallery),
        icon:Icon(Icons.image_outlined),
        textColor:Colors.pink ,
        label: Text(' اختر صورة \nمن الاستوديو',textAlign: TextAlign.center,style:TextStyle(color: Colors.pink)),
      )
    ],
  )
],
    );
  }
}
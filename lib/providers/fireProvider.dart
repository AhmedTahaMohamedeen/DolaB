// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_debugPrint, iterable_contains_unrelated_type

import 'dart:async';
import 'dart:io';
import 'dart:math';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants/AdminInfo.dart';
import '../constants/productInfo.dart';
import '../constants/userInfo.dart';





class FireProvider with ChangeNotifier{



Admin? myAdminInfo;
UserInfoo? myUserInfo;




List<Product>? allProducts;
List<Product>? searchProducts;
List<Product>? trendProducts;

List<Admin>? allAdmins;
List<Admin>? myFollowingAdmins;
List<Admin>? trendAdmins;//20
List<Admin>? searchAdmins;







String? myId;

Future<bool>getMyUserInfo({required BuildContext context})async{

  User? myUser =await FirebaseAuth.instance.authStateChanges().first;

  if(myUser==null){print('user= null');return false;}
  else{
    myId= myUser.uid;
    DocumentSnapshot<Map<String, dynamic>> fire=await FirebaseFirestore.instance.collection('users').doc(myId).collection('info').doc(myId).get();

    myUserInfo=UserInfoo.i(fire.data()!);
    print('getMyUserInfo  done');
    return true;


  }





  //return userInfo1;

}


List<Product> homeProducts=[];
QueryDocumentSnapshot<Map<String, dynamic>>? HomeLastDoc;
getMyHomeProducts()async{


  List<Product> products1=[];
  QuerySnapshot<Map<String, dynamic>> fire=
  homeProducts.length==0
  ? await FirebaseFirestore.instance.collection('products')
     // .orderBy('date')
  .limit(50).get()
 : await FirebaseFirestore.instance.collection('products')
     // .orderBy('date')
      .startAfterDocument(HomeLastDoc  !).limit(50).get();

 List<QueryDocumentSnapshot<Map<String, dynamic>>> docs=fire.docs;
 for(var doc in docs){

   products1.add(await Product.i(doc.data()));

   HomeLastDoc=doc;


 }


 homeProducts.addAll(products1);
 print('homeProductsLength=${homeProducts.length}');



}



List<Product> myStoreProducts=[];
QueryDocumentSnapshot<Map<String, dynamic>>? MyStoreLastDoc;
getMyStoreProducts()async{


  List<Product> products1=[];
  QuerySnapshot<Map<String, dynamic>> fire=
  myStoreProducts.length==0
      ? await FirebaseFirestore.instance.collection('admins').doc(myId).collection('products').orderBy('date').limit(10).get()
      : await FirebaseFirestore.instance.collection('admins').doc(myId).collection('products').orderBy('date').startAfterDocument(MyStoreLastDoc  !).limit(10).get();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs=fire.docs;
  for(var doc in docs){

    products1.add(Product.i(doc.data()));

    MyStoreLastDoc=doc;
   // await FirebaseFirestore.instance.collection('admins').doc(myId).collection('products').doc('dd').update({'d',FirebaseFirestore.FieldValue.increment()});


  }

  myStoreProducts.addAll(products1);
  print('myStoreProductslength=${myStoreProducts.length}');
  print(myId);


}



Future<List<Map<String,dynamic>>>func(List<Product> products)async{
  List<Map<String,dynamic>> list=[];
  for(var product in products){

    list.add(await Product().getMap(product));
  }
  return list;
}





















//not used
// Future<bool>checkProductExist({required Product product})async{
//   DocumentSnapshot<Map<String, dynamic>> fire=await   FirebaseFirestore.instance.collection('admins').doc(product.userId).collection('products').doc(product.productId).get();
//   var data=fire.data();
//   if (data==null){return false;}
//   else {return true;}
//
//
//
//
//
// }







/*

void set myAdmin(Admin myAdmin){_myAdmin=myAdmin;}                                                  Admin get myAdmin =>_myAdmin!;

void set myUserInfo(UserInfoo myUserInfo){FireProvider().myUserInfo=myUserInfo;}                                  UserInfoo get myUserInfo =>_myUserInfo!;

void set myStoreProduct(List<Product> myStoreProduct){_myStoreProduct=myStoreProduct;}              List<Product> get myStoreProduct =>_myStoreProduct!;

void set allProducts(List<Product> allProducts){_allProducts=allProducts;}                          List<Product> get allProducts =>_allProducts!;

void set searchProducts(List<Product> searchProducts){_searchProducts=searchProducts;}              List<Product> get searchProducts =>_searchProducts!;

void set trendProducts(List<Product> trendProducts){_trendProducts=trendProducts;}                  List<Product> get trendProducts =>_trendProducts!;

void set allAdmins(List<Admin> allAdmins){_allAdmins=allAdmins;}                                    List<Admin> get allAdmins =>_allAdmins!;

void set myFollowingAdmins(List<Admin> myFollowingAdmins){_myFollowingAdmins=myFollowingAdmins;}    List<Admin> get myFollowingAdmins =>_myFollowingAdmins!;

void set trendAdmins(List<Admin> trendAdmins){_trendAdmins=trendAdmins;}                            List<Admin> get trendAdmins =>_trendAdmins!;

void set searchAdmins(List<Admin> searchAdmins){_searchAdmins=searchAdmins;}                        List<Admin> get searchAdmins =>_searchAdmins!;
*/










Future<void>clearImages()async{
  _imageUrl=null;
  _imageUrl1=null;
  _imageUrl2=null;
  _imageUrl3=null;
  _imageUrl4=null;
  picked=null;
  picked1=null;
  picked2=null;
  picked3=null;
  picked4=null;
  photoLoc=null;
  photoLoc1=null;
  photoLoc2=null;
  photoLoc3=null;
  photoLoc4=null;


}



Future<bool>removeImageFromStorage({required String photoLoc})async{
  try{
    await FirebaseStorage.instance.ref().child(photoLoc).delete();

    return true;

  }on Exception {return false;}

}
  ImagePicker picker=ImagePicker();


  String? _imageUrl;
  String? get imageUrl=> _imageUrl;
  File? imageFile;
  XFile? picked;
  String? photoLoc;





Future<void>addImage()async{
try{
  picked=await picker.pickImage(source: ImageSource.gallery);
  imageFile=File(picked!.path);

  debugPrint('image got');
  notifyListeners();
}on Exception catch(e){debugPrint(e.toString());}


}
  Future<bool>uploadImage({required File imageFile,required XFile picked})async{
var ran=Random().nextInt(100000000);
photoLoc='ahmed/${Uri.file(picked.path).pathSegments.last}$ran';

 try{  await FirebaseStorage.instance.ref()
      .child(
    // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
   photoLoc!

 )
      .putFile(imageFile)
      .then((value) => value.ref.getDownloadURL())
      .then((value) => _imageUrl=value);
 debugPrint('image has been uploaded');

 notifyListeners();
 return true;
 }on Exception catch(e){
   debugPrint('image upload error ');
   debugPrint(e.toString());

   notifyListeners();

   return false;
 }


}






String? _imageUrlCrop;
String? get imageUrlCrop=> _imageUrlCrop;
File? imageFileCrop;
XFile? pickedCrop;
String? photoLocCrop;
Future<File> addImageAndCrop()async{
   pickedCrop=await picker.pickImage(source: ImageSource.gallery);


     imageFileCrop=File(pickedCrop!.path);
     var finalImage=await cropMyImage(imageFileCrop!);




  return finalImage;
}


Future<File> cropMyImage(File ImageFileCrop)async{
  File? croppedFile = await ImageCropper().

  cropImage(
      sourcePath: ImageFileCrop.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x3],
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
          hideBottomControls: true,



      )





  );
  return croppedFile!;

}
Future<bool>uploadImageCrop({required File imageFileCrop,required XFile pickedCrop})async{
  var ran=Random().nextInt(100000000);
  photoLocCrop='ahmed/${Uri.file(pickedCrop.path).pathSegments.last}$ran';

  try{  await FirebaseStorage.instance.ref()
      .child(
    // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
      photoLocCrop!

  )
      .putFile(imageFileCrop)
      .then((value) => value.ref.getDownloadURL())
      .then((value) => _imageUrlCrop=value);
  debugPrint('imageCrop has been uploaded');

  notifyListeners();
  return true;
  }on Exception catch(e){
    debugPrint('image upload error ');
    debugPrint(e.toString());

    notifyListeners();

    return false;
  }


}



String? _imageUrlCropCover;
String? get imageUrlCropCover=> _imageUrlCropCover;
File? imageFileCropCover;
XFile? pickedCropCover;
String? photoLocCropCover;
Future<File> addImageAndCropCover()async{
  pickedCropCover=await picker.pickImage(source: ImageSource.gallery);


  imageFileCropCover=File(pickedCropCover!.path);
  var finalImage=await cropMyImageCover(imageFileCropCover!);




  return finalImage;
}

Future<File> cropMyImageCover(File ImageFileCropCover)async{
  File? croppedFileCover = await ImageCropper().cropImage(
      sourcePath: ImageFileCropCover.path,
      aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x3],
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
          hideBottomControls: true


      )





  );
  return croppedFileCover!;

}
Future<bool>uploadImageCropCover({required File imageFileCropCover,required XFile pickedCropCover})async{
  var ran=Random().nextInt(100000000);
  photoLocCropCover='ahmed/${Uri.file(pickedCropCover.path).pathSegments.last}$ran';

  try{  await FirebaseStorage.instance.ref()
      .child(
    // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
      photoLocCropCover!

  )
      .putFile(imageFileCropCover)
      .then((value) => value.ref.getDownloadURL())
      .then((value) => _imageUrlCropCover=value);
  debugPrint('imageCropCover has been uploaded');

  notifyListeners();
  return true;
  }on Exception catch(e){
    debugPrint('imageCover upload error ');
    debugPrint(e.toString());

    notifyListeners();

    return false;
  }


}







String? _imageUrl1;
  String? get imageUrl1=> _imageUrl1;
  File? imageFile1;
  XFile? picked1;
  String? photoLoc1;
  Future<void>addImage1()async{
    try{
      picked1=await picker.pickImage(source: ImageSource.gallery);
      imageFile1=File(picked1!.path);

      debugPrint('image got');
      notifyListeners();
    }on Exception catch(e){debugPrint(e.toString());}


  }
  Future<bool>uploadImage1({required File imageFile1,required XFile picked1})async{
    var ran=Random().nextInt(100000000);
    photoLoc1='ahmed/${Uri.file(picked1.path).pathSegments.last}$ran';

    try{  await FirebaseStorage.instance.ref()
        .child(
      // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
        photoLoc1!

    )
        .putFile(imageFile1)
        .then((value) => value.ref.getDownloadURL())
        .then((value) => _imageUrl1=value);
    debugPrint('image1 has been uploaded');

    notifyListeners();
    return true;
    }on Exception catch(e){
      debugPrint('image1 upload error ');
      debugPrint(e.toString());

      notifyListeners();

      return false;
    }


  }









  String? _imageUrl2;
  String? get imageUrl2=> _imageUrl2;
  File? imageFile2;
  XFile? picked2;
  String? photoLoc2;
  Future<void>addImage2()async{
    try{
      picked2=await picker.pickImage(source: ImageSource.gallery);
      imageFile2=File(picked2!.path);

      debugPrint('image got');
      notifyListeners();
    }on Exception catch(e){debugPrint(e.toString());}


  }
  Future<bool>uploadImage2({required File imageFile2,required XFile picked2})async{
    var ran=Random().nextInt(100000000);
    photoLoc2='ahmed/${Uri.file(picked2.path).pathSegments.last}$ran';

    try{  await FirebaseStorage.instance.ref()
        .child(
      // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
        photoLoc2!

    )
        .putFile(imageFile2)
        .then((value) => value.ref.getDownloadURL())
        .then((value) => _imageUrl2=value);
    debugPrint('image2 has been uploaded');

    notifyListeners();
    return true;
    }on Exception catch(e){
      debugPrint('image2 upload error ');
      debugPrint(e.toString());

      notifyListeners();

      return false;
    }


  }





  String? _imageUrl3;
  String? get imageUrl3=> _imageUrl3;
  File? imageFile3;
  XFile? picked3;
  String? photoLoc3;
  Future<void>addImage3()async{
    try{
      picked3=await picker.pickImage(source: ImageSource.gallery);
      imageFile3=File(picked3!.path);

      debugPrint('image got');
      notifyListeners();
    }on Exception catch(e){debugPrint(e.toString());}


  }
  Future<bool>uploadImage3({required File imageFile3,required XFile picked3})async{
    var ran=Random().nextInt(100000000);
    photoLoc3='ahmed/${Uri.file(picked3.path).pathSegments.last}$ran';

    try{  await FirebaseStorage.instance.ref()
        .child(
      // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
        photoLoc3!

    )
        .putFile(imageFile3)
        .then((value) => value.ref.getDownloadURL())
        .then((value) => _imageUrl3=value);
    debugPrint('image3 has been uploaded');

    notifyListeners();
    return true;
    }on Exception catch(e){
      debugPrint('image3 upload error ');
      debugPrint(e.toString());

      notifyListeners();

      return false;
    }


  }









  String? _imageUrl4;
  String? get imageUrl4=> _imageUrl4;
  File? imageFile4;
  XFile? picked4;
  String? photoLoc4;
  Future<void>addImage4()async{
    try{
      picked4=await picker.pickImage(source: ImageSource.gallery);
      imageFile4=File(picked4!.path);

      debugPrint('image got');
      notifyListeners();
    }on Exception catch(e){debugPrint(e.toString());}


  }
  Future<bool>uploadImage4({required File imageFile4,required XFile picked4})async{
    var ran=Random().nextInt(100000000);
    photoLoc4='ahmed/${Uri.file(picked4.path).pathSegments.last}$ran';

    try{  await FirebaseStorage.instance.ref()
        .child(
      // 'ahmed/${Uri.file(picked.path).pathSegments.last}$ran'
        photoLoc4!

    )
        .putFile(imageFile4)
        .then((value) => value.ref.getDownloadURL())
        .then((value) => _imageUrl4=value);
    debugPrint('image4 has been uploaded');

    notifyListeners();
    return true;
    }on Exception catch(e){
      debugPrint('image4 upload error ');
      debugPrint(e.toString());

      notifyListeners();

      return false;
    }


  }




}
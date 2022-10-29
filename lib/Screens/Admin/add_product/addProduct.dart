// ignore_for_file: file_names, non_constant_identifier_names, avoid_debugPrint

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:adminappp/Screens/Admin/add_product/add_product_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



import '../../../constants/deviceInfo.dart';
import '../admin_store_profile/StoreProfile.dart';

class AddProductScreen extends StatefulWidget {
  static const String route='/AddProductScreen';
  final Admin admin;

   AddProductScreen({Key? key, required this.admin}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();


   String? imageUrl;

   int? price;
   String? details;
  String? selectedSize=xl;


   String? category;

   List selectedSizes=[];

   TextEditingController _textEditingController=TextEditingController();
   var allCategories=AllCategories();
  TextStyle myStyle=TextStyle(fontWeight: FontWeight.bold);




 getCategory(){
     if(widget.admin.storeSex==kids){setState(() {
       category=allCategories.allTypeCategories[widget.admin.storeType]![kidsSex]![0];

     });}
     else{
       setState(() {category=allCategories.allTypeCategories[widget.admin.storeType]![widget.admin.storeSex]![0];});
     }

}





bool youCanAddProduct =true;
  int? productsNum;
getProductsNum()async{
  var productsNum1= await  Admin().getProductsNum(adminId: widget.admin.adminId!);
  setState(() {productsNum=productsNum1;});

  if(productsNum!>=100){setState(() {youCanAddProduct=false;});}
  if(productsNum!<=100){setState(() {youCanAddProduct=true;});}
  else{setState(() {youCanAddProduct=true;});}




}
  Product product=Product();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();


    getProductsNum();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return
      productsNum==null?
          Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            body:myShimmer(color: Theme.of(context).primaryColor),
          )

      :



      Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('اضافه منتج'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: height*.04,
      ),

      body:
      !youCanAddProduct?
          Center(child: Text('لقد تخطيت عدد المنتجات المسموح بهم يمكنك مسح بعض المنتجات',
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),

          ),)

      :



      Stack(
          children:
          [





            Form(
              key: myKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                SingleChildScrollView(
               // keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag ,

                  child: Column(
                  children: [
                    SizedBox(height: height*.01),
                    Text('المنتج الرئيسى',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: height*.018,),),
                    SizedBox(height:height*.01,),
                    bigImage(height: height),
                    SizedBox(height: height*.01),
                    Text('الالوان المتاحه',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: height*.018,),),
                    SizedBox(height: height*.01),
                    _images(height:height,width:width),



                    SizedBox(height:height*.03,),
                    _price(height: height),
                    SizedBox(height:height*.03,),




                    _kidsSex(height: height),
                    SizedBox(height: height*.025,),
                    _category(height: height),

                    SizedBox(height: height*.025,),
                    _sizes(height: height),

                    SizedBox(height: height*.025,),
                    _details(height: height),

                    SizedBox(height:height*.025,),
                    _saveButton(context: context,height:height ),
                    SizedBox(height:height*.07,),






                  ],
                ),
                ),
              ),





            ),
          ]),





    );
  }



  _images({required double height,required double width}){
    return
      SizedBox(
          height:height*.15,
          width:width,
          child: ListView(
            scrollDirection:Axis.horizontal,
            children: [
              image1(height: height),
              image2(height: height,),
              image3(height: height,),
              image4(height: height),
            ],
          )

      )

      ;
  }
  _price({required double height}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: height*.09,
          width: height*.12,

          child: Material(
            elevation: 5,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Theme.of(context).canvasColor,width: .1)),
            shadowColor: Theme.of(context).canvasColor,
            child:MyAddProductTextField(


                input: TextInputType.number,
                sFuntion: (String? s ){
                  setState(() {price=int.parse(s!);});
                  return null;},
                vFuntion: (String? v){if (v!.isEmpty){return'ادخل السعر';}return null;}
            ),
          ),
        ),
        Text('السعر : ',
          style: TextStyle(color:Theme.of(context).primaryColorDark,fontWeight: FontWeight.w800,fontSize: height*.018),
          textDirection: TextDirection.rtl,
        )
      ],
    );
  }
  _details({required double height}){
    return
      Container(
        decoration: BoxDecoration(
           // color: Theme.of(context).cardColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(10),

        ),
        padding: EdgeInsets.symmetric(horizontal: height*.015),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                height:height*.06,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('التفاصيل : ',
                    style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                    textDirection: TextDirection.rtl,


                  ),
                )

            ),
            Material(
              elevation: 5,
              shadowColor: Theme.of(context).canvasColor.withOpacity(.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: .1,color: Theme.of(context).canvasColor)
              ),
              color: Theme.of(context).cardColor,
              child: MyAddProductDetailsTextField(

                sFuntion: (s){setState(() {details=s!;});
return null;},
                vFuntion: (v){if(v!.isEmpty){return'ادخل التفاصيل';}
return null;},


              ),
            ),
          ],
        ),
      )
      ;
  }
  _sizes({required double height}){
    return
      Container(
          height: height*.3,
          decoration:BoxDecoration(
          //  color: Theme.of(context).canvasColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(10),



          ) ,


          child:Padding(
            padding:  EdgeInsets.all(height*.01),
            child:
            Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Material(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                      elevation: 1,
                      child: Container(
                        width:height*.15,height: height*.05,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(5),
                         // border: Border.all(color: Theme.of(context).canvasColor,width: .1)

                        ),

                        padding: EdgeInsets.symmetric(horizontal: height*.003),



                        child: DropdownButton(

                          elevation: 2,
                          iconEnabledColor: Theme.of(context).primaryColor,

                          isExpanded: true,
                          underline: Divider(height: .5,thickness: .2,color: Theme.of(context).cardColor,),
                          style: TextStyle(color:Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.015),
                          dropdownColor: Theme.of(context).cardColor,
                          alignment: Alignment.center,




                          items:
                          widget.admin.storeSex==kids?

                          allCategories.kidsSizes.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList()
                              :
                          allCategories.sizes.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList(),


                          value:selectedSize ,
                          onChanged: (String? value){
                            if(!selectedSizes.contains(value)) {setState(() {selectedSizes.add(value);});}
                          },







                        ),
                      ),
                    ),

                    Text('إختر المقاسات : ',
                      style:TextStyle(color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl,),

                  ],),

                Expanded(

                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        shadowColor: Theme.of(context).canvasColor,
                        color: Theme.of(context).cardColor,


                        child: GridView.builder(
                          gridDelegate:   SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: height*.08,
                              crossAxisSpacing: .5,
                              childAspectRatio: .5,
                              mainAxisExtent: height*.07,
                              mainAxisSpacing: .5
                          ),

                          scrollDirection: Axis.vertical,
                          itemCount: selectedSizes.length,



                          itemBuilder: (context, index) =>  Padding(
                            padding:  EdgeInsets.all(height*.006),
                            child: InkWell(
                              onTap: (){setState(() {selectedSizes.remove(selectedSizes[index]);});},
                              child: Stack(
                                children: [
                                  Material(



                                    color: Theme.of(context).primaryColor,
                                    shadowColor: Theme.of(context).canvasColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(color: Theme.of(context).canvasColor,width: .1 )
                                    ),

                                    child: SizedBox(

                                        height: height*.06,width: height*.08,

                                        child: Center(child: Text(selectedSizes[index],style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.012),textAlign: TextAlign.center,textDirection: TextDirection.rtl))),
                                  ),
                                  Positioned(
                                    right: 0,top: 0,
                                    child: InkWell(

                                      onTap: (){setState(() {selectedSizes.remove(selectedSizes[index]);});},

                                      child: Icon(Icons.cancel,color: Theme.of(context).iconTheme.color!.withOpacity(.5),size: height*.02,),



                                    ),





                                  )
                                ],
                              ),

                            ),
                          ),

                        )


                    ),
                  ),
                )
              ],
            ),
          )



      )
      ;
  }
  _category({required double height}){


  return
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Material(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(5),
          elevation: 1,
          child: Container(

            width:height*.15,height: height*.05,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(5)

            ),
            padding: EdgeInsets.symmetric(horizontal: height*.003),

            child:  DropdownButton(
              elevation: 2,
              iconEnabledColor: Theme.of(context).primaryColorDark,

              isExpanded: true,
              underline: Divider(height: .5,thickness: .2,color: Theme.of(context).cardColor,),
              style:TextStyle(color:Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.015),
              dropdownColor: Theme.of(context).cardColor,
              alignment: Alignment.center,

              items:
              widget.admin.storeSex==kids ?
              allCategories.allTypeCategories[widget.admin.storeType]![kidsSex]!.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList()
                  :
              allCategories.allTypeCategories[widget.admin.storeType]![widget.admin.storeSex]!.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList(),





              value: category,
              onChanged: (String? value){setState(() {category=value!;debugPrint(category.toString());});},







            ),
          ),
        ),
        Text('إختر نوع المنتح   ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
            textDirection: TextDirection.rtl),



      ],
    )
    ;
  }



  String kidsSex=boys;
Widget _kidsSex({required double height}){
  if(widget.admin.storeSex==kids){
    return

      Container(

        height: height*.22,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    InkWell(
                      onTap: (){setState(() {kidsSex=boys;});},

                      child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        elevation: kidsSex==boys ?1:100,
                        child: Container(
                          height: height*.15,width: height*.15,
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/search_images/boysClothes.jpg'),fit: BoxFit.fill
                              )
                          ),
                          alignment: Alignment.center,
                          child: Text('أولاد',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: height*.03,fontWeight: FontWeight.bold,
                              shadows: [BoxShadow(color: Colors.black,spreadRadius: 5,blurRadius: 5)]

                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                    Radio(value: boys, groupValue: kidsSex,
                        onChanged: (s){setState(() {kidsSex=boys;});},
                       ),



                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    InkWell(
                      onTap:(){setState(() {kidsSex=girls;});} ,
                      child: Material(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        elevation:  kidsSex==girls ?1:100,
                        child: Container(
                          height: height*.15,width: height*.15,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/images/search_images/girlsClothes.jpg'),fit: BoxFit.fill
                            )
                          ),
                          alignment: Alignment.center,
                          child: Text('بنات',
                            style: TextStyle(
                                color:Colors.white,
                                fontSize: height*.03,fontWeight: FontWeight.bold,
                                shadows: [BoxShadow(color: Colors.black,spreadRadius: 5,blurRadius: 5)]

                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                    Radio(value: girls, groupValue: kidsSex,
                        onChanged: (s){setState(() {kidsSex=girls;});},

                    ),


                  ],
            ),

      ],
    ),
  )


    ;}
  else{return SizedBox();}

}


_save({required BuildContext context})async{
  var fire=Provider.of<FireProvider>(context,listen: false);
  var myId=fire.myId;

  if(selectedSizes.length==0){
    MyFlush().showFlush(context: context, text: 'من فضلك أضف المقاسات ');
    return;}


  if(myKey.currentState!.validate()){


    MyIndicator().loading(context);
    myKey.currentState!.save();
    debugPrint ('save done');
    //jacket underShirt boxer

    if (picked==null) {
                                Navigator.pop(context);
                                MyFlush().showFlush(context: context, text: 'من فضلك اختر صوره');
                                return;}
    else{
                            debugPrint('picked1${picked1.toString()}');
                            debugPrint('picked2${picked2.toString()}');
                            debugPrint('picked3${picked3.toString()}');
                            debugPrint('picked4${picked4.toString()}');
                            if(picked1!=null){
                            if(await fire.uploadImage1(imageFile1: imageFile1!, picked1: picked1!)){debugPrint('image1 done');}
                            else{ debugPrint('image1 uploadError');}}

                            if(picked2!=null){
                            if(await fire.uploadImage2(imageFile2: imageFile2!, picked2: picked2!)){debugPrint('image2 done');}
                            else{debugPrint('image2 uploadError');}}

                            if(picked3!=null){
                            if(await fire.uploadImage3(imageFile3: imageFile3!, picked3: picked3!)){debugPrint('image3 done');}
                            else{debugPrint('image3 uploadError');}}

                            if(picked4!=null){
                            if(await fire.uploadImage4(imageFile4: imageFile4!, picked4: picked4!)){debugPrint('image4 done');}
                            else{debugPrint('image4 uploadError');}}

                             if(! await fire.uploadImage(imageFile: imageFile!,picked: picked!)) {
                                                          Navigator.pop(context);
                                                        MyFlush().showFlush(context: context, text: 'خطأ حاول مره اخرى');
                                                        return;}

      else{

        var id= await FirebaseFirestore.instance.collection('products').doc().id;


        setState(() {
          product=Product(
              userId: myId!,

              imageUrl:fire.imageUrl,
              imageUrl1:fire.imageUrl1==null?'none':fire.imageUrl1,
              imageUrl2:fire.imageUrl2==null?'none':fire.imageUrl2,
              imageUrl3:fire.imageUrl3==null?'none':fire.imageUrl3,
              imageUrl4:fire.imageUrl4==null?'none':fire.imageUrl4,
              photoLoc:fire.photoLoc,
              photoLoc1:fire.photoLoc1==null?'none':fire.photoLoc1,
              photoLoc2:fire.photoLoc2==null?'none':fire.photoLoc2,
              photoLoc3:fire.photoLoc3==null?'none':fire.photoLoc3,
              photoLoc4:fire.photoLoc4==null?'none':fire.photoLoc4,

              sizes: selectedSizes,
              details: details,
              likes: 0,
              price:price ,
              productId: id,
              category: category,


              sex: widget.admin.storeSex,
              type: widget.admin.storeType,
             // governorate: widget.admin.governorate,
              city: widget.admin.city,
              views: 0,
              priceBeforeSale: null,
              sale: false,
            date: Timestamp.now(),
            kidsSex: widget.admin.storeSex==AllCategories().sexCategory[2]?kidsSex:null,









          );
        });

        await Product().addProduct(product);
        await fire.clearImages();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, StoreProfileScreen.route,);
        MyFlush().showUploadingDoneFlush(context: context);




      }
    }






  }
  else{return;}


}



Widget _saveButton({required BuildContext context,required double height}){
  return InkWell(
      onTap: ()async{_save(context: context,);},

      child: Container(
        width: height*.25,
        height: height*.08,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).canvasColor,width: .3),
          boxShadow: [BoxShadow(color: Theme.of(context).canvasColor,blurRadius: 5,spreadRadius: .1)]

        ),
        alignment: Alignment.center,
        child:  Text('إضافه المنتج',style: TextStyle(color: Theme.of(context).cardColor,fontWeight: FontWeight.w700,fontSize: height*.018),
        textDirection: TextDirection.rtl),


      )
  );
}















  File? imageFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  File? imageFile4;
  XFile? picked;
  XFile? picked1;
  XFile? picked2;
  XFile? picked3;
  XFile? picked4;


  Widget bigImage({required double height}){
    if (imageFile==null){
      return Container(
        height: height*.25,
        width: height*.25,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(1),
          borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Theme.of(context).canvasColor.withOpacity(.5),blurRadius: 5,spreadRadius: .1)]



        ),
        alignment: Alignment.center,
        child:
          EbottonI(
            child: Text('إختر صوره',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:height*.013 )),
            icon: Icon(Icons.photo,color: Theme.of(context).iconTheme.color,size: height*.02,),
            elevation: 3,
            shadowcolor: Theme.of(context).canvasColor.withOpacity(.5)             ,
            backgroundcolor: Theme.of(context).primaryColor,
            alignmentt: Alignment.center,
            borderRadius: 10,
            padding: height*.015,
            onpressed: ()async{
              var fire=Provider.of<FireProvider>(context,listen: false);

              await fire.addImage();
              setState(() {
                imageFile=fire.imageFile;
                picked=fire.picked;


              });
            },
          )
        //Image(image: AssetImage('assets/images/cover.png'),width: 100,height: 100,),

      );}
    else {return
      InkWell(
        onTap: ()async{
          var fire=Provider.of<FireProvider>(context,listen: false);

          await fire.addImage();
          setState(() {
            imageFile=fire.imageFile;
            picked=fire.picked;


          });
        },
        child: Stack(

          children: [
            Container(
              height: height*.25,
              width: height*.25,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: FileImage(imageFile!,),
                    fit: BoxFit. contain
                )
            ),
    ),
            Positioned(
              bottom: 0,right: 0,
              child: Container(
                width: height*.08,
                height: height*.03,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor.withOpacity(.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                   // topRight:  Radius.circular(10),

                  )
                ),
                child: Text('تغيير الصوره',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.014),textAlign: TextAlign.center),


              ),

            )
          ],
        ),
      );}
}

  _addColor({required double height,required VoidCallback onTap}){
    return InkWell(
      onTap: onTap,
        child: Container(
          height: height*.15,width: height*.1,
          decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Theme.of(context).canvasColor.withOpacity(.5),blurRadius: 5,spreadRadius: .1)]
          ),
          alignment: Alignment.center,
          margin:EdgeInsets.symmetric(horizontal: height*.005,vertical:height*.005 ) ,

          child: Icon(Icons.add,color: Theme.of(context).iconTheme.color,size: height*.03),
        ),


    );
  }

image1onTap()async{
  var fire=Provider.of<FireProvider>(context,listen: false);

  await fire.addImage1();
  setState(() {
    imageFile1=fire.imageFile1;
    picked1=fire.picked1;


  });
}
image2onTap()async{
  var fire=Provider.of<FireProvider>(context,listen: false);

  await fire.addImage2();
  setState(() {
    imageFile2=fire.imageFile2;
    picked2=fire.picked2;


  });
}
image3onTap ()async{
  var fire=Provider.of<FireProvider>(context,listen: false);

  await fire.addImage3();
  setState(() {
    imageFile3=fire.imageFile3;
    picked3=fire.picked3;


  });
}
image4onTap()async{
  var fire=Provider.of<FireProvider>(context,listen: false);

  await fire.addImage4();
  setState(() {
    imageFile4=fire.imageFile4;
    picked4=fire.picked4;


  });
}


  Widget image1({required double height}){
    if (imageFile1==null){
      return _addColor(height: height, onTap: image1onTap);}
    else {return
      InkWell(
        onTap: image1onTap,
        child: Container(
          height: height*.15,width: height*.1,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: FileImage(imageFile1!,),
                  fit: BoxFit. contain
              )
          ),
          alignment: Alignment.center,
          margin:EdgeInsets.symmetric(horizontal: height*.005) ,

        ),


      );}

  }


  Widget image2({required double height}){
    if (imageFile2==null){
      return _addColor(height: height, onTap: image2onTap);}
    else {return
      InkWell(
        onTap: image2onTap,
        child: Container(
          height: height*.15,width: height*.1,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: FileImage(imageFile2!,),
                  fit: BoxFit. contain
              )
          ),
          alignment: Alignment.center,
          margin:EdgeInsets.symmetric(horizontal: height*.005) ,

        ),


      );}

  }

  Widget image3({required double height}){
    if (imageFile3==null){
      return _addColor(height: height, onTap: image3onTap);}
    else {return
      InkWell(
        onTap: image3onTap,
        child: Container(
          height: height*.15,width: height*.1,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: FileImage(imageFile3!,),
                  fit: BoxFit. contain
              )
          ),
          alignment: Alignment.center,
          margin:EdgeInsets.symmetric(horizontal: height*.005) ,

        ),


      );}

  }

  Widget image4({required double height}){
    if (imageFile4==null){
      return _addColor(height: height, onTap: image4onTap);}
    else {return
      InkWell(
        onTap: image4onTap,
        child: Container(
          height: height*.15,width: height*.1,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: FileImage(imageFile4!,),
                  fit: BoxFit. contain
              )
          ),
          alignment: Alignment.center,
          margin:EdgeInsets.symmetric(horizontal: height*.005) ,

        ),


      );}

  }


}





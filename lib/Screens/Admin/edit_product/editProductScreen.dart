// ignore_for_file: file_names



import 'package:adminappp/Screens/Admin/admin_product_view/adminProductView.dart';
import 'package:adminappp/Screens/Admin/edit_product/edit_product_helper.dart';
import 'package:adminappp/Screens/User/edit_user/editUserPhoto.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/AdminInfo.dart';


class EditProductScreen extends StatefulWidget {
  static const  String route='/EditProductScreen';
  final Admin admin;
  final Product product;
  const EditProductScreen({Key? key, required this.admin, required this.product}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  GlobalKey<FormState>myKey1=GlobalKey<FormState>();


  Product? newProduct;


  getCategory(){
    if(widget.admin.storeSex==kids){setState(() {
      category=allCategories.allTypeCategories[widget.admin.storeType]![widget.product.kidsSex]![0];
      selectedSize=allCategories.kidsSizes[6];

    });}
    else{
      setState(() {
        category=allCategories.allTypeCategories[widget.admin.storeType]![widget.admin.storeSex]![0];
        selectedSize=allCategories.sizes[6];

      }


      );
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategory();
  }


AllCategories allCategories=AllCategories();




  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }


    return Scaffold(

      appBar: AppBar(
        title: const Text('تعديل المنتج',style: TextStyle(),),
        elevation: 1,
        centerTitle: false,

      ),

      body:

          ListView(
            padding: EdgeInsets.symmetric(horizontal: height*.005),
            dragStartBehavior:DragStartBehavior.start ,
           // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior .onDrag,
            children: [
               SizedBox(height: height*.01),
              Center(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                  elevation: 3,
                  child: Container(
                      height: height*.32,width:height*.3,
                     decoration: BoxDecoration(

                       image: DecorationImage(image: CachedNetworkImageProvider(widget.product.imageUrl!),fit: BoxFit.contain),
                       borderRadius: BorderRadius.circular(20)
                     ) ,
                  ),
                ),
              ),
              Divider(height:height*.01,thickness: .5,color: Theme.of(context).primaryColor, ),


              myPrice(height: height),
              Divider(height:height*.01,thickness: .5,color: Theme.of(context).primaryColor, ),

              mySize(height: height),
              Divider(height:height*.01,thickness: .5,color: Theme.of(context).primaryColor, ),

              myCategory(height: height),
              Divider(height:height*.01,thickness: .5,color: Theme.of(context).primaryColor, ),

              myDetails(height: height),
              Divider(height:height*.01,thickness: .5,color: Theme.of(context).primaryColor, ),
              _saleButton(context:context,height: height),


            ],

          ),




    );
  }
  

  TextStyle nameStyle=TextStyle(color: Colors.white,fontWeight: FontWeight.bold);
  TextStyle valueStyle=TextStyle(color: Colors.white,fontSize: 12);
  BoxDecoration boxDecoration1=BoxDecoration(color: Colors.white.withOpacity(.1));


  int price=0;
  bool myPricePressed=false;
  myPrice({required double height}){

    if(!myPricePressed){
      return
        SizedBox(
          height: height*.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editIcon(context: context,onTap: (){setState(() {myPricePressed=!myPricePressed;});}, height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' جنيه ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                    textDirection: TextDirection.ltr,),
                  Text(' ${widget.product.price}  ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                    textDirection: TextDirection.ltr,),
                  Text('السعر : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                    textDirection: TextDirection.rtl,),
                ],
              ),

            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor,)),
        child: Container(
          color: Theme.of(context).cardColor.withOpacity(.1),
          height: height*.25,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
            children: [
              SizedBox(
                height: height*.06,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(' جنيه ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr,),
                    Text(' ${widget.product.price}  ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr,),
                    Text('السعر : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl,),
                  ],
                ),
              ),




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                   //  color: Colors.blue,
                    height: height*.09,
                    width: height*.12,

                    child: Form(
                        key: myKey1,
                        child: MyEditProductTextField(

                          vFuntion: (v){if(v!.isEmpty){return'ادخل السعر';}
return null;},
                          sFuntion: (s){setState(() {price=int.parse(s!);});
return null;},
                          input: TextInputType.number,



                        )

                    ),
                  ),
                  Text('السعر الجديد : ', style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: height*.018
                  ),
                    textDirection: TextDirection.rtl,
                  )
                ],
              ),
              SizedBox(height: height*.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 MySaveButton(onpressed:  ()async{

                   if(!myKey1.currentState!.validate()){return;}
                   else{
                     myKey1.currentState!.save();

                     await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key:productPrice,newValue: price);
                     Navigator.push(context,MaterialPageRoute(builder: (context) => AdminProductView( product: widget.product,)) );




                   }


                 }),
                MyCloseButton(onpressed: (){
                  setState(() {
                    myPricePressed=!myPricePressed;
                  });
                }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }








  List selectedSizes=[];
  String selectedSize=AllCategories().sizes[4];
  bool mySizePressed=false;
  mySize({required double height}){
    if(!mySizePressed){
      return
        SizedBox(
          height: height*.15,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  editIcon(context: context,onTap: (){setState(() {mySizePressed=!mySizePressed;});}, height: height),
                  Text('المقاسات : ',style:TextStyle(color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold,fontSize: height*.018),
                    textDirection: TextDirection.rtl,),
                ],
              ),

              Container(
                height: height*.06,
                alignment: Alignment.center,
              //  color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: height*.02),
                child:  GridView.builder(

                  gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: height*.08,
                    crossAxisSpacing: .1,
                    childAspectRatio: .1,
                    mainAxisExtent: height*.07,
                    mainAxisSpacing: .1,




                  ),

                  scrollDirection: Axis.horizontal,
                  itemCount: widget.product.sizes!.length,



                  itemBuilder: (context, index) =>  Padding(
                    padding:   EdgeInsets. all( height*.007),
                    child:
                    Material(
                      color: Theme.of(context).primaryColor,
                      elevation: 2,
                      shadowColor: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(5),

                      child: Center(child: Text(widget.product.sizes![index],
                          style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.01,),
                          textAlign: TextAlign.center,textDirection: TextDirection.rtl,)),
                    ),
                  ),

                ),
              )


            ],
          ),
        );
    }

    else{
      setState(() {
        selectedSizes=widget.product.sizes!;
      });



      return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor,)),
        child: Container(
          //color: Theme.of(context).cardColor.withOpacity(.1),
          height: height*.4,
          padding: EdgeInsets.symmetric(horizontal: height*.015),


          child: Column(
            children: [


              Container(
                // color: Colors.blue,
                height: height*.3,
                child: Column(
                  children: [
                    SizedBox(
                      height:height*.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Container(
                            width:height*.15,height: height*.05,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,

                                borderRadius: BorderRadius.circular(5)

                            ),
                            padding: EdgeInsets.symmetric(horizontal: height*.003),

                            child: DropdownButton(

                              elevation: 2,
                              iconEnabledColor: Theme.of(context).iconTheme.color,

                            isExpanded: true,
                              underline: Divider(height: .5,thickness: .2,color: Colors.transparent,),
                              style: TextStyle(color:Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.bold,fontSize: height*.015),
                              dropdownColor: Theme.of(context).primaryColor,
                              alignment: Alignment.center,




                              items: widget.admin.storeSex==kids?
                              allCategories.kidsSizes.map((e) => DropdownMenuItem(child: Text(e, style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.015), textAlign: TextAlign.center,textDirection: TextDirection.rtl,), value: e.toString(),)).toList()
                              :     allCategories.sizes.map((e) => DropdownMenuItem(child: Text(e, style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.015,), textAlign: TextAlign.center,textDirection: TextDirection.rtl), value: e.toString(),)).toList()


                              ,


                              value:selectedSize ,
                              onChanged: (String? value){

                                if(!selectedSizes.contains(value))
                                {setState(() {selectedSizes.add(value);});}



                              },







                            ),
                          ),

                          Text('إختر المقاسات : ',
                            style:TextStyle(color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,fontSize: height*.018),
                            textDirection: TextDirection.rtl,),

                        ],),
                    ),
                    Expanded(

                      child: Material(
                        elevation: 1,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: Theme.of(context).canvasColor,
                          color: Theme.of(context).primaryColorLight,


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

                                        child: Center(child: Text(selectedSizes[index],style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.012),textAlign: TextAlign.center,textDirection: TextDirection.rtl)),
                                      ),
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
                    )
                  ],
                ),
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 MySaveButton(onpressed: ()async{
                   MyIndicator().loading(context);
                   if(selectedSizes.length==0){ Navigator.pop(context);snack(context: context, message: 'إختر المقاسات'); return ;}


                   await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productSizes,newValue: selectedSizes);
                   Navigator.push(context,MaterialPageRoute(builder: (context) => AdminProductView( product: widget.product,)) );


                 }),
                 MyCloseButton(onpressed: (){
                   setState(() {
                     mySizePressed=!mySizePressed;
                   });
                 }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }





  String? category;
  bool myCategoryPressed=false;
  myCategory({required double height}){
    if(!myCategoryPressed){
      return
        SizedBox(
          height: height*.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             editIcon( context: context,onTap: (){setState(() {myCategoryPressed=!myCategoryPressed;});}, height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.product.category!,style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                    textDirection: TextDirection.ltr,),
                  Text('نوع المنتج : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                       textDirection: TextDirection.rtl,),
                ],
              ),

            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor,)),
        child: Container(
          color: Theme.of(context).cardColor.withOpacity(.1),
          height: height*.2,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
            children: [
              SizedBox(
                height: height*.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.product.category!,style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr,),
                    Text('نوع المنتج : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl,),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(

                    width:height*.15,height: height*.05,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,

                        borderRadius: BorderRadius.circular(5)

                    ),
                    padding: EdgeInsets.symmetric(horizontal: height*.003),

                    child:  DropdownButton(
                      elevation: 2,
                      iconEnabledColor: Theme.of(context).iconTheme.color,

                      isExpanded: true,
                      underline: Divider(height: .5,thickness: .2,color: Theme.of(context).canvasColor,),
                      style:TextStyle(color:Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.bold,fontSize: height*.015),
                      dropdownColor: Theme.of(context).primaryColor,
                      alignment: Alignment.center,

                      items:
                          widget.admin.storeSex==kids?
                  allCategories.allTypeCategories[widget.admin.storeType]![widget.product.kidsSex]!.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList()

          :

                      allCategories.allTypeCategories[widget.admin.storeType]![widget.admin.storeSex]!.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList(),


                      value:category ,
                      onChanged: (String? value){
                        setState(() {

                          category=value!;
                        });},







                    ),
                  ),
                  Text('إختر نوع المنتح',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl),

                ],
              ),
              SizedBox(height: height*.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  MySaveButton(onpressed: ()async{
                    MyIndicator().loading(context);

                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productCategory,newValue: category);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AdminProductView( product: widget.product,)) );


                  }),
                  MyCloseButton(onpressed: (){
                    setState(() {
                      myCategoryPressed=!myCategoryPressed;
                    });
                  }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }





  String details='no';
  bool myDetailsPressed=false;
  TextEditingController _textEditingController=TextEditingController();
  myDetails({required double height}){
    if(!myDetailsPressed){
      return
        SizedBox(

          height: height*.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             editIcon(context: context,onTap: (){setState(() {myDetailsPressed=!myDetailsPressed;});}, height: height),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [

                    Expanded(
                      child: Padding(
                       padding:EdgeInsets.only(left: height*.03),
                        child: Text(' ${widget.product.details}  ',
                          style:TextStyle(
                              color:  Theme.of(context).primaryColor,
                              fontSize: height*.012 ,),
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          maxLines: 2,




                        ),
                      ),
                    ),
                    Text('التفاصيل : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl,),
                  ],
                ),
              ),

            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor,)),
        child: Container(
         // color: Theme.of(context).cardColor.withOpacity(.1),
         // height: height*.25,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
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
              Padding(
                  padding:  EdgeInsets.all(height*.015),
                  child:

                  Form(
                    key: myKey,
                    child:MyEditProductDetailsTextField(

                      sFuntion: (s){setState(() {details=s!;});
return null;},
                      vFuntion: (v){if(v!.isEmpty){return'ادخل التفاصيل';}
return null;},
                      value: widget.product.details,

                    )
                    ,
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 MySaveButton(onpressed:  ()async{

                   if(!myKey.currentState!.validate()){return;}
                   else {
                     MyIndicator().loading(context);
                     myKey.currentState!.save();


                     await Product().editProduct(
                         adminId: widget.product.userId!,
                         productId: widget.product.productId!,
                         key: productDetails,
                         newValue: details);

                     Navigator.push(context, MaterialPageRoute(
                         builder: (context) =>
                             AdminProductView(product: widget.product,)));
                   }
 }),


                 MyCloseButton(onpressed:  (){
                   setState(() {myDetailsPressed=!myDetailsPressed;});
                   _textEditingController.clear();
                 }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }










_saleButton({required BuildContext context,required double height}){

    if(widget.product.sale!){
      return

        UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: Ebotton(
            onpressed: (){
              showDialog(context: context, builder: (context) =>
                  Dialog(
                    child: RemoveSaleDialog(product: widget.product,height: height),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                    elevation: 0,
                    

                  ),
              );
            },
            child: Row(
              children: [
                Icon(Icons.close,color: Colors.white,size: height*.022),
                Text('إلغاء الخصم',style: TextStyle(
                    color:Colors.white
                    //Theme.of(context).textTheme.bodySmall!.color
                    ,fontSize: height*.018,
                    fontWeight: FontWeight.bold
                ),

                ),
              ],
            ),
            padding: height*.05,
            borderRadius: 10,
            borderColor: Colors.white.withOpacity(0),
            backgroundcolor:
            Theme.of(context).primaryColor

            ,
            overColor: Colors.red,
            shadowcolor:
            Theme.of(context).canvasColor
            ,
            elevation: 1,



          ),
        )
      ;
    }
    else{  return


      UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: Ebotton(
          onpressed: (){
            showDialog(context: context, builder: (context) =>
                Dialog(
                  child: AddSaleDialog(product: widget.product,height: height),
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                  elevation: 0,

                ),);
          },
          child: Row(
            children: [
              Icon(Icons.add,color:Colors.white,size: height*.022),
              Text('إضافه خصم',style: TextStyle(
                  color:Colors.white
                  //Theme.of(context).textTheme.bodySmall!.color
                ,fontSize: height*.018,
                fontWeight: FontWeight.bold
              )
                ,

              ),
            ],
          ),
          padding: height*.05,
          borderRadius: 20,
          borderColor: Colors.white.withOpacity(0),
          backgroundcolor:
          Theme.of(context).primaryColor
          ,
          overColor: Colors.red,
          shadowcolor: Theme.of(context).canvasColor,
          elevation: 1,



        ),
      )



    ;}

}


}


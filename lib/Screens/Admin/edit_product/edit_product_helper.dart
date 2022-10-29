








import 'package:adminappp/Screens/Admin/admin_product_view/adminProductView.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSaleDialog extends StatefulWidget {
  final Product product;
  final double height;
  const AddSaleDialog({Key? key, required this.product, required this.height}) : super(key: key);

  @override
  _AddSaleDialogState createState() => _AddSaleDialogState();
}

class _AddSaleDialogState extends State<AddSaleDialog> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();

  int? priceBeforeSale;
  int? priceAfterSale;
  Product? newProduct;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height*.45,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,

        borderRadius: BorderRadius.circular(20),
        //shape: BoxShape.circle

      ),
      child: Form(
        key: myKey,
        child: ListView(
          children: [
            SizedBox(height:  widget.height*.05,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: widget.height*.13,
                  height:widget.height*.08,
                  child: MyEditProductTextField(

                    vFuntion: (v){if(v!.isEmpty){return'ادخل السعر';}
return null;},
                    sFuntion: (s){setState(() {priceBeforeSale=int.parse(s!);});
return null;},
                    input: TextInputType.number,



                  ),
                ),
                Text(':السعر قبل الخصم ',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.height*.018
                  ),
                ),

              ],
            ),


            SizedBox(height: widget.height*.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: widget.height*.13,
                  height:widget.height*.08,
                  child: MyEditProductTextField(

                    vFuntion: (v){if(v!.isEmpty){return'ادخل السعر';}
return null;},
                    sFuntion: (s){setState(() {priceAfterSale=int.parse(s!);});
return null;},
                    input: TextInputType.number,



                  ),
                ),
                Text(':السعر بعد الخصم ',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.height*.018
                  ),
                ),
              ],
            ),


            SizedBox(height:  widget.height*.05,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MySaveButton(onpressed: ()async{
                  if(!myKey.currentState!.validate()){return;}
                  else{
                    MyIndicator().loading(context);
                    myKey.currentState!.save();

                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productPriceBeforeSale,newValue: priceBeforeSale);
                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productPrice,newValue: priceAfterSale);
                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productSale,newValue: true);

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AdminProductView( product: widget.product,)) );

                    print(priceBeforeSale.toString());
                    print(priceAfterSale.toString());




                  }
                }),
                MyCloseButton(onpressed: (){Navigator.pop(context);}),
              ],
            )
          ],

        ),
      ),


    );
  }
}

class RemoveSaleDialog extends StatefulWidget {
  final Product product;
  final double height;
  const RemoveSaleDialog({Key? key, required this.product, required this.height}) : super(key: key);

  @override
  _RemoveSaleDialogState createState() => _RemoveSaleDialogState();
}

class _RemoveSaleDialogState extends State<RemoveSaleDialog> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();

  int? price;

  Product? newProduct;
  @override
  Widget build(BuildContext context) {
    return Container(

      height: widget.height*.3,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,

        borderRadius: BorderRadius.circular(20),
        //shape: BoxShape.circle

      ),
      child: Form(
        key: myKey,
        child: ListView(
          children: [
            SizedBox(height: widget.height*.015),
            Center(
              child: Text(
                'أدخل سعر المنتج',
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.height*.018
                ),
              ),
            ),
            SizedBox(
              height: widget.height*.025,
            ),



            UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: SizedBox(
                width: widget.height*.2,
                child: MyEditProductTextField(

                  vFuntion: (v){if(v!.isEmpty){return'ادخل السعر';}
return null;},
                  sFuntion: (s){setState(() {price=int.parse(s!);});
return null;},
                  input: TextInputType.number,



                ),
              ),
            ),
            SizedBox(height: widget.height*.04,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                MySaveButton(onpressed: ()async{
                  if(!myKey.currentState!.validate()){return;}
                  else{
                    MyIndicator().loading(context);
                    myKey.currentState!.save();

                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productPriceBeforeSale,newValue: null);
                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productPrice,newValue: price);
                    await Product().editProduct(adminId: widget.product.userId!,productId: widget.product.productId!,key: productSale,newValue: false);

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AdminProductView( product: widget.product,)) );


                  }
                } ),

                MyCloseButton(onpressed: (){  Navigator.pop(context);})

              ],
            )
          ],

        ),
      ),


    );
  }
}




class MyEditProductTextField extends StatelessWidget {






  TextEditingController? myController ;



  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;



  MyEditProductTextField({Key? key,



    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder outlineInputBorder= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Theme.of(context).canvasColor.withOpacity(.3), width: 1),
    );
    return InfoWidget(
        builder: (context,deviceInfo) {
          double? screenHeight=deviceInfo.screenHeight;
          double? screenWidth=deviceInfo.screenWidth;
          print(screenHeight);
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;

          }
          return TextFormField(
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:screenHeight!*.02 ),
            decoration: InputDecoration(
                fillColor: Theme.of(context).canvasColor.withOpacity(.1),
                counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: screenHeight*.015),



                filled: true,
                isCollapsed: true,
                enabled: true,
                contentPadding:  EdgeInsets.all(screenHeight*.025),
                floatingLabelBehavior: FloatingLabelBehavior.always,


                //  prefixIcon: icon,
                enabledBorder: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorder,
                focusedErrorBorder: outlineInputBorder
            ),

            obscureText: false,
            textInputAction: TextInputAction.done,
            keyboardType: input,
            enabled: true,
            minLines: 1,
            maxLines: 1,
            maxLength: 5,
            // initialValue: 'bota',

            validator:vFuntion ,
            onSaved:sFuntion ,

            controller: myController,
          );
        }
    );
  }

/*
  validator:( String v){
  if(v.isEmpty){return 'wrong';}
  return  null;
  }
   */
/*
 onPressed:(){if (!formKey.currentState.validate()) {return;}
                    formKey.currentState.save();
                    }
 */
}

class MyEditProductDetailsTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.white.withOpacity(.3);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;









  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;
  final String? value;


  MyEditProductDetailsTextField({Key? key,



    required this.vFuntion,
    required this.sFuntion,
    this.value





  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
        builder: (context,deviceInfo) {
          double? screenHeight=deviceInfo.screenHeight!;
          double? screenWidth=deviceInfo.screenWidth;
          print(screenHeight);
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;

          }
          return TextFormField(

            obscureText: false,
            textInputAction: TextInputAction.newline,

            keyboardType: TextInputType.multiline,
            enabled: true,
            // minLines: 14,
            maxLines: 15,
            maxLength: 1000,
            initialValue: value,
            validator:vFuntion ,
            onSaved:sFuntion ,
            textDirection:TextDirection.rtl ,
            scrollController: ScrollController(),

            selectionControls:CupertinoTextSelectionControls(),






            style: TextStyle(
                color:
                Theme.of(context).textTheme.bodySmall!.color
                ,
                fontSize:screenHeight!*.02 ,
                leadingDistribution: TextLeadingDistribution.even,
                textBaseline: TextBaseline.alphabetic

            ),
            decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: screenHeight*.015),
                filled: true,
                isCollapsed: true,
                enabled: true,
                contentPadding:  EdgeInsets.all(screenHeight*.025),
                focusColor: Colors.yellow,
                hoverColor: Colors.red,










                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadus),
                  borderSide: BorderSide(color: borderColor, width: borderWidth),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadus),
                  borderSide: BorderSide(color: borderColor, width: borderWidth),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadus),
                  borderSide: BorderSide(color: borderColor, width: borderWidth),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadus),
                  borderSide: BorderSide(color: borderColor, width: borderWidth),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadus),
                  borderSide: BorderSide(color: borderColor, width: borderWidth),
                )
            ),










          );
        }
    );
  }

/*
  validator:( String v){
  if(v.isEmpty){return 'wrong';}
  return  null;
  }
   */
/*
 onPressed:(){if (!formKey.currentState.validate()) {return;}
                    formKey.currentState.save();
                    }
 */
}
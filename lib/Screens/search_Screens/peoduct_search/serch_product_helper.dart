





/*class SearchGrid extends StatefulWidget {
  final List<Product> filteredProducts;
  const SearchGrid({Key? key, required this.filteredProducts}) : super(key: key);

  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  @override
  SliverGrid build(BuildContext context) {
    return  SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio:1,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: widget.filteredProducts.map((product) =>
      // Item(product:product ,)
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product: product, admin: Admin()),));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(20),

                image: DecorationImage(
                    image: CachedNetworkImageProvider(product.imageUrl!),
                    fit: BoxFit.fill
                )
            ),
          ),
        ),
      )


      ).toList(),);
  }
}*/

import 'package:adminappp/Screens/home/home_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:flutter/material.dart';

class SearchGrid extends StatefulWidget {
  final List<Product> filteredProducts;
  final List<Admin> admins;
  const SearchGrid({Key? key, required this.filteredProducts, required this.admins}) : super(key: key);

  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  @override
  SliverGrid build(BuildContext context) {
    return      SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context,index){


          return  HomeItem(product:widget.filteredProducts[index], admin:widget. admins.firstWhere((e) =>e.adminId==widget.filteredProducts[index].userId ),);},
        childCount: widget.filteredProducts.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:  2,
        childAspectRatio:.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 30,

      ),

    );
  }
}


class myFilterPriceTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(0);
  Color fillColor = Colors.white.withOpacity(.2);
  double borderRadus = 0;

  TextStyle inputTextStyle=TextStyle(color: Colors.white, fontSize:10);
  TextStyle labelTextStyle=TextStyle(color: Colors.white, fontSize:16,);




  TextEditingController? myController ;
  //final String label;
  // final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  myFilterPriceTextField({Key? key,
    //required this.label,
    this.obsecure = false,
    // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inputTextStyle,
      decoration: InputDecoration(
          fillColor:fillColor,



          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.only(bottom: 10,top: 10,left: 10,right: 10),

          errorStyle:TextStyle(fontSize: 8) ,
          // floatingLabelBehavior: FloatingLabelBehavior.auto,
          //labelText: label,
          // labelStyle: labelTextStyle,
          // prefixIcon: icon,
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
          )),

      obscureText: obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: input,
      enabled: true,
      cursorColor: Colors.white,
      textAlign: TextAlign.center,




      validator:vFuntion ,
      onSaved:sFuntion ,
      // onTap: ontapFunction,
      controller: myController,
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
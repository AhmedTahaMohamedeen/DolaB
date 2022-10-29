
import 'package:adminappp/Screens/User/user_product_view/user_product_view.dart';
import 'package:adminappp/Screens/search_Screens/peoduct_search/serch_product_helper.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/filterInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/AdminInfo.dart';
import '../../home/HomeScreen.dart';
class SearchProduct extends StatefulWidget {
  static const  String route='/SearchProduct';

  final String selectedType;
  final String selectedSex;

  const SearchProduct({Key? key, required this.selectedType, required this.selectedSex}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  List<Product>allProducts=[];
  List<Product>filteredProducts=[];

  GlobalKey<FormState>myKey=GlobalKey<FormState>();
 /* String selectedGovernorate=AllCategories().allWord;
  String selectedCity=AllCategories().allWord;*/
  Filter? filter;
  List selectedSizes=[];
  List selectedCategories=[];
  var allCategories=AllCategories();

  String? selectedSize;
  String? selectedCategory;




  int priceFrom=0;
  int priceTo=50000;
  bool sizeCheckBox=false;
  bool categoryCheckBox=false;
 // String filterSex=AllCategories().sexCategory[0];


 // String filterType=AllCategories().typeCategory[0];

  TextStyle radioStyle=TextStyle(color: Colors.white);


  TextStyle sizeDropDownStyle=TextStyle(color:Colors.white,fontWeight: FontWeight.bold);
  TextStyle categoryDropDownStyle=TextStyle(color:Colors.white,fontWeight: FontWeight.bold);
  Color sizeCheckColor=Colors.grey;
  Color categoryCheckColor=Colors.grey;

  getCategory(){
    if(widget.selectedSex==boys||widget.selectedSex==girls){
      setState(() {

        selectedSize=allCategories.kidsSizes[0];
      });
    }
    else{
      setState(() {

        selectedSize=allCategories.sizes[0];
      });
    }



    setState(() {selectedCategory=allCategories.allTypeCategories[widget.selectedType]![widget.selectedSex]![0];});

  }






List<Admin>admins=[];
 getAllProducts()async{
   List <Product> x1=[];
   List <Product> x2=[];


   List<Product> allProducts1=await Product().getAllProducts();

   if(widget.selectedSex==boys||widget.selectedSex==girls)
   {setState(() {x1=allProducts1.where((element) => element.kidsSex==widget.selectedSex).toList();});}
   else{ setState(() {x1=allProducts1.where((element) => element.sex==widget.selectedSex).toList();});}

   setState(() {x2=x1.where((element) => element.type==widget.selectedType).toList();});






      setState(() {allProducts=x2;});
      debugPrint(allProducts.toString());



  }
  getAdmins()async{

   var admins1=await Admin().getAllAdmins();
    setState(() {
      admins=admins1;
    });
  }
  func()async{
   await  getAdmins();
   await  getCategory();
   await  getAllProducts();
   doFilter(
       priceFrom: priceFrom,
       priceTo: priceTo,
       selectedCategories: selectedCategories,
       selectedSizes: selectedSizes);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    func();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('بحث '),
        elevation: 0,





      ),


      body:  CustomScrollView(
        slivers: [

          SliverList(
              delegate:SliverChildListDelegate.fixed(
                  [

                    Container(
                     // color: Colors.teal,
                      child: ExpansionTile(
                        title: Container(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('البحث  ', style: TextStyle(color: Theme.of(context).cardColor,fontSize: 16,),textAlign: TextAlign.center,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.search,color:Theme.of(context).cardColor,),
                                )
                              ],
                            )


                        ),

                        collapsedBackgroundColor:Theme.of(context).primaryColor,
                       // collapsedTextColor: Colors.white,
                        initiallyExpanded: false,
                        controlAffinity:ListTileControlAffinity.leading ,
                        expandedCrossAxisAlignment: CrossAxisAlignment.center,
                        backgroundColor: Theme.of(context).primaryColor,
                        collapsedIconColor:Theme.of(context).cardColor,
                       iconColor: Theme.of(context).cardColor,
                       // textColor: Colors.deepOrange,







                        children: [

                          SizedBox(height: 10,),

                          _fromTo(),// from  to
                          _sizes(),//sizes
                          _category(),//category
                          SizedBox(height: 30,),

                          InkWell(
                            onTap: ()async{
                              if(!myKey.currentState!.validate()){return;}
                              else{
                                MyIndicator().loading(context);

                                myKey.currentState!.save();
                                if(priceTo<=priceFrom){
                                  MyFlush().showFlush(context: context, text: 'ادخل السعر بطريقه صحيحه');
                                  Navigator.pop(context);debugPrint('price error');


                                  return;}
                                if(!sizeCheckBox&&selectedSizes.length==0){


                                  Navigator.pop(context);debugPrint('size error');
                                  MyFlush().showFlush(context: context, text: 'اختر المقاسات ');

                                  return;}

                                if(!categoryCheckBox&&selectedCategories.length==0){
                                  Navigator.pop(context);debugPrint('category error');
                                  MyFlush().showFlush(context: context, text: 'اختر النوع ');
                                  return;}
                                // debugPrint('category error');

                                doFilter(

                                  priceFrom: priceFrom,
                                  priceTo: priceTo,
                                  selectedCategories: selectedCategories,
                                 // selectedCity: selectedCity,
                                 // selectedGovernorate: selectedGovernorate,
                                  selectedSizes:selectedSizes ,
                                );

                                debugPrint(filteredProducts.length.toString());
                                var myId=Provider.of<FireProvider>(context,listen: false).myId;
                                await Filter().addFilter(filter:
                                Filter(
                                    categories: selectedCategories,
                                    sizes: selectedSizes,
                                    type: widget.selectedType,
                                    sex: widget.selectedSex,
                                    from: priceFrom,
                                    to: priceTo,

                                ), uid:myId!);

                                Navigator.pop(context);




                              }

                              },

                            child: Container(
                              height: 40,width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColorDark
                              ),
                              child: Text('إبحث',style: TextStyle(color: Theme.of(context).cardColor),),
                            ),



                          ),
                          SizedBox(height: 10,),

                        ],

                      )
                    )
                  ]
              ) ),

          SearchGrid(filteredProducts:filteredProducts ,admins: admins,)
        ],
      ),

    );
  }


  Widget _fromTo(){
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
      //  height: 100,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(5),
           // border: Border.all(color: Colors.white,width: .3)
        ),
        child: Form(
          key: myKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 75,//height: 80,
                          alignment: Alignment.center,
                          child: myFilterPriceTextField(
                            // icon: Icon(Icons.money,size: 5,),
                            input: TextInputType.number,
                            vFuntion: (v){if(v!.isEmpty){return'ادخل الحد الادنى';}
return null;},
                            sFuntion: ( s){setState(() {priceTo=int.parse(s!);});
return null;},

                          ),
                        ),
                        Text('  الى',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).cardColor),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 75,//height: 80,
                          alignment: Alignment.center,
                          child: myFilterPriceTextField(
                            // icon: Icon(Icons.money),
                            input: TextInputType.number,
                            vFuntion: (v){if(v!.isEmpty){return'ادخل الحد الاعلى ';}
return null;},
                            sFuntion: ( s){setState(() {priceFrom=int.parse(s!);});
return null;},

                          ),
                        ),
                        Text('  من',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).cardColor),),
                      ],
                    ),
                  ),




                ],
              ),
              Text('السعر',style: TextStyle(color: Theme.of(context).cardColor,fontSize: 16),)
            ],
          ),
        ),
      ),
    )
    ;
  }
  Widget _sizes(){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 120,
          decoration:BoxDecoration(
              color: Theme.of(context).cardColor,
              //borderRadius: BorderRadius.circular(5),
            //  border: Border.all(color: Colors.white,width: .3)



          ) ,


          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        Checkbox(
                          value: sizeCheckBox,
                          //activeColor: sizeCheckColor,
                          fillColor: MaterialStateProperty.all(sizeCheckColor),

                          onChanged:(s){
                            setState(() {sizeCheckBox=s!;});
                            if(sizeCheckBox){
                              sizeDropDownStyle=TextStyle(color: Colors.grey,);


                              setState(() {sizeCheckColor=Colors.orange;selectedSizes.clear();});}
                            else{setState(() {
                              sizeCheckColor=Colors.grey;
                              sizeDropDownStyle=TextStyle(color:Colors.orange,fontWeight: FontWeight.bold);
                            });}


                          },
                        ),
                        Text('الكل',style: TextStyle(color: sizeCheckColor,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: [


                        DropdownButton(
                          borderRadius:BorderRadius.circular(10) ,
                          elevation: 20,
                          // iconEnabledColor: color_2,
                          // underline: Divider(height: 1,thickness: 1,color: color_2,),
                          style: sizeDropDownStyle,
                          dropdownColor: Colors.black,

                          items:
                              widget.selectedSex==boys||widget.selectedSex==girls?
                              allCategories.kidsSizes.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList()
                          :
                              allCategories.sizes.map((e) => DropdownMenuItem(child: Text(e), value: e.toString(),)).toList(),


                          value:selectedSize ,
                          onChanged: (String? value){
                            setState(() {
                              sizeCheckBox=false;
                              sizeCheckColor=Colors.grey;
                              sizeDropDownStyle=TextStyle(color:Colors.orange,fontWeight: FontWeight.bold);
                            });

                            if(!selectedSizes.contains(value))
                            {setState(() {selectedSizes.add(value);});}







                          },







                        ),
                        Text(':  المقاسات',style: TextStyle(color: backColor2)),
                      ],
                    ),





                  ],),
                Container(
                  //  color: Colors.black,
                    height: 50,
                   width:200,
                    child: GridView.builder(
                    //  physics: NeverScrollableScrollPhysics(),
                      // reverse: true,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 30,
                        crossAxisSpacing: .05,
                        childAspectRatio: .1,
                        mainAxisExtent: 30,
                        mainAxisSpacing: .05,





                      ),

                      scrollDirection: Axis.horizontal,
                      itemCount:
                      selectedSizes.length
                      //50
                      //sizes.length
                      ,

                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) =>  Padding(
                        padding: const EdgeInsets.only(right:  4),
                        child:
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedSizes.remove(selectedSizes[index]);
                            });

                          },
                          child: Stack(
                            children: [
                              Container(
                                //  height: 30,width: 50,
                                alignment: Alignment.center,
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(color: Colors.white,width: .3)

                                ),
                                child: Text(selectedSizes[index],style: TextStyle(color: Colors.white,fontSize: 10),),
                              ),
                              Positioned(
                                right: 0,top: 0,
                                child: InkWell(

                                  onTap: (){

                                    setState(() {
                                      selectedSizes.remove(selectedSizes[index]);
                                    });

                                    debugPrint(selectedSizes.toString());
                                  },
                                  radius: 10,
                                  child: Container(
                                    // width: 15,height: 15,
                                    // color: Colors.red,
                                    child: Icon(Icons.close,color: Colors.white.withOpacity(.5),size: 10,),
                                  ),



                                ),





                              )
                            ],
                          ),

                        ),
                      ),

                    )


                )
              ],
            ),
          )



      ),
    )
    ;
  }

  Widget _category(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 110,
          decoration:BoxDecoration(
             color: Theme.of(context).cardColor,
             // borderRadius: BorderRadius.circular(5),
            //  border: Border.all(color: Colors.white,width: .3)



          ) ,


          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        Checkbox(
                          value: categoryCheckBox,
                          activeColor: categoryCheckColor,
                          fillColor: MaterialStateProperty.all(categoryCheckColor),

                          onChanged:(s){
                            setState(() {categoryCheckBox=s!;});
                            if(categoryCheckBox){
                              categoryDropDownStyle=TextStyle(color: Colors.grey,);


                              setState(() {categoryCheckColor=Colors.orange;selectedCategories.clear();});}
                            else{setState(() {
                              categoryCheckColor=Colors.grey;
                              categoryDropDownStyle=TextStyle(color:Colors.orange,fontWeight: FontWeight.bold);
                            });}


                          },
                        ),
                        Text('الكل',style: TextStyle(color: categoryCheckColor,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: [
                        selectedCategory==null?CircularProgressIndicator():


                        DropdownButton(
                          borderRadius:BorderRadius.circular(10) ,
                          elevation: 20,

                          style: categoryDropDownStyle,
                          dropdownColor: Colors.black,

                          items:


                          allCategories.allTypeCategories[widget.selectedType]![widget.selectedSex]!.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e.toString(),)).toList()..toString(),



                          value:
                          selectedCategory

                          ,
                          onChanged: (String? value){
                            setState(() {
                              categoryCheckBox=false;
                              categoryCheckColor=Colors.grey;
                              categoryDropDownStyle=TextStyle(color:Colors.orange,fontWeight: FontWeight.bold);
                            });

                            if(!selectedCategories.contains(value)&&value!=categoryNone)
                            {setState(() {selectedCategories.add(value);});}







                          },







                        ),
                        Text('النوع',style: TextStyle(color: backColor2,),)
                        //    Text(':  المقاس',style: categoryDropDownStyle),
                      ],
                    ),





                  ],),
                Container(
                  height: 40,
                   // width:200,
                    child: GridView.builder(
                    //  physics: NeverScrollableScrollPhysics(),
                      // reverse: true,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 35,
                        crossAxisSpacing: .05,
                        childAspectRatio: .2,
                        mainAxisExtent: 80,
                        mainAxisSpacing: .05,




                      ),

                      scrollDirection: Axis.horizontal,
                      itemCount:
                      selectedCategories.length
                      //50
                      //sizes.length
                      ,

                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) =>  Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child:
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedCategories.remove(selectedCategories[index]);
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 30,width: 100,
                                alignment: Alignment.center,
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(color: Colors.white,width: .3)

                                ),
                                child: Text(selectedCategories[index],style: TextStyle(color: Colors.white,fontSize: 8),),
                              ),
                              Positioned(
                                right: 0,top: 0,
                                child: InkWell(

                                  onTap: (){

                                    setState(() {
                                      selectedCategories.remove(selectedCategories[index]);
                                    });

                                    debugPrint(selectedCategory.toString());
                                  },
                                  radius: 50,
                                  child: Container(
                                    //width: 15,height: 15,
                                    // color: Colors.red,
                                    child: Icon(Icons.close,color: Colors.white.withOpacity(.5),size: 10,),
                                  ),



                                ),





                              )
                            ],
                          ),

                        ),
                      ),

                    )


                )
              ],
            ),
          )



      ),
    )
    ;
  }
  Widget _recentSearch(){
   return InkWell(

     onTap: ()async{
       var auth=Provider.of<AuthProvider>(context,listen: false);




       if (await Filter().checkFilter(uid: auth.user!.uid)){

         Filter filter= await Filter().getFilter(uid: auth.user!.uid);

         doFilter(
             //selectedGovernorate: filter.governorate!,
            // selectedCity: filter.city!,
             // filterSex: filter.sex!,
             // filterType: filter.type!,
             priceFrom: filter.from!,
             priceTo: filter.to!, selectedCategories: filter.categories!,
             selectedSizes: filter.sizes!);
       }

       else{debugPrint('ابلع'); return;}



     },
     child: Container(




         child: Text('recent search')),



   );
  }



  doFilter({
    //required String selectedGovernorate,
   // required String selectedCity,

    required int priceFrom,
    required int priceTo,
    required List selectedCategories,
    required List selectedSizes,


  }){
    List <Product> x1=[];
    List <Product> x2=[];
    List <Product> x3=[];
    List <Product> x4=[];
    List <Product> x5=[];
    List <Product> x6=[];
    List <Product> x7=[];
    List <Product> x8=[];
    List <Product> x9=[];




    setState(() {x5=allProducts.where((element) => priceFrom<=element.price!&&element.price!<=priceTo).toList();});
    debugPrint('price');
    debugPrint(x5.length.toString());

    if(selectedCategories.length!=0){debugPrint('category');
    for (var y in selectedCategories){
      x6=x5.where((element) => element.category==y).toList();
      for (var h in x6){x7.add(h);}
      x6.clear();}
    }
    else{setState(() {x7=x5;});}
    debugPrint(x5.length.toString());


    if(selectedSizes.length!=0){debugPrint('size');
    for (var y in selectedSizes){
      x8=x7.where((element) => element.sizes!.contains(y)).toList();
      for (var h in x8){ if(!x9.contains(h)){x9.add(h);} }
      x8.clear();}
    }
    else{setState(() {x9=x7;});}
    setState(() {
      filteredProducts=x9;
    });
   // debugPrint(filteredProducts[0].kidsSex.toString());
   // debugPrint(x6.length.toString());

    //

  }
}



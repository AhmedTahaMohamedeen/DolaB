import 'package:adminappp/Screens/User/user_product_view/user_product_view.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/HomeScreen.dart';
class TrendProducts extends StatefulWidget {

  static const  String route='/TrendProducts';
  final String selectedType;
  final String selectedSex;
  const TrendProducts({Key? key, required this.selectedType, required this.selectedSex}) : super(key: key);

  @override
  _TrendProductsState createState() => _TrendProductsState();
}

class _TrendProductsState extends State<TrendProducts> {

  GlobalKey<FormState>myKey=GlobalKey<FormState>();









  //String filterSex=AllCategories().sexCategory[0];

 // String filterType=AllCategories().typeCategory[0];


/*
  String selectedTrendGovernorate=AllCategories().allWord;
  String selectedTrendCity=AllCategories().allWord;*/

  String? selectedTrendSex;
  String? selectedTrendType;
  String selectedTrendCategory=allWord;
  int trendIndexOfCity=0;
  var allCategories=AllCategories();




List<Product>allProducts=[];
List<Product>?trendProducts;
List<String>? customCategoriesList;


Future<bool>getAllProducts()async{

  try{
    List <Product> x1=[];
    List <Product> x2=[];
    List <Product> x3=[];
    List <Product> x4=[];

    List<Product> allProducts1=await Product().getAllProducts();

    if(widget.selectedSex==boys||widget.selectedSex==girls){
      debugPrint('sex');
      setState(() {x1=allProducts1.where((element) => element.kidsSex==widget.selectedSex).toList();});}

    else{
      debugPrint('');
      setState(() {x1=allProducts1.where((element) => element.sex==widget.selectedSex).toList();});}


    setState(() {x2=x1.where((element) => element.type==widget.selectedType).toList();});


    setState(() {allProducts=x2;});
    debugPrint(allProducts.toString());
    return true;



  }on Exception {return false;}




}


myBeginning()async{

  if(await getAllProducts()){

    doTrendFilter(selectedTrendCategory:selectedTrendCategory ,);

  }

  setState(() {
    customCategoriesList=allCategories.allTypeCategoriesAll[widget.selectedType]![widget.selectedSex]!;

  });




}

  TextStyle myTextStyle=TextStyle(fontSize: 10);
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBeginning();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backColor1,





      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(.3),

              child: CustomScrollView(




                slivers: [

                  SliverAppBar(
                    backgroundColor: backColor1,



                  ),



                  SliverList(
                      delegate: SliverChildListDelegate.fixed(
                    [
                      customCategoriesList==null?Container():_customCategory()
                    ],
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                        addSemanticIndexes: true,

                  )
                  ),

                 trendProducts==null?
                 SliverList(
                     delegate: SliverChildListDelegate.fixed(
                       [

                       ],


                     )
                 )


                     : SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,


                    children:trendProducts!.map((e) =>

                      InkWell(
                        onTap: (){   Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product: e, admin: Admin()),));},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           // height: 100,
                           // width: 100,
                            decoration: BoxDecoration(
                           //   color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    e.imageUrl!,
                                  ),fit: BoxFit.fill)
                            ),
                          ),
                        ),
                      )

                    ).toList() ,

                  )

                ],

              ),
            ),



            MyFloating( key:_globalKey ,myLoc1: myLoc. trend)
          ],
        ),
      ),


    );


  }

GlobalKey _globalKey=GlobalKey();




  int selectedCustomCategory=0;
  Widget _customCategory(){
  return Container(height: 40,
    color: Colors.black,
    child: ListView.builder(
      itemCount:customCategoriesList!.length,
      scrollDirection: Axis.horizontal,
      itemExtent: 100,
      itemBuilder: (context, index) =>
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0),
            child: InkWell(
              onTap: (){
                setState(() {
                  selectedCustomCategory=index;
                });


                setState(() {
                  selectedTrendCategory=AllCategories().allTypeCategoriesAll[widget.selectedType]![widget.selectedSex]![index];
                });
                doTrendFilter(
                   // selectedTrendGovernorate: selectedTrendGovernorate,
                   // selectedTrendCity: selectedTrendCity,
                     selectedTrendCategory: selectedTrendCategory);
              },

              child: Container(
                height: 50,width: 50,
                decoration: BoxDecoration(
                    color: color_2,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(customCategoriesList![index],style: TextStyle(fontSize: 12,color:selectedCustomCategory==index?Colors.orange: Colors.white),),
                ),

              )
              ,),
          )


      ,),




  );
  }



  doTrendFilter({
   // required String selectedTrendGovernorate,
   // required String selectedTrendCity,


    required String selectedTrendCategory,



  })async{
    List <Product> x1=[];
    List <Product> x2=[];
    List <Product> x3=[];
    List <Product> x4=[];

   // debugPrint(selectedTrendSex);
   // debugPrint(selectedTrendType);






      if(selectedTrendCategory==allWord){
        setState(() {
          trendProducts=allProducts;
        });
      }
      else{
        setState(() {trendProducts=allProducts.where((element) => element.category==selectedTrendCategory).toList();});

      }





    trendProducts!.sort((a,b)=>b.likes! .compareTo(a.likes as num));



    //

  }












}

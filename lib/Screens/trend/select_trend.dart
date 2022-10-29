import 'package:adminappp/Screens/trend/Trend_Products.dart';
import 'package:adminappp/Screens/trend/Trend_Stores.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:flutter/material.dart';
class SelectTrend extends StatefulWidget {
  static const  String route='/SelectTrend';
  const SelectTrend({Key? key}) : super(key: key);

  @override
  _SelectTrendState createState() => _SelectTrendState();
}

class _SelectTrendState extends State<SelectTrend> {
  static AllCategories _allCategories=AllCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,

          title: Text('trends'),
        ),
        body:
        Column(
          children: [
            Text('المنتجات الرائجه',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,
            )),
            SizedBox(height: 10,),
            Expanded(child: Container(
              decoration: BoxDecoration(
                //  color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
                //  image: DecorationImage(image: AssetImage('assets/images/search_images/products.jpg'), fit: BoxFit.cover)
              ),
              child: Column(children: [
                Expanded(
                    child:
                    Row(
                      children: [

                        Expanded(
                          child:
                          Column(
                            children: [
                              Expanded(
                                child: TrendImages(
                                image: 'assets/images/search_images/girlsClothes.jpg',
                                TEXT: girls,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => TrendProducts(selectedType:clothes , selectedSex:girls ),));

                                },

                        ),
                              ),
                              Expanded(
                                child: TrendImages(
                                image: 'assets/images/search_images/boysClothes.jpg',
                                TEXT: boys,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => TrendProducts(selectedType:clothes , selectedSex:boys ),));

                                },

                        ),
                              ),
                            ],
                          ),flex: 2,),



                        Expanded(child:
                        TrendImages(
                          image: 'assets/images/search_images/womenClothes.jpg',
                          TEXT: women,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendProducts(selectedType:clothes , selectedSex:women ),));

                          },


                        ),
                          flex: 2,),



                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/menClothes.jpg',
                          TEXT: men,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendProducts(selectedType:clothes , selectedSex:men ),));

                          },


                        ),flex: 2,),



                        Expanded(child: Center(child: Text('ملابس',style: TextStyle(color: Colors.white),)),flex: 1,),
                      ],
                    )


                ),
                Expanded(
                    child:
                    Row(
                      children: [
                        Expanded(child: Column(
                          children: [
                            Expanded(
                              child: TrendImages(
                                image: 'assets/images/search_images/girlsShoes.jpg',
                                TEXT: girls,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => TrendProducts(selectedType:shoes , selectedSex:girls ),));

                                },

                              ),
                            ),
                            Expanded(
                              child: TrendImages(
                                image: 'assets/images/search_images/boysShoes.jpg',
                                TEXT: boys,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => TrendProducts(selectedType:shoes, selectedSex:boys),));

                                },

                              ),
                            ),
                          ],
                        ),flex: 2,),
                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/womenShoes.jpg',
                          TEXT: women,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendProducts(selectedType:shoes , selectedSex:women),));

                          },


                        ),flex: 2,),
                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/menShoes.jpg',
                          TEXT: men,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendProducts(selectedType:shoes , selectedSex:men ),));

                          },

                        ),flex: 2,),
                        Expanded(child: Center(child: Text('أحذيه',style: TextStyle(color: Colors.white),)),flex: 1,),
                      ],
                    )


                ),
              ],),
            )),


            SizedBox(height: 25,),
            //   Divider(height: 5,color: Colors.white.withOpacity(.5),thickness: 1,),
            SizedBox(height: 25,),
            Text('المتاجر الرائجه',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
            ),
            SizedBox(height: 10,),
            Expanded(child: Container(
              decoration: BoxDecoration(
                //color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
                //  image: DecorationImage(image: AssetImage('assets/images/search_images/products.jpg'), fit: BoxFit.cover)
              ),


              child: Column(children: [
                Expanded(flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                          flex:6,
                          child:
                          InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => TrendStores(selectedSex: allWord,selectedType: allWord,)));


                            },
                            child: Container(
                              child: Center(child: Text(' كل المتاجر' ,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.1),
                                borderRadius: BorderRadius.circular(20),

                              ),
                            ),
                          )

                        //SearchImages(image: 'assets/images/search_images/shops.jpg',TEXT: 'الكل'),

                      ),
                      //  Expanded(child: Center(child: Text('الكل',style: TextStyle(color: Colors.white),)),flex: 1,),
                    ],
                  ),
                ),
                Expanded(flex: 2,
                    child:
                    Row(
                      children: [
                        Expanded(
                          child:
                          TrendImages(
                          image: 'assets/images/search_images/kidsClothesStore.jpg',
                          TEXT: kids,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendStores(selectedType:clothes , selectedSex:kids ),));

                          },

                        ),flex: 2,),

                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/womenClothesStore.jpg',
                          TEXT: women,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendStores(selectedType:clothes , selectedSex:women ),));

                          },


                        ),flex: 2,),
                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/menClothesStore.jpg',
                          TEXT: men,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendStores(selectedType:clothes, selectedSex:men ),));

                          },


                        ),flex: 2,),
                        Expanded(child: Center(child: Text('ملابس',style: TextStyle(color: Colors.white),)),flex: 1,),
                      ],
                    )


                ),
                Expanded(flex: 2,
                    child:
                    Row(
                      children: [
                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/kidsShoesStore.jpg',
                          TEXT: kids,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendStores(selectedType:shoes, selectedSex:kids ),));

                          },



                        ),flex: 2,),
                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/womenShoesStore.jpg',
                          TEXT: women,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendStores(selectedType:shoes , selectedSex:women ),));

                          },


                        ),flex: 2,),
                        Expanded(child: TrendImages(
                          image: 'assets/images/search_images/menShoesStore.jpg',
                          TEXT: men,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => TrendStores(selectedType:shoes , selectedSex:men),));

                          },


                        ),flex: 2,),
                        Expanded(child: Center(child: Text('أحذيه',style: TextStyle(color: Colors.white),)),flex: 1,),
                      ],
                    )


                ),

              ],),
            ))
          ],
        )


    );
  }
}
class TrendImages extends StatelessWidget {
  final String image;
  final String TEXT;
  final VoidCallback onPressed;
  const TrendImages({Key? key, required this.image, required this.TEXT, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width ,

        decoration: BoxDecoration(
          // color: Colors.white,
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
                opacity: .8
            ),

            borderRadius: BorderRadius.circular(20)
        ),


        margin: EdgeInsets.all(3),
        child: Text(TEXT,
          style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,
              shadows: [BoxShadow(color: Colors.black,blurRadius: 1,spreadRadius: 1)]),),
        alignment: Alignment.center,


      ),
    );
  }
}
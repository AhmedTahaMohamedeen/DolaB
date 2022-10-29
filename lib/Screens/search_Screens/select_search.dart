import 'package:adminappp/constants/Categories.dart';

import 'package:flutter/material.dart';

import 'peoduct_search/search_product.dart';
import 'store_search/search_store.dart';
import 'store_search/search_stores_all.dart';


class SelectSearch extends StatefulWidget {

  static const  String route='/SelectSearch';
  const SelectSearch({Key? key}) : super(key: key);

  @override
  _SelectSearchState createState() => _SelectSearchState();
}

class _SelectSearchState extends State<SelectSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

          appBar: AppBar(


            title: Text('البحث'),
            bottom:TabBar(
              tabs: [
                Tab(text: 'المنتجات',),
                Tab(text: 'المتاجر'),
              ],
            ) ,
          ),
          body:
              TabBarView(

                children: [
                  Column(
                    children: [
                      Text('الملابس',style: TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 25,
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
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SearchImages(
                                            image: 'assets/images/search_images/girlsClothes.jpg',
                                            TEXT: girls,
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)
                                              => SearchProduct(selectedType:clothes , selectedSex:girls, ),));

                                            },

                                          ),
                                        ),
                                        Expanded(
                                          child: SearchImages(
                                            image: 'assets/images/search_images/boysClothes.jpg',
                                            TEXT: boys,
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)
                                              => SearchProduct(selectedType:clothes , selectedSex:boys, ),));

                                            },

                                          ),
                                        ),
                                      ],
                                    ),flex: 2,),



                                  Expanded(child:
                                  SearchImages(
                                    image: 'assets/images/search_images/womenClothes.jpg',
                                    TEXT: women,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => SearchProduct(selectedType:clothes , selectedSex:women, ),));

                                    },


                                  ),
                                    flex: 2,),



                                  Expanded(child:

                                  SearchImages(
                                    image: 'assets/images/search_images/menClothes.jpg',
                                    TEXT: men,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => SearchProduct(selectedType:clothes, selectedSex:men, ),));

                                    },


                                  ),flex: 2,),




                                ],
                              )


                          ),

                        ],),
                      )),
                      Text('الأحذيه',style: TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 25,
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
                                  Expanded(child:Column(
                                    children: [
                                      Expanded(
                                        child: SearchImages(
                                          image: 'assets/images/search_images/girlsShoes.jpg',
                                          TEXT: girls,
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)
                                            => SearchProduct(selectedType:shoes , selectedSex:girls, ),));

                                          },

                                        ),
                                      ),
                                      Expanded(
                                        child: SearchImages(
                                          image: 'assets/images/search_images/boysShoes.jpg',
                                          TEXT: boys,
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)
                                            => SearchProduct(selectedType:shoes , selectedSex:boys,),));

                                          },

                                        ),
                                      ),
                                    ],
                                  ),flex: 2,),
                                  Expanded(child: SearchImages(
                                    image: 'assets/images/search_images/womenShoes.jpg',
                                    TEXT: women,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => SearchProduct(selectedType:shoes , selectedSex:women, ),));

                                    },


                                  ),flex: 2,),
                                  Expanded(child: SearchImages(
                                    image: 'assets/images/search_images/menShoes.jpg',
                                    TEXT: men,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => SearchProduct(selectedType:shoes , selectedSex:men, ),));

                                    },

                                  ),flex: 2,),

                                ],
                              )


                          ),
                        ],),
                      )),


                      SizedBox(height: 25,),

                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 15,),

                      UnconstrainedBox(
                        child: InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => Search_Stores_all()));


                          },
                          child: Material(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            elevation: 3,
                            shadowColor:  Theme.of(context).primaryColorDark,

                            child: Container(
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4),
                                child: Text('بحث فى كل المتاجر' ,style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 16,fontWeight: FontWeight.w400),),
                              )),
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(20),

                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Text('الملابس',style: TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 25),
                      ),
                      SizedBox(height: 10,),

                      Expanded(flex: 2,
                          child:
                          Row(
                            children: [
                              Expanded(child: SearchImages(
                                image: 'assets/images/search_images/kidsClothesStore.jpg',
                                TEXT: kids,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => SearchStore(selectedType:clothes , selectedSex:kids ),));

                                },

                              ),flex: 2,),

                              Expanded(child: SearchImages(
                                image: 'assets/images/search_images/womenClothesStore.jpg',
                                TEXT: women,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => SearchStore(selectedType:clothes , selectedSex:women ),));

                                },


                              ),flex: 2,),
                              Expanded(child: SearchImages(
                                image: 'assets/images/search_images/menClothesStore.jpg',
                                TEXT: men,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => SearchStore(selectedType:clothes , selectedSex:men ),));

                                },


                              ),flex: 2,),

                            ],
                          )


                      ),
                      SizedBox(height: 25,),
                      Text('الأحذيه',style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 25),
                      ),
                      Expanded(flex: 2,
                          child:
                          Row(
                            children: [
                              Expanded(child: SearchImages(
                                image: 'assets/images/search_images/kidsShoesStore.jpg',
                                TEXT: kids,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => SearchStore(selectedType:shoes , selectedSex:kids ),));

                                },



                              ),flex: 2,),
                              Expanded(child: SearchImages(
                                image: 'assets/images/search_images/womenShoesStore.jpg',
                                TEXT: women,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => SearchStore(selectedType:shoes , selectedSex:women),));

                                },


                              ),flex: 2,),
                              Expanded(child: SearchImages(
                                image: 'assets/images/search_images/menShoesStore.jpg',
                                TEXT: men,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => SearchStore(selectedType:shoes , selectedSex:men ),));

                                },


                              ),flex: 2,),

                            ],
                          )


                      ),

                    ],
                  )


                ],

             ),



      ),
    );
  }
}
class SearchImages extends StatelessWidget {
  final String image;
  final String TEXT;
  final VoidCallback onPressed;
  const SearchImages({Key? key, required this.image, required this.TEXT, required this.onPressed}) : super(key: key);

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
                fit: BoxFit.cover,
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
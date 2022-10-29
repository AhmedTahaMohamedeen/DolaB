import 'package:adminappp/Screens/search_Screens/store_search/search_store.dart';
import 'package:adminappp/Screens/search_Screens/store_search/search_store_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:flutter/material.dart';
class Search_Stores_all extends StatefulWidget {
  static const  String route='/Search_Stores_all';
  const Search_Stores_all({Key? key}) : super(key: key);

  @override
  _Search_Stores_allState createState() => _Search_Stores_allState();
}

class _Search_Stores_allState extends State<Search_Stores_all> {

  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  List<Admin>admins=[Admin(name: '',photoUrl: 'https://images.freeimages.com/images/large-previews/e5f/pink-lotus-1396744.jpg',followers: 1),];
  TextEditingController myController=TextEditingController();
  String mySearchText='';

  List<Admin> searchedAdmins=[];

  myListener(){
    setState(() {
      mySearchText=myController.text;

    });
  }
  getAllAdmins()async{
      List<Admin> admins1=await Admin().getAllAdmins();
      debugPrint('get all');
      setState(() {admins=admins1;});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAdmins();
    myController.addListener(() {myListener();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(








      body:  SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: CustomScrollView(
                slivers:[

                  SliverAppBar(

                    toolbarHeight: 90,
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              child: Form(
                                key: myKey,
                                child: mySearchStoresTextField(
                                  //  key: _globalKey,
                                  sFuntion: (s){
                                    return null;
                                  },
                                  vFuntion: (v){
                                    return null;
                                  },
                                  input: TextInputType.text,
                                  myController: myController,
                                  onChange: (s){search();},),
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Ebotton(
                                onpressed: (){search();},
                                backgroundcolor: Theme.of(context).primaryColor,
                                borderRadius: 10,
                                child: Text('بحث',style: TextStyle(color: Theme.of(context).cardColor),),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ) ,


                  ),


                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                        searchedAdmins.map((e) =>  SearchStoreItem(admin: e,)).toList()




                    ),
                  )
                ] ,
              ),
            ),
            MyFloating(myLoc1: myLoc.search)
          ],
        ),
      ),
    );
  }

  search(){

    searchedAdmins.clear();
    for(var x in admins){
      if(x.name!.contains(mySearchText))
      {

        setState(() {
          searchedAdmins.add(x);
        });

      }
    }
    debugPrint('searchedAdmins${searchedAdmins.length}');
    debugPrint(mySearchText);

  }
  List <Admin> filteredAdminsList=[];






}

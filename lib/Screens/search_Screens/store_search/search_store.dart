import 'package:adminappp/Screens/Admin/admin_store_profile/StoreProfile.dart';
import 'package:adminappp/Screens/search_Screens/store_search/search_store_helper.dart';
import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchStore extends StatefulWidget {
  static const  String route='/SearchStore';
  final String selectedType;
  final String selectedSex;
  const SearchStore({Key? key, required this.selectedType, required this.selectedSex}) : super(key: key);

  @override
  _SearchStoreState createState() => _SearchStoreState();
}

class _SearchStoreState extends State<SearchStore> {
  //GlobalKey _globalKey=GlobalKey();
  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  List<Admin>admins=[Admin(name: '',photoUrl: 'https://images.freeimages.com/images/large-previews/e5f/pink-lotus-1396744.jpg',followers: 1),];
  TextEditingController myController=TextEditingController();
  String mySearchText='';


  List<Admin> searchedAdmins=[];
  List<Admin> beginningSearchList=[];

  myListener(){
    setState(() {
      mySearchText=myController.text;

    });
  }

  Future<bool>getAllAdmins()async{
    try{

      List<Admin> admins1=await Admin().getAllAdmins();
      debugPrint('get all');

      setState(() {admins=admins1;});


      return true;}on Exception {return false;}


  }




  myBeginning()async{
    if( await getAllAdmins()){
      _beginningSearch();

    }


  }


  void initState() {
    super.initState();
    myBeginning();
    // getAllAdmins();
    myController.addListener(() {myListener();});

    // search();

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
                                child: Text('بحث',style: TextStyle(color:Theme.of(context).cardColor),),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ) ,


                  ),


                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                        mySearchText.isNotEmpty?searchedAdmins.map((e) =>  SearchStoreItem(admin: e,)).toList()



                            : beginningSearchList.map((e) => SearchStoreItem(admin: e,)).toList()
                    ),
                  )
                ] ,
              ),
            ),
            MyFloating(myLoc1: myLoc.search,key: globalKey,)
          ],
        ),
      ),
    );
  }



GlobalKey globalKey=GlobalKey();






  search(){
    searchedAdmins.clear();
    for(var x in beginningSearchList){
      if(x.name!.contains(mySearchText))
      {

        setState(() {
          searchedAdmins.add(x);
        });

      }
    }
    debugPrint('search');

  }



  _beginningSearch(){
  //  List <Admin> x1=[];
   // List <Admin> x2=[];
    List <Admin> x3=[];
    List <Admin> x4=[];

    setState(() {x3=admins.where((element) => element.storeSex==widget.selectedSex).toList();});
    debugPrint('sex${x3.length}');

    setState(() {
      x4=x3.where((element) => element.storeType==widget.selectedType).toList();
      beginningSearchList=x4;});
    debugPrint('beginningSearchList${beginningSearchList.length}');

    debugPrint(mySearchText.length.toString());

  }

}






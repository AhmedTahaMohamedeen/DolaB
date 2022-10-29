import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';

import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Admin/admin_store_profile/StoreProfile.dart';

class TrendStores extends StatefulWidget {

  static const  String route='/TrendStores';
  final String selectedType;
  final String selectedSex;
  const TrendStores({Key? key, required this.selectedType, required this.selectedSex}) : super(key: key);

  @override
  _TrendStoresState createState() => _TrendStoresState();
}

class _TrendStoresState extends State<TrendStores> {
  List<Admin>admins=[Admin(name: '',photoUrl: 'https://images.freeimages.com/images/large-previews/e5f/pink-lotus-1396744.jpg',followers: 1),];
  TextEditingController myController=TextEditingController();
  String mySearchText='.';

  String selectedGovernorate=allWord;
  String selectedCity=allWord;

  int indexOfCity=0;


  String selectedSex=allWord;
  String selectedType=allWord;





Future<bool>getAllAdmins()async{
    try{

      List<Admin> admins1=await Admin().getAllAdmins();
      debugPrint('get all');
      setState(() {
        admins=admins1;
        selectedSex=widget.selectedSex;
        selectedType=widget.selectedType;


      });


      return true;}on Exception {return false;}


}


  getAdmins()async{


debugPrint('getAdmins');

    List<Admin> admins2=[];
    List<Admin> admins3=[];
    List<Admin> admins4=[];
   // MyIndicator().loading(context);
 /*   if(selectedGovernorate==allWord){setState(() {admins2=admins;});}
    else{setState(() {admins2=admins.where((element) => element.governorate==selectedGovernorate).toList();});}

    if(selectedCity==allWord){setState(() {admins3=admins2;});}
    else{setState(() {admins3=admins2.where((element) => element.city==selectedCity).toList();});}*/

    if(selectedSex==allWord){setState(() {admins4=admins;});}
    else{setState(() {admins4=admins.where((element) => element.storeSex==selectedSex).toList();});}


    if(selectedType==allWord){setState(() {filteredAdmins=admins4;});}
    else{setState(() {filteredAdmins=admins4.where((element) => element.storeType==selectedType).toList();});}







    filteredAdmins.sort((a,b)=>b.followers! .compareTo(a.followers as num));
    //Navigator.pop(context);

  }

  //List<Admin> searchedAdmins=[];
  List<Admin> filteredAdmins=[];


 TextStyle myTextStyle=TextStyle(fontSize: 10);

  myBeginning()async{
  if( await getAllAdmins()){
    getAdmins();


}


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBeginning();



  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: backColor1,
        appBar: AppBar(
          backgroundColor: backColor1,

          title: Text('المتاجر الأكثر متابعه'),



        ),
        body: Stack(
          children: [

            Container(height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color:Colors.black ,

            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                 // separatorBuilder: (context, index) => Divider(color: Colors.black,thickness: 1,height: 1,),
                  itemCount: filteredAdmins.length,


                  itemBuilder: (context, index)
                  {


                   // checkIsFollow( index);

                    return  StoreItem(admin: filteredAdmins[index],index: index,);
                  }




                  ,),
              ),
            ),
            MyFloating(myLoc1: myLoc.trend)
          ],
        ),




      ),
    );
  }


/*  Widget _sex(){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(

        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(.1),
            border: Border.all(color: Colors.white,width: .3)
        ),
        child: Container(
          height: 30,

          child: DropdownButton(
            items: AllCategories().sexCategoryAll.map((e) => DropdownMenuItem(child: Text(e,style: myTextStyle,), value: e.toString(),)).toList(),
            onChanged: (String? v)async{

              setState(() {selectedSex=v!;});

              await getAdmins(context);

              // Navigator.pop(context);


            },
            value:selectedSex ,
            style:TextStyle(color: color_y,fontWeight: FontWeight.bold,fontSize:18 ),
            dropdownColor: color_bl,




          ),
        ),
      ),
    ) ;

  }
  Widget _type(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,

        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(.1),
            border: Border.all(color: Colors.white,width: .3)
        ),
        child: Container(

          child: DropdownButton(
            items: AllCategories().typeCategoryAll.map((e) => DropdownMenuItem(child: Text(e,style: myTextStyle), value: e.toString(),)).toList(),
            onChanged: (String? v)async{

              setState(() {selectedType=v!;});

              await getAdmins(context);

              // Navigator.pop(context);


            },
            value:selectedType ,
            style:TextStyle(color: color_y,fontWeight: FontWeight.bold,fontSize:18 ),
            dropdownColor: color_bl,




          ),
        ),
      ),
    ) ;
  }*/






}




class StoreItem extends StatefulWidget {

  final Admin admin;
  final int index;

  const StoreItem({Key? key,required this.admin, required this.index}) : super(key: key);

  @override
  _StoreItemState createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {
  bool isFollow = false;

  checkIsFollow() async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    if (widget.admin.adminId != null) {
      var follow = await Follow().checkFollow(
          userId: myId!, adminId: widget.admin.adminId!);
      setState(() {
        isFollow = follow;
      });
    }
    else {
      return;
    }
  }

  Widget followButton(){
    if(isFollow){return InkWell(
      onTap: ()async{
        var auth= Provider.of<AuthProvider>(context,listen: false);
        setState(() {isFollow=false;});
        if( await Follow().removeFollow(userId:auth.user!.uid , admin: widget.admin)){

          debugPrint('follow Removed');




        }
        else{return;}

      },
      splashColor: color_y,





      child: Container(alignment: Alignment.center,

          height: 30,width: 60,
          decoration: BoxDecoration(
              color: backColor2.withOpacity(1),
              borderRadius: BorderRadius.circular(5)

          ),

          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('assets/images/follow.png'),
                height: 18,
                width: 18,
              ),
              Text('تمت المتابعه',style: TextStyle(color: Colors.white,fontSize: 8),),

            ],
          )),

    );}
    else{
      return InkWell(
        onTap: ()async{
          var auth= Provider.of<AuthProvider>(context,listen: false);
          setState(() {isFollow=true;});
          if( await Follow().addNewFollow(userId:auth.user!.uid , admin: widget.admin,)){
            debugPrint('follow ');

          } else{return;}
        },
        splashColor: color_y,





        child: Container(alignment: Alignment.center,

            height: 30,width: 60,
            decoration: BoxDecoration(
                color:
                //Colors.deepOrange.withOpacity(1)
                backColor1

                ,
                borderRadius: BorderRadius.circular(5)

            ),

            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage('assets/images/addfollow.png'),
                  height: 12,
                  width: 12,

                ),
                Text('متابعه',style: TextStyle(color: Colors.white),

                ),
              ],
            )),

      );}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFollow();
  }

  @override
  Widget build(BuildContext context) {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    Color _shadowColor=Colors.black;
    double _shadowRadius=.1;
    if(widget.index==0){_shadowColor=Colors.orange;_shadowRadius=30;}
    if(widget.index==1){_shadowColor=Colors.yellow.withOpacity(1);_shadowRadius=20;}
    if(widget.index==2){_shadowColor=Colors.yellow.withOpacity(1);_shadowRadius=10;}
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        height: widget.index==0?70:50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.black.withOpacity(.5),
            boxShadow: [
              BoxShadow(
                  color: _shadowColor,
                  blurRadius: _shadowRadius
              )
            ]
        ),
        alignment: Alignment.centerLeft,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(

                children: [
                  InkWell(
                    onTap: () {
                      if (widget.admin.adminId == myId!) {
                        Navigator.pushNamed(context, StoreProfileScreen.route);
                      }
                      else {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              StrangerStore(admin: widget.admin,),));
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(widget.admin.photoUrl!, ),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.admin.name!, style: TextStyle(
                              fontSize: 18, color: Colors.white),),
                        ),
                      ],
                    ),
                  ),


                  widget.admin.adminId == myId! ? Container()
                      : Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: followButton(),
                  )
                ],
              ),


              // SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.person,color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(widget.admin.followers.toString(),
                      style: TextStyle(fontSize: 10, color: Colors.white),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
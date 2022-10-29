import 'package:adminappp/Screens/strangers/stranger_userProfile.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class PeopleLikes extends StatefulWidget {
  static const String route='/PeopleLikes';
  final Product product;
  const PeopleLikes({Key? key,required this.product}) : super(key: key);

  @override
  _PeopleLikesState createState() => _PeopleLikesState();
}

class _PeopleLikesState extends State<PeopleLikes> {
  List<UserInfoo> usersList=[
   ];

  getUsersInfo()async{
   List<UserInfoo> l1= await UserInfoo().getPeopleLikesInfo(productId:widget.product.productId!,adminId: widget.product.userId! );
       setState(() {
         usersList=l1;
       });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor1,
      appBar: AppBar(
        backgroundColor: backColor1,
        title: Text('الاشخاص المعجبون '),

      ),
      body:ListView.separated(
        separatorBuilder: (context, index) => Divider(height: 1,color: Colors.black,thickness: 1,),
        itemCount: usersList.length,

        itemBuilder: (context, index) => InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => StrangerUser(userInfoo:usersList[index] ,),));
        },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:usersList[index].name==null?Text(''): Text(usersList[index].name!,style: TextStyle(color: Colors.white),),
                  ),
                  usersList[index].photo==null?Text(''):Container(
                    width: 50,height: 50,
                    decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(usersList[index].photo!) ),
                      shape: BoxShape.circle

                    ),
                  )
                ],
              ),

        ),
          )
      ),),




    );
  }
}

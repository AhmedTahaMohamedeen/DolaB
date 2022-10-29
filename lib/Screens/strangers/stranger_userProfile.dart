
// ignore_for_file: file_names, avoid_debugPrint

import 'package:adminappp/Screens/Admin/admin_store_profile/StoreProfile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/constants/love.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stranger_store_profile/stranger_store_profile.dart';



class StrangerUser extends StatefulWidget {
  final UserInfoo userInfoo;

  static const  String route='/StrangerUser';

  const StrangerUser({Key? key,required this.userInfoo}) : super(key: key);

  @override
  _StrangerUserState createState() => _StrangerUserState();
}

class _StrangerUserState extends State<StrangerUser> {



  List<Product>loveProducts=[Product(imageUrl: 'https://i.pinimg.com/564x/fd/fe/ac/fdfeac4eeadf1e74eadf737d7209a994.jpg')];

  getLoves()async{
    var loveProducts1=await Love().getLoveProducts(userId: widget.userInfoo.uid!);
    setState(() {
      loveProducts=loveProducts1;
    });

  }

  UserInfoo? userInfo=UserInfoo(name: 'ss',phone: 'sss',photo:'https://i.pinimg.com/564x/fd/fe/ac/fdfeac4eeadf1e74eadf737d7209a994.jpg',email: 'sss', );
  List<Admin> admins=[];
  @override
  void initState() {
    super.initState();
    getUserInfo();
    getFollowing();
    getLoves();
  }
  getUserInfo()async{

    setState(() {
      userInfo=widget.userInfoo;
    });

  }
  getFollowing()async{
    var auth=Provider.of<AuthProvider>(context,listen: false);
    List<Admin> admins1=await Follow().getFollowing(userId: auth.user!.uid);
    debugPrint('getFollowing done  func');
    setState(() {
      admins=admins1;
    });

  }


  @override
  Widget build(BuildContext context) {
    var auth=Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      backgroundColor:
      // color_r
      Colors.black.withOpacity(.3),

      primary: true,
      appBar: AppBar(
        backgroundColor: color_bl,

      ),
      body: Stack(
        children:
        [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
            //  image: DecorationImage(image: AssetImage('assets/images/12.jpg'), fit: BoxFit.cover),

            ),

          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(.7),

          ),

          ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [

                  Padding(
                    padding: const  EdgeInsets.only(left: 10),
                    child: Container(
                      height: 100,width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: color_y,width: 2),
                          shape: BoxShape.circle,
                          image:  DecorationImage(image: CachedNetworkImageProvider(userInfo!.photo!),fit: BoxFit.fill)
                      ),
                    ),
                  ),//photo

                  const SizedBox(height: 10,),
                  Text('${userInfo!.name}',
                    style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),//name
                  const SizedBox(height: 1,),
                  Text('${userInfo!.phone}  ',style: const TextStyle(color: Colors.white,fontSize: 10),),
                  const SizedBox(height: 2,),
                  Text(' العمر : ${userInfo!.age }  ',style: const TextStyle(color: Colors.white,fontSize: 10),),
                  const SizedBox(height: 2,),
                  Text('  ${userInfo!.city }  ',style: const TextStyle(color: Colors.white,fontSize: 10),),
                  const SizedBox(height: 2,),

                ],
              ),



              const  SizedBox(height: 30,),
                Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('${userInfo!.name} المفضله:',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3,right: 3),
                child: Container(
                    height: 250,

                    decoration: BoxDecoration(
                        color:  Colors.white.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(.1),width: 3)
                    ),
                    width: MediaQuery.of(context).size.width,



                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1,
                          mainAxisExtent: 100,
                          mainAxisSpacing: 1




                      ),

                      scrollDirection: Axis.vertical,
                      itemCount: loveProducts.length,

                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) =>  Padding(
                        padding: const EdgeInsets.all(5),
                        child:
                        InkWell(
                          onTap: (){




                          },
                          child: Container(
                            width: 150,


                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(loveProducts[index].imageUrl!,)
                                  ,fit: BoxFit.cover,


                                )
                            ),

                          ),
                        ),
                      ),

                    )

                ),
              ),
              const SizedBox(height: 50,),
                Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('${userInfo!.name} يتابع:',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3,right: 3),
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color:  Colors.white.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(.1),width: 3)
                    ),




                    child: ListView.builder(
                      scrollDirection:Axis.horizontal ,
                      itemCount: admins.length,
                      itemExtent: 80,
                      itemBuilder: (context, index) =>  InkWell(
                        onTap: (){
                          if(admins[index].adminId==auth.user!.uid){Navigator.pushNamed(context, StoreProfileScreen.route);}
                          else{Navigator.push(context,MaterialPageRoute(builder: (context) =>StrangerStore(admin:admins[index] ,) ));}



                        },
                        child: Container(
                          width: 150,height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //  image: DecorationImage(image: NetworkImage(myProducts[index].imageUrl!,),fit: BoxFit.cover,)
                          ),

                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundColor: Colors.red,radius: 30,backgroundImage: CachedNetworkImageProvider(admins[index].photoUrl!),),
                              Text(admins[index].name!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                            ],
                          ),

                        ),
                      ),)

                ),
              ),

              const SizedBox(height: 50,),


              const SizedBox(height: 50,),





            ],
          ),
          MyFloating(myLoc1: myLoc.none),



        ],
      ),




    );
  }
  snack({required BuildContext context,required String message}){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


}

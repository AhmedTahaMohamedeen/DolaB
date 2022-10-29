










import 'package:adminappp/Screens/Admin/admin_store_profile/StoreProfile.dart';
import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/AdminInfo.dart';

class mySearchStoresTextField extends StatelessWidget {

  double borderWidth = 1;

  Color fillColor = Colors.white.withOpacity(.3);
  double borderRadus = 10;

  TextStyle inputTextStyle=TextStyle(color: Colors.white, fontSize:16);
  TextStyle labelTextStyle=TextStyle(color: Colors.white, fontSize:16,);




  TextEditingController? myController ;
  //final String label;
  // final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;
  final   Function(String?) onChange;

  //Function ontapFunction;

  mySearchStoresTextField({Key? key,
    //required this.label,
    this.obsecure = false,
    required this.onChange ,
    // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor = Theme.of(context).primaryColor;
    return TextFormField(
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize:16),
      onChanged: onChange,

      decoration: InputDecoration(
          fillColor:fillColor,



          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.only(bottom: 10,top: 10,left: 5,right: 5),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
      textInputAction: TextInputAction.search,
      keyboardType: input,
      enabled: true,


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





class SearchStoreItem extends StatefulWidget {

  final Admin admin;

  const SearchStoreItem({Key? key,required this.admin}) : super(key: key);

  @override
  _SearchStoreItemState createState() => _SearchStoreItemState();
}

class _SearchStoreItemState extends State<SearchStoreItem> {
  bool isFollow=false;
  checkIsFollow()async{
    var myId=Provider.of<FireProvider>(context,listen: false).myId;
    if(widget.admin.adminId!=null){

      var follow=await Follow().checkFollow(userId: myId!, adminId: widget.admin.adminId!);
      setState(() {
        isFollow=follow;
      });

    }
    else{return;}




  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFollow();
  }
  @override
  Widget build(BuildContext context) {

    if(widget.admin.adminId==Provider.of<FireProvider>(context,listen: false).myId){

      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 4,
           shadowColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          child: Container(

            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

            ),

            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, StoreProfileScreen.route);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Theme.of(context).primaryColor),
                                image: DecorationImage(image:  CachedNetworkImageProvider(widget.admin.photoUrl!))
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.admin.name!,
                              style: TextStyle(fontSize: 26,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),



                    // followButton()
                  ],
                ),


                // SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      // Image(image: AssetImage('assets/images/loved.png'),width: 15,height: 15,)
                      Icon(Icons.person,color:Theme.of(context).primaryColor,)

                      ,
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(widget.admin.followers.toString(),style: TextStyle(fontSize: 10,color:Theme.of(context).primaryColor),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }


    else {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 30,
        shadowColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

          ),
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StrangerStore(admin:widget.admin ,),));

                    },
                    child: Row(
                      children: [
                        Container(
                          width: 60,height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Theme.of(context).primaryColor),
                              image: DecorationImage(image:  CachedNetworkImageProvider(widget.admin.photoUrl!))
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.admin.name!,
                            style: TextStyle(fontSize: 26,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w800),),
                        ),
                      ],
                    ),
                  ),



                  followButton()
                ],
              ),


              // SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.person,color: Theme.of(context).primaryColor,) ,
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(widget.admin.followers.toString(),style: TextStyle(fontSize: 10,color:Theme.of(context).primaryColor),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    }
  }


  Widget followButton(){
    if(isFollow){return InkWell(
      onTap: ()async{
        var myId= Provider.of<FireProvider>(context,listen: false).myId;
        setState(() {isFollow=false;});
        if( await Follow().removeFollow(userId:myId! , admin: widget.admin)){
          debugPrint('follow Removed');





        }
        else{return;}

      },






      child: Container(alignment: Alignment.center,

          height: 30,width: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5)

          ),

          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('assets/images/follow.png'),
                height: 18,
                width: 18,
              ),
              Text('تمت المتابعه',style: TextStyle(color: Theme.of(context).cardColor,fontSize: 8),),

            ],
          )),

    );}
    else{
      return InkWell(
        onTap: ()async{
          var myId= Provider.of<FireProvider>(context,listen: false).myId;
          setState(() {isFollow=true;});
          if( await Follow().addNewFollow(userId:myId! , admin: widget.admin,)){





          }
          else{return;}


        },






        child: Container(alignment: Alignment.center,

            height: 30,width: 60,
            decoration: BoxDecoration(
                color:
                Theme.of(context).primaryColor

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
                Text('متابعه',style: TextStyle(color:Theme.of(context).cardColor),

                ),
              ],
            )),

      );}
  }
}

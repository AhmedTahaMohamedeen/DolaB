import 'package:adminappp/Screens/Admin/admin_order/AdminOrders.dart';
import 'package:adminappp/Screens/Chat_screens/Admin/Admin_messages.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store_settings/store_settings.dart';
class StoreProperties extends StatefulWidget {
  static const  String route='/StoreProperties';

  const StoreProperties({Key? key}) : super(key: key);

  @override
  _StorePropertiesState createState() => _StorePropertiesState();
}

class _StorePropertiesState extends State<StoreProperties> {
  Admin? admin;
  getAdminInfo(BuildContext context)async{
    var id=Provider.of<FireProvider>(context,listen: false).myId;
   var admin1= await Admin().getAdminData(id!);
    setState(() {
      admin=admin1;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminInfo(context);
  }
  @override
  Widget build(BuildContext context) {
   if(admin==null){return Scaffold(appBar: AppBar(title: Text('loading'),),);}
   else{ return Scaffold(

     appBar: AppBar(title: Text('${admin!.name}',style: TextStyle(fontWeight: FontWeight.w700),) ),
     body: Center(
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,

           children: [
             _item(name:'الاعددات',onTap: (){Navigator.pushNamed(context, StoreSettings.route);} ),
             _item(name:'الرسائل',onTap: (){Navigator.pushNamed(context, AdminMessages.route);} ),
             _item(name:'الطلبات',onTap: (){Navigator.pushNamed(context, AdminOrders.route);} ),
             _item(name:'الحساب',onTap: (){} ),



           ],
         ),
       ),
     ),
   );}


  }

  Widget _item({ required String name,required VoidCallback onTap}){

    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

        child: MaterialButton(
          hoverElevation: 50,

          onPressed:onTap ,
          color: Theme.of(context).primaryColorDark ,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: 200,


              child: Center(child: Text(name,style: TextStyle(fontWeight: FontWeight.w700,color: Theme.of(context).cardColor)))),


        ),

    );

  }

}

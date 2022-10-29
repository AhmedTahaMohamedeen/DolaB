






import 'package:adminappp/Screens/Admin/store_settings/store_settings.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:flutter/material.dart';


///  (1)--------[ChangeAdminName]
///  (2)--------[ChangeAdminPhone]
///  (3)--------[ChangeAdminDepartment]
///  (4)--------[ChangeAdminTargetAge]
///  (5)--------[StoreSettingsTextField]


class ChangeAdminName extends StatefulWidget {
  final Admin admin;
  final double height;
  const ChangeAdminName({Key? key, required this.admin, required this.height}) : super(key: key);

  @override
  _ChangeAdminNameState createState() => _ChangeAdminNameState();
}
class _ChangeAdminNameState extends State<ChangeAdminName> {
  String name='no';
  bool myNamePressed=false;

  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  Admin admin=Admin();



  @override
  Widget build(BuildContext context) {


    if(!myNamePressed){
      return
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: widget.height*.01,vertical: widget.height*.01),
          child: SizedBox(
            height: widget.height*.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editIcon(onTap: (){setState(() {myNamePressed=!myNamePressed;});}, height: widget.height, context: context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${widget.admin.name!}  ',
                      style:TextStyle(color:  Theme.of(context).primaryColor,fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('الإسم : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                  ],
                ),

              ],
            ),
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).primaryColorLight,
        elevation: 3,

        child: Container(
         // color: Theme.of(context).canvasColor.withOpacity(.1),
          height: widget.height*.25,
          padding:  EdgeInsets.all(widget.height*.01),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: widget.height*.01,horizontal: widget.height*.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${widget.admin.name!}  ',
                        style:TextStyle(color:  Theme.of(context).primaryColor ,fontSize:widget. height*.018 ),overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl

                    ),
                    Text('الإسم :',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                  ],
                ),
              ),
              Form(
                  key: myKey,
                  child: SizedBox(
                    // color: Colors.blue,
                    height:  widget.height*.10,
                    child: StoreSettingsTextField(
                      label: 'ادخل الإسم الجديد',
                      vFuntion: (v){if(v!.isEmpty){return'ادخل الاسم';}return null;},
                      sFuntion: (s){setState(() {name=s!;});return null;},
                      input: TextInputType.text,




                    ),
                  )

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySaveButton(onpressed: ()async{


                    if(!myKey.currentState!.validate()){return;}
                    else{
                      MyIndicator().loading(context);
                      myKey.currentState!.save();


                      await Admin().editStoreInfo(key: adminName,adminId: widget.admin.adminId!,newValue: name);

                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context,  StoreSettings.route);


                    }

                  }),
                  MyCloseButton(onpressed: (){
                    setState(() {
                      myNamePressed=!myNamePressed;
                    });
                  }),
                ],
              )

            ],
          ),
        ),
      )
    ;}
  }
}

class ChangeAdminPhone extends StatefulWidget {
  final Admin admin;
  final double height;
  const ChangeAdminPhone({Key? key, required this.admin, required this.height}) : super(key: key);

  @override
  _ChangeAdminPhoneState createState() => _ChangeAdminPhoneState();
}
class _ChangeAdminPhoneState extends State<ChangeAdminPhone> {

  String phone='no';
  bool myPhonePressed=false;

  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  Admin admin=Admin();


  @override
  Widget build(BuildContext context) {



    if(!myPhonePressed){
      return

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: widget.height*.01,vertical: widget.height*.01),
          child: SizedBox(
            height: widget.height*.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editIcon(onTap: (){setState(() {myPhonePressed=!myPhonePressed;});}, height:widget. height, context: context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${widget.admin.phone!}  ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis, ),
                    Text('رقم الهاتف :',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                  ],
                ),

              ],
            ),
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).primaryColorLight,
        elevation: 3,
        child: Container(

          height: widget.height*.25,
          padding:  EdgeInsets.all(widget.height*.01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text(' ${widget.admin.phone!}  ',style:TextStyle(color:  Theme.of(context).primaryColor.withOpacity(.7),fontSize:widget. height*.018 ),
                    textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis, ),
                  Text('رقم الهاتف :',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                ],
              ),
              Form(
                  key: myKey,
                  child: SizedBox(
                    height:  widget.height*.10,
                    child: StoreSettingsTextField(
                      label: 'ادخل الرقم الجديد',
                      vFuntion: (v){if(v!.isEmpty){return'ادخل الرقم';}return null;},
                      sFuntion: (s){setState(() {phone=s!;});return null;},
                      input: TextInputType.phone,



                    ),
                  )

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySaveButton(onpressed: ()async{


                    if(!myKey.currentState!.validate()){return;}
                    else{
                      MyIndicator().loading(context);
                      myKey.currentState!.save();
                      await Admin().editStoreInfo(key: adminPhone,adminId: widget.admin.adminId!,newValue: phone);
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context,  StoreSettings.route);

                    } }),
                  MyCloseButton(onpressed: (){
                    setState(() {
                      myPhonePressed=!myPhonePressed;
                    });
                  }),
                ],
              )

            ],
          ),
        ),
      )
    ;}
  }
}


class ChangeAdminDepartment extends StatefulWidget {
  final Admin admin;
  final double height;
  const ChangeAdminDepartment({Key? key, required this.admin, required this.height}) : super(key: key);

  @override
  _ChangeAdminDepartmentState createState() => _ChangeAdminDepartmentState();
}
class _ChangeAdminDepartmentState extends State<ChangeAdminDepartment> {

  String department='no';
  bool myDepartmentPressed=false;


  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  Admin admin=Admin();

  @override
  Widget build(BuildContext context) {



    if(!myDepartmentPressed){
      return
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: widget.height*.01,vertical: widget.height*.01),
          child: SizedBox(
            height: widget.height*.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editIcon(onTap: (){setState(() {myDepartmentPressed=!myDepartmentPressed;});}, height: widget.height, context: context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${widget.admin.department!}  ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis, ),
                    Text('المنطقه :',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                  ],
                ),

              ],
            ),
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).primaryColorLight,
        elevation: 3,
        child: Container(


          height: widget.height*.25,
          padding:  EdgeInsets.all(widget.height*.01),


          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: widget.height*.01,vertical: widget.height*.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${widget.admin.department!}  ',style:TextStyle(color:  Theme.of(context).primaryColor,fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis, ),
                    Text('المنطقه :',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                  ],
                ),
              ),
              Form(
                  key: myKey,
                  child: SizedBox(
                    height:  widget.height*.10,
                    child: StoreSettingsTextField(
                      label: 'ادخل المنطقه',
                      vFuntion: (v){if(v!.isEmpty){return'ادخل المنطقه';}return null;},
                      sFuntion: (s){setState(() {department=s!;});return null;},
                      input: TextInputType.text,



                    ),
                  )

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySaveButton(onpressed:  ()async{



                    if(!myKey.currentState!.validate()){return;}
                    else{
                      MyIndicator().loading(context);
                      myKey.currentState!.save();

                      await Admin().editStoreInfo(key: adminDepartment,adminId: widget.admin.adminId!,newValue: department);
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context,  StoreSettings.route);

                    }



                  }),
                  MyCloseButton(onpressed: (){
                    setState(() {
                      myDepartmentPressed=!myDepartmentPressed;
                    });
                  }),
                ],
              )

            ],
          ),
        ),
      )
    ;}
  }
}



class ChangeAdminTargetAge extends StatefulWidget {
  final Admin admin;
  final double height;
  const ChangeAdminTargetAge({Key? key, required this.admin, required this.height}) : super(key: key);

  @override
  _ChangeAdminTargetAgeState createState() => _ChangeAdminTargetAgeState();
}
class _ChangeAdminTargetAgeState extends State<ChangeAdminTargetAge> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  Admin admin=Admin();


  int targetAgeFrom=15;
  int targetAgeTo=55;
  bool myTargetPressed=false;
  func(){
    setState(() {
      targetAgeFrom=widget.admin.targetAgeFrom!;
      targetAgeTo=widget.admin.targetAgeTo!;
    });
    print('func done');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();

  }

  @override
  Widget build(BuildContext context) {


    if(!myTargetPressed){
      return
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: widget.height*.01,vertical: widget.height*.01),
          child: SizedBox(
            height: widget.height*.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editIcon(onTap: (){setState(() {myTargetPressed=!myTargetPressed;});}, height: widget.height, context: context),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(widget.admin.targetAgeTo.toString(),style:TextStyle(color:  Theme.of(context).primaryColor,fontSize:widget. height*.018 ),
                textDirection: TextDirection.rtl,),
              Text(' الى  ',style:TextStyle(color:  Theme.of(context).primaryColorDark,fontSize:widget. height*.018 ),
                  textDirection: TextDirection.rtl),
              Text('        ',style:TextStyle(color:  Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontSize:widget. height*.018 ),
                textDirection: TextDirection.rtl,),
              Text(widget.admin.targetAgeFrom.toString(),style:TextStyle(color:  Theme.of(context).primaryColor,fontSize:widget. height*.018 ),
                textDirection: TextDirection.rtl,),
              Text(' من  ',style:TextStyle(color:  Theme.of(context).primaryColorDark,fontSize:widget. height*.018 ),
                  textDirection: TextDirection.rtl),

              Text('السن المستهدف :     ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
            ],
            ),

              ],
            ),
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).primaryColorLight,
        elevation: 3,
        child: Container(

          height: widget.height*.25,
          padding:  EdgeInsets.all(widget.height*.01),

          child: Column(
            children: [
              Padding(
                padding:   EdgeInsets.all( widget.height*.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.admin.targetAgeTo.toString(),style:TextStyle(color:  Theme.of(context).cardColor,fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,),
                    Text(' الى  ',style:TextStyle(color:  Theme.of(context).primaryColorDark,fontSize:widget. height*.018 ),
                        textDirection: TextDirection.rtl),
                    Text('        ',style:TextStyle(color:  Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,),
                    Text(widget.admin.targetAgeFrom.toString(),style:TextStyle(color:  Theme.of(context).cardColor,fontSize:widget. height*.018 ),
                      textDirection: TextDirection.rtl,),
                    Text(' من  ',style:TextStyle(color:  Theme.of(context).primaryColorDark,fontSize:widget. height*.018 ),
                        textDirection: TextDirection.rtl),

                    Text('السن المستهدف :     ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: widget.height*.018), textDirection: TextDirection.rtl),
                  ],
                ),
              ),
              SizedBox(

                height: widget.height*.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:widget.height*.07,height: widget.height*.05,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [BoxShadow(color: Theme.of(context).canvasColor,blurRadius: 3,spreadRadius: .05)],
                              borderRadius: BorderRadius.circular(5)

                          ),
                          padding: EdgeInsets.symmetric(horizontal: widget.height*.003),
                          child: DropdownButton(
                            items: targetAges.map((e) =>
                                DropdownMenuItem(child: Text(e.toString()), value: e,)).toList(),
                            onChanged: (v){setState(() {targetAgeTo=int.parse(v.toString());});},
                            value:targetAgeTo ,
                            style:TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.bold,fontSize:widget.height*.02 ),
                            dropdownColor: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            iconEnabledColor: Theme.of(context).iconTheme.color,



                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: widget.height*.01),
                          child: Text('الى',style:  TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontWeight: FontWeight.bold,fontSize: widget.height*.018),
                            textDirection: TextDirection.rtl,),
                        )
                      ],
                    ),//to
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:widget.height*.07,height: widget.height*.05,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [BoxShadow(color: Theme.of(context).canvasColor,blurRadius: 3,spreadRadius: .05)],
                              borderRadius: BorderRadius.circular(5)

                          ),
                          padding: EdgeInsets.symmetric(horizontal: widget.height*.003),
                          child: DropdownButton(
                            items: targetAges.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e,)).toList(),
                            onChanged: (v){setState(() {targetAgeFrom=int.parse(v.toString());});},
                            value:targetAgeFrom ,


                            style:TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.bold,fontSize:widget.height*.02 ),
                            dropdownColor: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            iconEnabledColor: Theme.of(context).iconTheme.color,




                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: widget.height*.01),
                          child: Text('من',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontWeight: FontWeight.bold,fontSize: widget.height*.018),
                            textDirection: TextDirection.rtl,),
                        )
                      ],
                    ),//from



                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySaveButton(onpressed: ()async{


                    if(targetAgeTo<=targetAgeFrom){
                      MyFlush().showFlush(context: context, text: 'يجب ان يكون السن المستهدف الحد الاصغر اقل من الحد الاكبر');
                      return;}
                    else{
                      MyIndicator().loading(context);


                      await Admin().editStoreInfo(key: adminTargetAgeFrom,adminId: widget.admin.adminId!,newValue: targetAgeFrom);
                      await Admin().editStoreInfo(key: adminTargetAgeTo,adminId: widget.admin.adminId!,newValue: targetAgeTo);
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context,  StoreSettings.route);


                    }


                  }),
                  MyCloseButton(onpressed: (){
                    setState(() {
                      myTargetPressed=!myTargetPressed;
                    });
                  }),
                ],
              )

            ],
          ),
        ),
      )
    ;}
  }
}



class StoreSettingsTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.white.withOpacity(.3);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
  // final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  StoreSettingsTextField({Key? key,
    required this.label,
    this.obsecure = false,
    // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
        builder: (context,deviceInfo) {
          double? screenHeight=deviceInfo.screenHeight!;
          double? screenWidth=deviceInfo.screenWidth;
          print(screenHeight);
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;

          }
          return TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize:screenHeight!*.02 ),
            decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor,
                counterStyle: TextStyle(color: Theme.of(context).cardColor,fontSize: screenHeight*.015),



                filled: true,
                isCollapsed: true,
                enabled: true,
                contentPadding:  EdgeInsets.all(screenHeight*.025),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: label,
                labelStyle: TextStyle(fontSize: 15),


                //  prefixIcon: icon,
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
                )
            ),

            obscureText: obsecure,
            textInputAction: TextInputAction.done,
            keyboardType: input,
            enabled: true,
            minLines: 1,
            maxLines: 1,
            maxLength: 30,
            // initialValue: 'bota',

            validator:vFuntion ,
            onSaved:sFuntion ,

            controller: myController,
          );
        }
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
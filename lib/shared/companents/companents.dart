import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';





Widget defaultButton({
  required Function function,
  double width = double.infinity,
  Color color = Colors.blue,
  double radius = 0,
  required String text,
}) =>
    Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: color),
        width: width,
        child: MaterialButton(
            onPressed: () => function(),
            child: Text(text,
                style: TextStyle(fontSize: 20, color: Colors.white))));

Widget defaultTextForm({
  required final String? Function(String?) validate,
  required TextEditingController controller,
  required TextInputType type,
  Function? sumbit,
  Function? onChange,

  required String label,
  required IconData prefix,

  IconData? suffix,
  Function? visblepass,
  Function? onTap,
  bool isclickable = true,
  bool isPassword = false,
}) =>
    TextFormField(

      onChanged:(value) {
        if(onChange!=null){onChange(value);}},
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) => sumbit!(s),
      validator: validate,

      obscureText: isPassword,
      onTap: () {if(onTap!=null){
        onTap() ;
      }},
      enabled: isclickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),

        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: (){
          if(visblepass!=null)
            {
              visblepass() ;
            }
        } ) : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildtaskscreen(
  String time,
  String title,
  String Date,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                child: Text(time),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Date,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );

Widget myDivider ()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Future <Widget>navigateTo(context,Widget)async=>await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget
  ),
);

Future <Widget>navigatePushAndDelete(context,Widget)async=>await Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
        builder: (context) => Widget
    ), (route) => false );

void toastShow( {required String msg,required toastStatus state}){

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastMessageColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Color? toastMessageColor(toastStatus state) {
  switch(state)
  {
    case(toastStatus.SUCESS):
      return Colors.green ;
      break ;
    case(toastStatus.ERROR):
      return Colors.red ;
      break ;
    case(toastStatus.WARNING):
      return Colors.amber;
      break;
  }
}
enum toastStatus {SUCESS , ERROR ,WARNING}
bool istrue(bool ? value) {
  if (value != null) {
    return value;
  }
  else
    return false;
}


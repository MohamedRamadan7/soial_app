import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUberCase = true,
  double radius = 15.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () => function(),
        child: Text(
          isUberCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Function? validateFunc() => null;

class defaultFormFiled extends StatelessWidget {
  defaultFormFiled({
    this.lable = 'Username',
    this.ispassword = false,
    this.validation = validateFunc,
    this.onsumit= validateFunc,
    required this.controller,
    this.type = TextInputType.text,
    this.sufixpressd,
    this.suffix,
    this.fixIcon,
    this.radius = 15.0,
  });
  final String lable;
  final bool ispassword;
  final Function validation;
  final Function onsumit;
  final TextEditingController controller;
  final TextInputType type;
  final Function? sufixpressd;
  final IconData? suffix;
  final IconData? fixIcon;
  final double radius;


  @override
  Widget build(BuildContext context) {
    // App Theme
    var theme = Theme.of(context);

    //Check if dark mode enabled
    bool darkModeOn = theme.brightness == Brightness.dark;

    //Main Text Field Color
    Color? color = darkModeOn ? Color(0xff252A34) : Colors.white;

    //Main Text Field border
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
     // borderRadius: BorderRadius.circular(15),
      borderRadius: BorderRadius.circular(radius),
     // borderSide: BorderSide(color: color!),
    );

    return TextFormField(
      validator: (value) => validation(value!),
      onFieldSubmitted: (value) => onsumit(value),
      keyboardType: type,
      obscureText: ispassword,
      controller: controller,
      style: TextStyle(
        color: darkModeOn ? Color(0xffE9EAEF) : Colors.grey[900],
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: lable,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 17,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        filled: true,
        fillColor: color,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        // errorBorder: outlineInputBorder.copyWith(
        //   borderSide: BorderSide(color: Colors.red[700]!),
        // ),
        focusedBorder: outlineInputBorder,
        // focusedErrorBorder: outlineInputBorder.copyWith(
        //   borderSide: BorderSide(color: Colors.red[700]!),
        // ),
        prefixIcon: Icon(fixIcon),
        suffixIcon: sufixpressd != null || suffix != null
            ? IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => sufixpressd!(),
               icon: Icon(suffix, color: theme.accentColor),
        )
            : null,
      ),
    );
  }
}
// class defaultFormFiled extends StatelessWidget {
//   defaultFormFiled({
//     this.ispassword = false,
//     this.validation = validateFunc,
//     required this.controller,
//     required this.type,
//     required this.fixIcon,
//     this.sufixpressd= validateFunc,
//     this.suffix,
//     required this.lable,
//     this.onChanged= validateFunc,
//     this.onsumit= validateFunc,
//     this.ontap= validateFunc,
//     this.radius = 15.0,
//     this.isClicable= true,
//   });
//   final String lable;//
//   final IconData fixIcon;//
//   final bool ispassword;//
//   final Function? validation;//
//   final Function? onChanged;//
//   final Function? onsumit;//
//   final Function? ontap;//
//   final Function? sufixpressd;//
//   final TextEditingController controller;//
//   final TextInputType type;//
//   final IconData? suffix;//
//   final double radius ;
//   final bool isClicable ;
//
//
//   @override
//   Widget build(BuildContext context) {
//     // App Theme
//     var theme = Theme.of(context);
//
//     //Check if dark mode enabled
//     bool darkModeOn = theme.brightness == Brightness.dark;
//
//     //Main Text Field Color
//     Color? color = darkModeOn ? Color(0xff252A34) : Colors.grey[300];
//
//     //Main Text Field border
//     OutlineInputBorder outlineInputBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//       borderSide: BorderSide(color: color!),
//     );
//
//     return TextFormField(
//
//       controller: controller,
//       keyboardType: type,
//       obscureText: ispassword,
//       onFieldSubmitted: (value) => onsumit!(value),
//       onChanged:(value) => onChanged!(value),
//       onTap: () => ontap!(),
//       enabled: isClicable,
//       validator: (value) => validation!(value),
//       decoration: InputDecoration(
//         prefixIcon: Icon(fixIcon),
//         suffixIcon: IconButton(
//           onPressed: () => sufixpressd!(),
//           icon: Icon(suffix),
//         ),
//         labelText: lable,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//         ),
//       ),
//     );
//   }
// }

// Widget defaultFormFiled({
//   required TextEditingController controller,
//   required TextInputType type,
//   required String lable,
//   required IconData fixIcon,
//   IconData? suffix,
//   bool ispassword = false,
//   Function? onChanged,
//   Function? onsumit,
//   Function? ontap,
//   Function? validation,
//   Function? sufixpressd,
//   bool isClicable = true,
//   double radius = 15.0,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: ispassword,
//       onFieldSubmitted: (value) => onsumit!(value),
//       onChanged:(value) => onChanged!(value),
//       onTap: () => ontap!(),
//       enabled: isClicable,
//       validator: (value) => validation!(value),
//       decoration: InputDecoration(
//         prefixIcon: Icon(fixIcon),
//         suffixIcon: IconButton(
//           onPressed: () => sufixpressd!(),
//           icon: Icon(suffix),
//         ),
//         labelText: lable,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//         ),
//       ),
//     );

Widget MyDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

// Widget buildArticaleItem(artical , context) => InkWell(
//   onTap: ()
//   {
//     navigateTo(context, WebViewScreen(artical['url']));
//   },
//   child:   Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         Container(
//           width: 120,
//           height: 120,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             image: DecorationImage(
//               image: NetworkImage('${artical['urlToImage']}'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Container(
//             height: 120 ,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${artical['title']}',
//                     style:Theme.of(context).textTheme.bodyText1,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Text(
//                   '${artical['publishedAt']}',
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastStates { SUCCESS, ERROR, WARNING }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

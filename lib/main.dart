import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/social_app/login/social_login_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubitObserver.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import 'shared/styles/themes.dart';
//import 'firebase_options.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print("Handling a background message");
  print(message.data.toString());

  showToast(text: 'firebaseMessagingBackgroundHandler', state: ToastStates.SUCCESS);

}

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );
      var token =await FirebaseMessaging.instance.getToken();
      print(token);

      //foreground fcm
      FirebaseMessaging.onMessage.listen((event) {
        print('onMessage');
        print(event.data.toString());

        showToast(text: 'onMessage', state: ToastStates.SUCCESS);

      });
      //when chick on notification opened app

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print('onMessageOpenedApp');
        print(event.data.toString());
        
        showToast(text: 'onMessageOpenedApp', state: ToastStates.SUCCESS);
      });

      //background fcm
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


      DioHelper.init();
      await CacheHelper.init();
      //bool? isDark= CacheHelper.getData(key:'isDark');
      Widget? widget;
      // bool? onBoarding= CacheHelper.getData(key:'onBoarding');

      uId = CacheHelper.getData(key: 'uId');
      if (uId != null) {
        widget = SocialLayout();
      } else {
        widget = SocialLoginScreen();
      }
      print('this is the used UID  $uId');
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: SocialLoginScreen(),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled/shared/components/components.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){
        if(state is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      },
      builder: (context ,state){
        var cubit= SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                      Icons.notifications)),
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                      Icons.search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex ,
            onTap:(index)
            {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat ,
                  ),
                  label: 'chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.upload ,
                  ),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.location_on,
                  ),
                  label: 'users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'settings'
              ),
            ],

          ),
        );
      },
    );
  }
}

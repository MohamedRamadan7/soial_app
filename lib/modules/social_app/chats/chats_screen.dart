import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app.dart';
import 'package:untitled/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:untitled/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){},
      builder: (context ,state){
        return Scaffold(
          body:SocialCubit.get(context).users.length > 0?ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItems(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=>MyDivider(),
              itemCount: SocialCubit.get(context).users.length):Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildChatItems(SocialUserModel model,context)=>InkWell(
  onTap: (){
    navigateTo(context, ChatDetailsScreen(userModel: model));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('${model.image}'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text('${model.name}',
          style:TextStyle(
            height: 1.4,
          ),)
      ],
    ),
  ),
);
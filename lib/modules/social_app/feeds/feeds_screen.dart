import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/post_model.dart';
import 'package:untitled/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){},
      builder: (context ,state){
        return SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null ?
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                margin: EdgeInsets.all(10.0),
                child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?w=826'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Communication with friends',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 15,
                              color: Colors.white),),
                      )
                    ]
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                separatorBuilder: (context,index)=> SizedBox(height: 8,),
                itemCount:SocialCubit.get(context).posts.length,),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ): Center(child: CircularProgressIndicator());
      },
    );
  }
  Widget buildPostItem(PostModel model,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${SocialCubit.get(context).userModel!.image}'),

              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                              height: 1.4
                          ),),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),),
                  ],
                ),
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_horiz)),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(
              thickness: 2,indent: 0,endIndent: 0,
            ),
          ),
          Text(
            '${model.text}. ',
            style: TextStyle(
                fontSize: 14.0,
                height: 1.3
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       bottom: 10.0,top: 5.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 10.0),
          //           child: Container(
          //             child: MaterialButton(
          //                 minWidth: 1.0,
          //                 height: 25.0,
          //                 padding:EdgeInsets.zero,
          //                 onPressed: (){},
          //                 child: Text('#software',
          //                   style: TextStyle(
          //                       color: defColor
          //                   ),)),
          //             height: 25.0,
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 10.0),
          //           child: Container(
          //             child: MaterialButton(
          //                 minWidth: 1.0,
          //                 height: 25.0,
          //                 padding:EdgeInsets.zero,
          //                 onPressed: (){},
          //                 child: Text('#flutter',
          //                   style: TextStyle(
          //                       color: defColor
          //                   ),)),
          //             height: 25.0,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if( model.postImage != '')
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 5.0),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                      image:NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_outline,
                            color: Colors.red,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                    onTap: ()
                    {

                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.chat,
                            color: Colors.amber[200],),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('0 comment',
                            style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Divider(
              thickness: 2,indent: 0,endIndent: 0,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),

                      ),

                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Write a comment ... ',
                        style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),),

                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(Icons.favorite_outline,
                      color: Colors.red,),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('Like',
                      style: Theme.of(context).textTheme.caption,)
                  ],
                ),
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          )
        ],
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var textController =TextEditingController();
        var now =DateTime.now();
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            actions: [
              TextButton(onPressed: ()
              {
                if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text)
                    ;
                  }else
                    {
                      SocialCubit.get(context).upLoadPostImage(
                          dateTime: now.toString(),
                          text: textController.text
                      );

                    }
              },
                  child: Text(
                'Post'
              ))
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1650633184~exp=1650633784~hmac=f1c4b3dcbd9c56a2a15c3c804b4d3417b3f24c7b91703e2bc86b327f20ab2a76&w=740'),

                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'Mohamed Ramadan',
                      style: TextStyle(
                          height: 1.4
                      ),),
                  ],

                ),
                Expanded(
                  child: TextFormField(
                    decoration:InputDecoration(
                      hintText: 'What is on your mind ...',
                      border:InputBorder.none,
                    ) ,
                    keyboardType:TextInputType.text,
                    controller: textController,

                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                              image: FileImage(SocialCubit.get(context).postImage!) as ImageProvider,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    CircleAvatar(
                      radius: 20.0,
                      child: IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 16.0,)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      },
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Add Photo'),
                              ],
                            ),
                          )
                      ),

                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child:  Text(
                              '#tags'
                          ),
                      ),

                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

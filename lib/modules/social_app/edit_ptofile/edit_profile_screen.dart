
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();


    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state){},
    builder: (context, state){
      var userModel = SocialCubit.get(context).userModel;
       var profileImage= SocialCubit.get(context).profileImage;
       var coverImage= SocialCubit.get(context).coverImage;


      nameController.text=userModel!.name!;
      bioController.text=userModel.bio!;
      phoneController.text=userModel.phone!;

      return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
              actions: [
                TextButton(
                  onPressed: (){
                     SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio:  bioController.text);
                  },
                  child: Text('Update'),
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is SocialUserUpdateLoadingState)
                      LinearProgressIndicator(),
                   SizedBox(
                     height: 10,
                   ),
                   Container(
                     height: 190,
                     child: Stack(
                       alignment: AlignmentDirectional.bottomCenter,
                       children: [
                         Align(
                           alignment: AlignmentDirectional.topCenter,
                           child: Stack(
                             alignment: AlignmentDirectional.topEnd,
                             children: [
                               Container(
                                 height: 140,
                                 width: double.infinity,
                                 decoration:BoxDecoration(
                                     borderRadius: BorderRadius.only(
                                       topRight: Radius.circular(4.0),
                                       topLeft:  Radius.circular(4.0),
                                     ),
                                     image: DecorationImage(
                                         image: coverImage != null?FileImage(coverImage) as ImageProvider: NetworkImage(
                                           '${userModel.cover}',
                                         ),
                                         fit: BoxFit.cover
                                     )
                                 ),
                               ),
                               CircleAvatar(
                                 radius: 20.0,
                                 child: IconButton(
                                     onPressed: (){
                                     SocialCubit.get(context).getCoverImage();
                                  },
                                     icon: Icon(
                                       Icons.camera_alt_rounded,
                                   size: 16.0,)),
                               )
                             ],
                           ),
                         ),
                         Stack(
                           alignment: AlignmentDirectional.bottomEnd,
                           children: [
                             CircleAvatar(
                               radius: 64.0,
                               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                               child: CircleAvatar(
                                 radius: 60.0,
                                 backgroundImage:  profileImage != null?FileImage(profileImage) as ImageProvider: NetworkImage(
                                     '${userModel.image}'),
                               ),
                             ),
                             CircleAvatar(
                               radius: 20.0,
                               child: IconButton(
                                   onPressed: (){
                                     SocialCubit.get(context).getProfileImage();
                                   },
                                   icon: Icon(Icons.camera_alt_rounded,
                                 size: 16.0,)),
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                    SizedBox(
                      height: 5,
                    ),
                    if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage != null )
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage!=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                    },
                                  isUberCase:false,
                                  text: 'Upload Profile' ),
                              if(state is SocialUserUpdateLoadingState)
                              SizedBox(
                                height: 5,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if(SocialCubit.get(context).coverImage!=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(function: (){
                                SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                                },
                                  isUberCase:false,
                                  text: 'Upload Cover' ),
                              if(state is SocialUserUpdateLoadingState)
                              SizedBox(
                                height: 5,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                             ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    defaultFormFiled(
                        controller: nameController,
                        type: TextInputType.name,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }
                        },
                        lable: 'Name',
                        fixIcon: Icons.person,
                        onsumit: (value) {}
                        ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormFiled(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }
                        },
                        lable: 'Phone',
                        fixIcon: Icons.call,
                        onsumit: (value) {}
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormFiled(
                        controller: bioController,
                        type: TextInputType.name,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return 'bio must not be empty';
                          }
                        },
                        lable: 'Bio',
                        fixIcon: Icons.info_outline,
                        onsumit: (value) {}
                    ),
                  ],
                ),
              ),
            )
          );
    }
    );
  }
}
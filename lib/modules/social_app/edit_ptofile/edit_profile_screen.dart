import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;
    var nameController = TextEditingController();
    var bioController = TextEditingController();


    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state){},
    builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
              actions: [
                TextButton(
                  onPressed: (){},
                  child: Text('Update'),
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                                       image:NetworkImage(
                                         '${userModel!.cover}',
                                       ),
                                       fit: BoxFit.cover
                                   )
                               ),
                             ),
                             CircleAvatar(
                               radius: 20.0,
                               child: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_rounded,
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
                               backgroundImage: NetworkImage(
                                   '${userModel.image}'),

                             ),
                           ),
                           CircleAvatar(
                             radius: 20.0,
                             child: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_rounded,
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
            )
          );
    }
    );
  }
}
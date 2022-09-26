
import 'dart:collection';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/message_model.dart';
import 'package:untitled/models/post_model.dart';
import 'package:untitled/models/social_app.dart';
import 'package:untitled/modules/social_app/chats/chats_screen.dart';
import 'package:untitled/modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled/modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled/modules/social_app/notificatians/notifications_screen.dart';
import 'package:untitled/modules/social_app/settings/settings_screen.dart';
import 'package:untitled/modules/social_app/users/users_screen.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      print('data is :$userModel');
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'chats',
    'Add Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {


    if(index ==1)
      getAllUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else
      currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickerSuccessState());

    } else {
      print('No image selected.');
      emit(SocialProfileImagePickerErrorState());

    }

  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickerSuccessState());

    } else {
      print('No image selected.');
      emit(SocialCoverImagePickerErrorState());

    }

  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path)
        .pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value){
            //emit(SocialUploadProfileImageSuccessState());
            print(value);
            updateUser(name: name, phone: phone, bio: bio,image: value);
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());

    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage!.path)
        .pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        //emit(SocialUploadCoverImageSuccessState());
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());

    });
  }

  // void updateUserImages(
  //     {
  //       required String name,
  //       required String phone,
  //       required String bio,
  //     }
  //     ){
  //
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if(coverImage != null){
  //     uploadCoverImage();
  //   }
  //   else if (profileImage != null ){
  //     uploadProfileImage();
  //   }
  //   else {
  //
  //     updateUser(
  //         name:name,
  //         phone: phone,
  //         bio: bio
  //     );
  //
  //     }
  //
  // }

  void updateUser(
      {
    required String name,
    required String phone,
    required String bio,
        String? image ,
        String? cover ,
      }
      ){

    emit(SocialUserUpdateLoadingState());
    SocialUserModel model =SocialUserModel(

      email: userModel!.email,
      image: image??userModel!.image,
      cover: cover??userModel!.cover,
      uId: userModel!.uId ,
      phone:phone ,
      name:name,
      bio:bio,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance.collection('users')
        .doc(userModel!.uId).update(model.toMap())
        .then((value){
      getUserData();
    })
        .catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickerSuccessState());

    } else {
      print('No image selected.');
      emit(SocialPostImagePickerErrorState());

    }

  }
  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void upLoadPostImage(
      {
        required String dateTime,
        required String text,

      }
      ) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postImage!.path)
        .pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        createPost(
            dateTime: dateTime,
            text: text,
          postImage: value,
        );

      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());

    });
  }
  void createPost(
      {
        required String dateTime,
        required String text,
        String? postImage ,
      }
      ){

    emit(SocialCreatePostLoadingState());
    PostModel model =PostModel(
      name:userModel!.name ,
      image:userModel!.image,
      uId: userModel!.uId ,
      text: text,
      dateTime: dateTime,
      postImage: postImage??'',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts= [];
  List<String> postsId= [];
  List<int> likes= [];
  List<int> comments= [];


  void getPosts(){
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('comments')
            .get().then((value) {

          comments.add(value.docs.length);

        }).catchError((error){});

        element.reference
            .collection('likes')
            .get()
            .then((value)
        {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
            .catchError((error){});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost( String postsId){
    FirebaseFirestore.instance.collection('posts')
        .doc(postsId)
        .collection('likes')
        .doc(userModel!.uId).set({
      'likes': true
    }).then((value) {

      emit(SocialLikePostSuccessState());
    }).catchError((error){
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost( {
    required String postsId,
    String? comment
}){
    FirebaseFirestore.instance.collection('posts')
        .doc(postsId)
        .collection('comments')
        .doc(userModel!.uId).set({
      'comments': comment
    }).then((value) {

      emit(SocialCommentsPostSuccessState());
    }).catchError((error){
      emit(SocialCommentsPostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users =[];
  void getAllUsers(){
    if(users.length ==0)
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel!.uId)
        users.add(SocialUserModel.fromJson(element.data()));

      });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }
  void sendMessage({
  required String receiverId,
  required String text,
  required String dateTime,
}){
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId:receiverId,
      text:text,
      dateTime:dateTime,
    );

    // set my chats
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages').add(model.toMap()).then((value) {
          emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
    .collection('users')
    .doc(receiverId)
    .collection('chats')
    .doc(userModel!.uId)
    .collection('messages').add(model.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

  }
  List<MessageModel> messages =[];

  void getMessages({
    required String receiverId,
})
  {
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
        .orderBy('dateTime')
    .snapshots()
    .listen((event) {

      messages =[];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

          emit(SocialGetMessageSuccessState());
    });
  }

}
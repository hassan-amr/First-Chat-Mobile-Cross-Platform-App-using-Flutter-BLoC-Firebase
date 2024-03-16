import 'package:first_chat/screens/chats/chats_screen.dart';
import 'package:first_chat/screens/contactprofile/contact_profile_screen.dart';
import 'package:first_chat/screens/contacts/contacts_screen.dart';
import 'package:first_chat/screens/home/cubit/home_states.dart';
import 'package:first_chat/screens/myprofile/my_profile_screen.dart';
import 'package:first_chat/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  int bottomNavbarSelectedIndex = 0;

  List<Widget> pages = <Widget>[
    ChatsScreen(),
    ContactsScreen(),
    MyProfileScreen(),
  ];

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void bottomNavBarOnItemTapped(int index) {
    bottomNavbarSelectedIndex = index;
    emit(HomeChangedCurrentScreenState());
  }

  void signOut() {
    UserData.deleteCurrentSignedInUser().then((_) {
      emit(HomeSignedOutState());
    });
  }
}

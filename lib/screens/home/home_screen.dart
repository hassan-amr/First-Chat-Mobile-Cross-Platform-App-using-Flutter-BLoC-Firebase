import 'package:first_chat/screens/home/cubit/home_cubit.dart';
import 'package:first_chat/screens/home/cubit/home_states.dart';
import 'package:first_chat/screens/signin/sign_in_screen.dart';
import 'package:first_chat/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeSignedOutState) {
            openSignInScreen(context);
          }
        },
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              // Status Bar Color
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.DARK_GREY,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
              // Toolbar Color
              backgroundColor: AppColors.DARK_GREY,
              // Title | Label
              title: Text(
                'First Chat',
                style: TextStyle(
                  color: AppColors.WHITE,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              // Popup Menu
              actions: <Widget>[
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return {'Sign Out'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                        onTap: () {
                          cubit.signOut();
                        },
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavbarSelectedIndex,
              onTap: cubit.bottomNavBarOnItemTapped,
              elevation: 8,
              iconSize: 33,
              selectedItemColor: AppColors.DARK_GREY,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts_rounded),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'My Profile',
                ),
              ],
            ),
            body: Center(
              child: cubit.pages[cubit.bottomNavbarSelectedIndex],
            ),
          );
        },
      ),
    );
  }

  void openSignInScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
}

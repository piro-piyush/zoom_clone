import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screens/history_meeting_screen.dart';
import 'package:zoom_clone/screens/meeting_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MeetingScreen(),
      const HistoryMeetingScreen(),
      CustomButton(
        text: 'Log Out',
        onTap: () => AuthMethods().signOut(context),
      ),
    ];
    void onPageChanged(int index) {
      setState(() {
        _page = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: const Text('Meet & Chat'),
        centerTitle: true,
        elevation: 0,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.footerColor,
        selectedItemColor: MyColors.light,
        unselectedItemColor: MyColors.grey,
        currentIndex: _page,
        onTap: (index) => onPageChanged(index),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: 'Meet & Char',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Meetings',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   label: 'Contacts',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'screens/create_gift_screen.dart';
import 'screens/friend_profile_screen.dart';
import 'screens/gift_details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notifications_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SurprizApp());
}

class SurprizApp extends StatelessWidget {
  const SurprizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surpriz.io',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _RootShell(),
    );
  }
}

class _RootShell extends StatefulWidget {
  const _RootShell();

  @override
  State<_RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<_RootShell> {
  int _index = 0;

  final _screens = <Widget>[
    HomeScreen(onNavigateToGift: () {}),
    const FriendProfileScreen(),
    const NotificationsScreen(),
    const CreateGiftScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (value) => setState(() => _index = value),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFFFF8A65),
              unselectedItemColor: Colors.grey[500],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_rounded),
                  label: 'Friends',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active_rounded),
                  label: 'Alerts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: 'Create',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: () => setState(() => _index = 3),
              icon: const Icon(Icons.card_giftcard),
              label: const Text('Start a Gift'),
            )
          : null,
    );
  }
}

class GiftDetailsRoute extends StatelessWidget {
  const GiftDetailsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const GiftDetailsScreen();
  }
}

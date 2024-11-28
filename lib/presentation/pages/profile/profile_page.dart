import '../../misc/constants.dart';
import '../../providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/methods.dart';
import '../../providers/user_data/user_data_provider.dart';
import 'methods/profile_item.dart';
import 'methods/user_info.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              verticalSpace(20),
              ...userInfo(ref),
              verticalSpace(20),
              const Divider(),
              verticalSpace(20),
              profileItem('Update Profile'),
              verticalSpace(20),
              profileItem('My Wallet',
                  onTap: () => ref.read(routerProvider).pushNamed('wallet')),
              verticalSpace(20),
              profileItem('Change Password'),
              verticalSpace(20),
              profileItem('Change Language'),
              verticalSpace(20),
              const Divider(),
              verticalSpace(20),
              profileItem('Contact Us'),
              verticalSpace(20),
              profileItem('Privacy Policy'),
              verticalSpace(20),
              profileItem('Terms and Conditions'),
              verticalSpace(80),
              Container(
                width: double.infinity,
                height: 42,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [primeOrange, primeRed]),
                    borderRadius: BorderRadius.circular(28)),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(userDataProvider.notifier).logout();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: ghostWhite),
                  ),
                ),
              ),
              verticalSpace(20),
              const Center(
                child: Text(
                  'Version 0.0.1',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              verticalSpace(100)
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/core/constants/widgets.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_page.dart';
import 'package:unitysocial/features/profile/screens/widgets/sign_out_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/tile_item_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showProfileAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (context, state) => state is LoginSuccesState,
              builder: (context, state) {
                if (state is UserFoundState || state is LoginSuccesState) {
                  return _showProfileStats(state);
                }
                return const Center(
                  child: Text('Error fetching user profile'),
                );
              },
            ),
            const SizedBox(height: 20),
            TileItem(
              title: 'Your Projects',
              onTap: () => Navigator.pushNamed(context, '/yourProjects'),
              icon: Icon(
                Icons.folder_shared_rounded,
                color: CupertinoColors.systemCyan.highContrastColor,
              ),
            ),
            const SizedBox(height: 5),
            TileItem(
              title: 'Your Contributions',
              onTap: () => Navigator.pushNamed(context, '/yourStats'),
              icon: const Icon(
                Icons.bar_chart_rounded,
                color: CupertinoColors.systemGreen,
              ),
            ),
            const SizedBox(height: 5),
            TileItem(
              title: 'Accreditations',
              onTap: () => Navigator.pushNamed(context, '/accreditations'),
              icon: Icon(
                CupertinoIcons.text_badge_star,
                color: CupertinoColors.systemYellow.withRed(1000),
              ),
            ),
            const Spacer(),
            const AnimatedSignOutButton(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showAbout(context),
                    _divider(),
                    showContact(context),
                    _divider(),
                    version(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  // Refactored widgets

  

  Text _divider() {
    return const Text(
      '  |  ',
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  InkWell showContact(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        // Construct mailto URL with appropriate encoding
        final mailUrl = Uri.encodeFull(
            'mailto:jyothish.ka25@gmail.com?subject=Unity Social App feedback');

        try {
          if (await canLaunch(mailUrl)) {
            await launch(mailUrl,
                forceSafariVC: false, forceWebView: false); // Launch email app
            log('Launched email app successfully.'); // Log success
          } else {
            log('Could not launch email app.'); // Log error
          }
        } catch (e) {
          log('mailing error $e');
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          'Contact',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  InkWell showAbout(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        showAboutDialog(
            context: context,
            applicationVersion: 'Version 1.0',
            applicationIcon: Padding(
              padding: const EdgeInsets.fromLTRB(10, 12.5, 5, 10),
              child: SvgPicture.asset(
                'assets/UnitySocial-logo.svg',
                width: 30,
                height: 30,
              ),
            ),
            children: [
              const Text(
                  'Unity Social is a volunteering app project by Jyothish K A, This project was designed after the UX Processes and later developed using Flutter framework.'),
              TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        'https://www.termsfeed.com/live/e40a8ad0-331c-4c53-a46f-e4877e822568'));
                  },
                  child: const Text('Privacy Policy'))
            ]);
      },
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          'About Us',
          style: TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget _aboutUsAndContact(BuildContext context) {
    return Column(
      children: [
        const Text('version 1.0',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationVersion: 'Version 1.0',
                    applicationIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12.5, 5, 10),
                      child: SvgPicture.asset(
                        'assets/UnitySocial-logo.svg',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    children: [
                      const Text(
                          'Unity Social is a volunteering app project by Jyothish K A, This project was designed after the UX Processes and later developed using Flutter framework.')
                    ]);
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'About Us',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const Text(
              '  |  ',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                showCupertinoModalPopup(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text('Contact'),
                      content: TextButton(
                          onPressed: () {}, child: const Text('Send mail')),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Contact',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _showProfileStats(state) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: CupertinoColors.lightBackgroundGray.withOpacity(.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 30,
                    child: Icon(
                      CupertinoIcons.person_crop_circle,
                      size: 35,
                      color: Colors.grey,
                    )),
                const SizedBox(width: 10),
                Text(
                  state.userName,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.verified_rounded,
                  size: 20,
                  color: CupertinoColors.activeBlue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // COMPONENTS

  PreferredSize _showProfileAppbar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(title: 'Profile'));
  }

  _signOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        titleTextStyle: const TextStyle(color: CupertinoColors.systemRed),
        title: const Text('Sign out'),
        iconColor: CupertinoColors.systemRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: CupertinoColors.lightBackgroundGray.withOpacity(.6),
        leading: const Icon(CupertinoIcons.square_arrow_right),
        onLongPress: () async {
          try {
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            });
          } on FirebaseAuthException catch (error) {
            log(error.toString());
          }
        },
      ),
    );
  }
}

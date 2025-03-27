// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 添加 Firebase 认证
import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({super.key, required this.loggedIn, required this.signOut});

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                onPressed: () {
                  !loggedIn ? context.push('/sign-in') : signOut();
                },
                child: !loggedIn ? const Text('RSVP') : const Text('Logout'),
              ),
            ),
            Visibility(
              visible: loggedIn,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 8),
                child: StyledButton(
                  onPressed: () {
                    context.push('/profile');
                  },
                  child: const Text('Profile'),
                ),
              ),
            ),
          ],
        ),
        // Google 登录按钮，仅在未登录时显示
        Visibility(
          visible: !loggedIn,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 8),
            child: StyledButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
                } catch (e) {
                  print('Google Sign-In Error: $e');
                }
              },
              child: const Text('Sign in with Google'),
            ),
          ),
        ),
      ],
    );
  }
}
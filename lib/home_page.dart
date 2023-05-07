// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:flutter/material.dart'; // new
import 'package:provider/provider.dart'; // new
import './src/services/firestore/guest_book.dart';
import './src/providers/authentication/app.state.dart'; // new
import 'src/authentication.dart'; // new
import 'src/services/firestore/guest_book.dart';
import 'src/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'October 30'),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  const Header('Discussion'),
                  GuestBook(
                    addMessage: (message) =>
                        appState.addMessageToGuestBook(message),
                    messages: appState.guestBookMessages,
                  ),
                ],
                const Header('People attending'),
                Header(appState.numberOfAttendingPeople.toString()),
                if (appState.isAttending)
                  Row(
                    children: [
                      OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.deepPurple)),
                          onPressed: () async {
                            // appState.addGuestToMeetig(true);
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          )),
                      OutlinedButton(
                          onPressed: () async {
                            appState.addGuestToMeetig(false);
                          },
                          child: const Text(
                            "No",
                          )),
                    ],
                  ),
                if (!appState.isAttending)
                  Row(
                    children: [
                      OutlinedButton(
                          onPressed: () async {
                            appState.addGuestToMeetig(true);
                          },
                          child: const Text(
                            "Yes",
                          )),
                      OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.deepPurple)),
                          onPressed: () async {
                            //  appState.addGuestToMeetig(false);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
              ],
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
        ],
      ),
    );
  }
}

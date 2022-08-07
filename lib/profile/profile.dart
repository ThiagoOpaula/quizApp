import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/models.dart';
import '../services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: user!.photoURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL ?? ''),
                    )
                  : CircleAvatar(
                      backgroundColor:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.4),
                      child: Text(
                        user.displayName != ''
                            ? user.displayName!.substring(0, 1)
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              user.displayName ?? 'Guest',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Quizzes Completed:' ' ${report.total}',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

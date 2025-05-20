import 'package:flutter/material.dart';
import 'package:frontend_app/screens/login_screen.dart';
import 'package:frontend_app/services/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
            color: Color.fromARGB(15, 0, 0, 0)
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topSection(),
            bottomSection(context)
          ],
        ),
      )
    );
  }

  Widget topSection() {
    return Column(
      children: [

      ],
    );
  }

  Widget bottomSection(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 35),
          onTap: () async {
            final ok = await logout();
            if (ok && context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          leading: Icon(
            Icons.logout,
            size: 14,
          ),
          title: Text(
            'Logout',
            style: TextStyle(
                fontSize: 14
            ),
          ),
        ),
      ],
    );
  }
}
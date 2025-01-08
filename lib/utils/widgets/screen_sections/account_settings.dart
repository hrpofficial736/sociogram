import 'package:flutter/material.dart';
import '../../../services/get_user_credentials.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Account",
                  style: TextStyle(
                      fontFamily: "Inria",
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 23)))),
      Padding(
          padding: EdgeInsets.all(30),
          child: Container(
              child: Column(children: [
            Row(spacing: 50, children: [
              Text("Email:",
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary,
                      fontFamily: "Inria", fontWeight: FontWeight.w700)),
              Text(getUserCredentials()["userEmail"]!,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary,
                      fontFamily: "Inria", fontWeight: FontWeight.w700))
            ]),
            Row(spacing: 50, children: [
              Text("Status:",
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary,
                      fontFamily: "Inria", fontWeight: FontWeight.w700)),
              Row(spacing: 5, children: [
                Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getUserCredentials()["userEmail"] != null
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                    )),
                Text(
                    getUserCredentials()["userEmail"] != null
                        ? "ONLINE"
                        : "OFFLINE",
                    style: TextStyle(
                        color: getUserCredentials()["userEmail"] != null
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                        fontFamily: "Inria",
                        fontWeight: FontWeight.w700))
              ])
            ]),
            
          ])))
    ]);
  }
}

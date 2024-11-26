import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(children: [
         IconButton(onPressed: () {
           Navigator.pushNamed(context, "/home");
         }, icon: const Icon(Icons.add_to_home_screen))
        ],),
      )
    );
  }
}

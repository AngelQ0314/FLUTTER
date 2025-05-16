import 'package:ejemplo/src/app.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MiAplicacion());

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App 1',
      home: App_Login(
        
      ),
    );
  }
}
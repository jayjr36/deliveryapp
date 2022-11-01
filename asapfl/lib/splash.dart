import 'package:flutter/material.dart';

class splash extends StatelessWidget {
  const splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 200,
        width: 300,
        child: Image(image: AssetImage('assets/asapreg.png',
        
        )),
      ),
    );
  }
}


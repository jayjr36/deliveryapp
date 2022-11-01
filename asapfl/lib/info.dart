import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.1,
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: const Text(
                  'INFO',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),

      body: Column(
        
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40,top: 30),
            child: Text('For any enquries contact us through\nemail\nphone',
            style: TextStyle(
              fontSize: 18,

            ),),
          )
        ],
      )
    );
  }
}

import 'dart:convert';
import 'dart:core';

import './foods_model.dart';
import './mymenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './foods_provider.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  final bool isSelected = false;


  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  List<Foods> foods=[];
  List<Foods> myList=[];
  final bool isSelected=false;
   void initState(){
     super.initState();
   }

/*
  Future fetchFoods() async {
    return foods;
  }*/
  @override
  Widget build(BuildContext context) {
    var foods = context.watch<FoodsProvider>().foods;
    var myList = context.watch<FoodsProvider>().myList;
    return Scaffold(
        appBar: AppBar(
          title: const Text('List of foods'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MyMenu()));
              },
              icon: const Icon(Icons.favorite),
              label: Text(
                'My order (${myList.length})',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Foods>>(
                future: initialData(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Text("error: ${snapshot.error}");
                  }else if(snapshot.hasData) {
                    var fooddata = snapshot.data as List<Foods>;
                    return ListView.builder(
                        padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                        itemCount:fooddata == null ? 0 :fooddata.length,
                        itemBuilder: (_, index) {
                          final currentFood = fooddata[index];

                          return Card(
                              key: ValueKey(currentFood.title),
                              color: Colors.green,
                              elevation: 4,
                              child: ListTile(
                                  title: Text(fooddata[index].title.toString(),
                                      style:
                                      const TextStyle(color: Colors.white)),
                                  subtitle: Text(
                                      fooddata[index].duration.toString(),
                                      style:
                                      const TextStyle(color: Colors.white)),
                                  trailing: IconButton(
                                    onPressed: () {

                                      setState(() {
                                        currentFood.isSelected = !currentFood.isSelected;
                                        if (!myList.contains(currentFood)) {
                                          context
                                              .read<FoodsProvider>()
                                              .addToList(currentFood);

                                        } else {
                                          context
                                              .read<FoodsProvider>()
                                              .removeFromList(currentFood);
                                        }
                                      });

                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: myList.contains(currentFood)
                                          ? Colors.red
                                          : Colors.white,
                                      size: 30,
                                    ),
                                  )));
                        }
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ));
  }
}

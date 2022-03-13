import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class FoodsList extends StatefulWidget {
  const FoodsList({Key? key, required this.onChange, this.foodSelected = ''})
      : super(key: key);

  final void Function(String, int) onChange;
  final String foodSelected;

  @override
  _FoodsListState createState() => _FoodsListState();
}

class _FoodsListState extends State<FoodsList> {
  var foods = [
    {
      'imgName': 'assets/icons/pasta.png',
      'title': '4 มื้อขึ้นไป',
      'index': 0,
    },
    {
      'imgName': 'assets/icons/fish.png',
      'title': '4 มื้อ',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/sandwich.png',
      'title': '3 มื้อ',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/thai-food.png',
      'title': '2 มื้อ',
      'index': 3,
    },
    {
      'imgName': 'assets/icons/noodles.png',
      'title': '1 มื้อ',
      'index': 4,
    },
    {
      'imgName': 'assets/icons/nofood.png',
      'title': "ไม่ทานอาหาร",
      'index': 5,
    },
  ];

  @override
  initState() {
    getFood();
    super.initState();
  }

  getFood() {
    for (var i = 0; i < foods.length; i++) {
      if (widget.foodSelected == foods[i]['title']) {
        isFood = foods[i]['index'] as int;
      }
    }
  }

  int? isFood = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Food',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: foods
                  .map<Widget>((f) => GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.onChange(
                                f["title"] as String, f["index"] as int);
                            isFood = f["index"] as int;
                          });
                        },
                        child: Row(
                          children: [
                            AnimatedContainer(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 8,
                                duration: Duration(seconds: 2),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        '${f["imgName"]}',
                                        height: 60,
                                      ),
                                      Text(
                                        '${f["title"]}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: (isFood == f["index"] as int)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: (isFood == f["index"] as int)
                                      ? BoxDecoration(
                                          color: Color(0xFF56C956),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade200,
                                                spreadRadius: 2.0),
                                            BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 2.0)
                                          ],
                                        )
                                      : BoxDecoration(
                                          color: Palette.secondary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade200,
                                                spreadRadius: 2.0),
                                            BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 2.0)
                                          ],
                                        ),
                                )),
                            SizedBox(width: 10)
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

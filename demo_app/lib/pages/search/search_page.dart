import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Search Video');
  List<int> itemList = List();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 5; i++) {
      itemList.add(i);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search Video"),
        // leading: IconButton(icon: Icon(Icons.menu), onPressed: (){}),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                      // textInputAction: TextInputAction.go,
                      // style: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 16.0
                      // ),
                      );
                }
              });
            },
            icon: cusSearchBar,
          )
        ],
      ),
      body: Center(
        child: GridView.builder(
          itemCount: itemList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisSpacing: 30.0),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          "images/placeholder.png",
                          // width: 200.0,
                          // height: 100.0,
                        ),
                      ),
                      Text('Title of Movie',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(
                          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

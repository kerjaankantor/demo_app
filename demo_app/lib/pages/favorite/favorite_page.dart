import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritePage();
  }
}

class _FavoritePage extends State<FavoritePage> {
  List<Priority> _priority = Priority.getPriorities();
  List<DropdownMenuItem<Priority>> _dropDownMenuItems;
  Priority _selectedPriority;
  bool isView = false;
  DateTime _dateTime;

  @override
  void initState() {
    _dropDownMenuItems = _buildDropdownPriorityItems(_priority);
    _selectedPriority = _dropDownMenuItems[0].value;
    print(_selectedPriority);
    super.initState();
  }

  List<DropdownMenuItem<Priority>> _buildDropdownPriorityItems(
      List priorities) {
    List<DropdownMenuItem<Priority>> items = List();
    for (Priority priority in priorities) {
      items.add(DropdownMenuItem(
        value: priority,
        child: Text(priority.categoryPriority),
      ));
    }
    return items;
  }

  void _onSwitchChanged(bool value){
    isView = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget posterSection = Container(
      child: Image.asset("images/placeholder.png"),
    );

    Widget titleSection = Container(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        'Unknown Movie',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );

    Widget description = Container(
      padding: EdgeInsets.all(16),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean'
        'penatibus et magnis dis parturient montes, nascetur ridiculus mus'
        'Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu',
        textAlign: TextAlign.justify,
      ),
    );

    Widget ratingSection = Row(
      children: <Widget>[
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star_half, color: Colors.yellow),
        Icon(Icons.star_border, color: Colors.black),
        Icon(Icons.star_border, color: Colors.black),
        Text('7.8'),
      ],
    );

    Widget viewSection = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[ratingSection, Text('1000 views')],
    );

    Widget prioritySection = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('Priority'),
        // SizedBox(
        //   height: 20.0,
        // ),
        DropdownButton(
          value: _selectedPriority,
          items: _dropDownMenuItems,
          onChanged: (Priority value) {},
        ),
      ],
    );

    Widget viewOptionSection = new Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: <Widget>[
         Text("View"),
         Switch(value: isView, onChanged: _onSwitchChanged),
       ],

    );

    Widget updateDateSection = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("Update Date"),
        Text(_dateTime == null ? 'Pick date please' : _dateTime.toString()),
        RaisedButton(onPressed: (){
          showDatePicker(
            context: context, 
            initialDate: DateTime.now(), 
            firstDate: DateTime(2020),
             lastDate: DateTime(2022)).then((date){
               setState(() {
                 _dateTime = date;
               });
             });
        })

      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Favorite"),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          posterSection,
          titleSection,
          description,
          Container(
            padding: EdgeInsets.only(bottom: 24),
            child: viewSection,
          ),
          prioritySection,
          viewOptionSection,
          updateDateSection
        ],
      ),
    );
  }
}

class Priority {
  int id;
  String categoryPriority;
  Priority(this.id, this.categoryPriority);

  static List<Priority> getPriorities() {
    return <Priority>[
      Priority(1, "Soon"),
      Priority(2, "Tomorrow"),
      Priority(3, "If im on mood"),
      Priority(4, "Should I?")
    ];
  }
}

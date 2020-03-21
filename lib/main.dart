import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'tinder/tinder.dart';
import 'dart:math';

void main() => runApp(MyApp());

class GlobalData extends ChangeNotifier {
  int count = 999;
  String zipCode;

  //Todo Class User

  void notify() {
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => GlobalData(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => MyHomePage(title: 'Boots Demo Home Page'),
            '/signupNeeder': (context) => Kitten(),
            '/Kitten': (context) => Kitten(),
            '/signupCaretaker': (context) => TriColor(),
            '/zipPage': (context) => ZipPage(title: 'Boots Zip Page'),
            '/admin': (context) => Tinder(),
          }),
    );
  }
}

class Kitten extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.network(
          'https://images.unsplash.com/photo-1560114928-40f1f1eb26a0?ixlib=rb-1.2.1&w=1000&q=80'),
    );
  }
}

class TriColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('BuildTricolor'),
    );
  }
}

class ZipForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              hintText: 'Enter your ZipCode',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Provider.of<GlobalData>(context).zipCode = myController.text;
                  Provider.of<GlobalData>(context).notify();
                  Navigator.pushNamed(context, '/zipPage');
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  void _onItemTapped(BuildContext context, index) {
    if (index == 0) {
      Provider.of<GlobalData>(context).count++;
      Navigator.pushNamed(context, '/Kitten');
    } else if (index == 1) {
      Provider.of<GlobalData>(context).count--;
      Provider.of<GlobalData>(context).notify();
//      Navigator.pushNamed(context, '/admin');
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Kitten();
        },
      );
    } else {
      Provider.of<GlobalData>(context).count *= 2;
      Navigator.pushNamed(context, '/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final clickedView = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          height: 200.0,
          child: Image.network("http://alexdomzalski.com/botglogo.png"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Welcome to BootsOnTheGround. We are here to match Needers with 3Caretakers, now, "
            "before the coronavirus needs go up exponentially. With 3 Caretakers, you'll have "
            "backups if people can't help a needer due to illness or other conflicts.",
            style: Theme.of(context).textTheme.body1,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "We've matched up 7777 people since 3/19/2020. Currently, we have 333 people looking for a match.",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        ZipForm(),

//        Text(
//          '${Provider.of<Counter>(context).count}',
//          style: Theme.of(context).textTheme.display1,
//        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
        title: Text(this.title),
      ),
      bottomNavigationBar: MyNavBar1(),
      body: Center(
        child: clickedView,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<GlobalData>(context).count++;
          Provider.of<GlobalData>(context).notify();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ZipPage extends StatelessWidget {
  ZipPage({Key key, this.title}) : super(key: key);
  final String title;

  void _onItemTapped(BuildContext context, index) {
    if (index == 0) {
      Provider.of<GlobalData>(context).count++;
      Navigator.pushNamed(context, '/Kitten');
    } else if (index == 1) {
      Provider.of<GlobalData>(context).count--;
      Provider.of<GlobalData>(context).notify();
      Navigator.pushNamed(context, '/admin');
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Kitten();
        },
      );
    } else {
      Provider.of<GlobalData>(context).count *= 2;
      Navigator.pushNamed(context, '/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final centerStuff = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          height: 200.0,
          child: Image.network("http://alexdomzalski.com/botglogo.png"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "In your ZipCode, ${Provider.of<GlobalData>(context).zipCode} \n"
            "There are 20 Caretakers and 5 Needers Available",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        Expanded(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

//          ConstrainedBox(
//            constraints: BoxConstraints(
//              minWidth: 200.0,
//              //TODO figure out how to center and align everything. Everything is align left.
//              minHeight: 400.0,
//              maxWidth: 200.0,
//              maxHeight: 400.0,
//            ),
//            child: SampleListView(),
//          ),
            SizedBox(
              width: 200.0,
              height: 400.0,
              child: SampleListView(),
            ),
            SizedBox(
              width: 200.0,
              height: 400.0,
              child: SampleListView2(),
            ),
          ],),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 100.0,
              child: Text('What Role Are You?')),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                },
                child: Text('Needer'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Caretaker'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Admin'),
              ),
            ],
          ),
        ),

//        Text(
//          '${Provider.of<Counter>(context).count}',
//          style: Theme.of(context).textTheme.display1,
//        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
        title: Text(this.title),
      ),
      bottomNavigationBar: MyNavBar1(),
      body: Center(child: centerStuff),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<GlobalData>(context).count++;
          Provider.of<GlobalData>(context).notify();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyNavBar1 extends StatelessWidget {
  const MyNavBar1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
// Create your BottomNavigationBar items
        BottomNavigationBarItem(
          backgroundColor: Colors.green,
          icon: Container(
            width: 50,
            alignment: Alignment.center,
// color: Colors.red,
            decoration: ShapeDecoration(
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
              shape: StadiumBorder(),
              color: Colors.blue,
//                shape: Border(
//                      right: BorderSide(
//                        color: Colors.red,
//                        width: 4.0,
//                      ),
//                    ) +
//                    Border.all(
//                      color: Colors.blue,
//                      width: 4.0,
//                    ) +
//                    CircleBorder(
//                      side: BorderSide(color: Colors.green, width: 4.0),
//                    ),
// shape: CircleBorder(side: BorderSide(color: Colors.green, width: 3)),
// color: Colors.red,
            ),
            child: Icon(Icons.add),
          ),
          title: new Text("Add"),
        ),
        BottomNavigationBarItem(
          icon: Text('1'),
//            icon: Container(
//              alignment: Alignment.center,
//              width: 50,
//              height: 50,
//              color: Colors.red,
//              child: Text('---'),
//            ),
          title: new Text("2"),
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.angleDoubleRight), title: new Text("3"))
      ],
      backgroundColor: Colors.amber,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      currentIndex: 1,
      onTap: (index) => () {},
    );
  }
}

class NameBox extends StatelessWidget {
  final String name;
  final int myColorInt;

  NameBox(this.name, this.myColorInt);

  @override
  Widget build(BuildContext context) {
    print(myColorInt.toString() + name);
    return Container(
      height: 50,
      color: Colors.red[myColorInt ],
      child: Center(child: Text(name)),
    );
  }
}

class SampleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        NameBox("gerry", 500),
        NameBox("todd", 300),
        NameBox("Mom", 200),
        NameBox("Putin", Random().nextInt(1000)),
        NameBox("Larry", 900),
        NameBox("Joe", Random().nextInt(1000)),
        NameBox("Jason", 45),
        NameBox("Zoe", Random().nextInt(1000)),
        NameBox("Alex", Random().nextInt(1000)),
        NameBox("Frank", Random().nextInt(1000)),
        NameBox("gerry", Random().nextInt(1000)),
        NameBox("todd", Random().nextInt(1000)),
        NameBox("Mom", Random().nextInt(1000)),
        NameBox("Zoe", Random().nextInt(1000)),
        NameBox("Alex", Random().nextInt(1000)),
        NameBox("Frank", Random().nextInt(1000)),
        NameBox("Zoe", Random().nextInt(1000)),
        NameBox("Alex", Random().nextInt(1000)),
        NameBox("Frank", Random().nextInt(1000)),
        NameBox("gerry", Random().nextInt(1000)),
        NameBox("todd", Random().nextInt(1000)),
      ],
    );
  }
}

class SampleListView2 extends StatelessWidget {
  final List<String> entries = <String>['Dad', 'A', 'B', 'C', 'Q'];
  final List<int> colorCodes = <int>[50, 600, 500, 100, 333];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.blue[colorCodes[index]],
          child: Center(child: Text('Caretaker ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/temp_car.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/custom_app_bar.dart';

//From: https://github.com/Ephenodrom/Flutter-Advanced-Examples/blob/master/lib/examples/filterList/Car.dart
class Example1 extends StatefulWidget {

  @override
  _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  List<Car> initialList = Car.cars;
  List<Car> currentList = [];

  //filter
  bool selfDriving = false;
  double maxPrice = 100000;
  String carType = "all";

  final controller = new TextEditingController();

  @override
  initState() {
    super.initState();
    controller.addListener(onChange);
    filterCars();
  }

  @override
  Widget build(BuildContext context) {
    filterCars();
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: AppDrawer(),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(children: [
            Text("Search for your car",style: Theme.of(context).textTheme.headline,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: controller
              ),
            ),
            SwitchListTile(
              title: Text('Selfdriving'),
              value: selfDriving,
              onChanged: (changed){
                setState(() => selfDriving = changed);
              }
            ),
            Slider(
              label: '${maxPrice.round()} \$',
              activeColor: Colors.indigoAccent,
              min: 0.0,
              max: 100000.0,
              divisions: 20,
              onChanged: (newRating) {
                setState(() => maxPrice = newRating);
              },
              value: maxPrice,
            ),
            ListTile(
              leading: Text("Engine Type"),
              trailing: DropdownButton(
                elevation: 16,
                onChanged: (item){
                  setState(() {
                    carType = item;
                  });
                },
                hint:Text(carType),
                items: [
                  DropdownMenuItem<String>(
                      child: new Text("All"),
                      value: "All"
                  ),
                  DropdownMenuItem<String>(
                      child: new Text("Gas"),
                      value: "Gas"
                  ),
                  DropdownMenuItem<String>(
                      child: new Text("Diesel"),
                      value: "Diesel"
                  ),
                  DropdownMenuItem<String>(
                      child: new Text("Electric"),
                      value: "Electric"
                  )
                ],
              )
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: currentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Car current = currentList.elementAt(index);
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(current.name),
                        subtitle: Text(current.brand),
                        trailing: Text(current.price.toString()+" \$"),
                        leading: Text(current.year),
                      ),
                    );
                  }),
            ),
          ]),
        ));
  }

  onChange() {
    setState((){});
  }

  filterCars() {
    // Prepare lists
    List<Car> tmp = [];
    currentList.clear();

    String name = controller.text;
    print("filter cars for name " + name);
    if (name.isEmpty) {
      tmp.addAll(initialList);
    } else {
      for (Car c in initialList) {
        if (c.name.toLowerCase().startsWith(name.toLowerCase())) {
          tmp.add(c);
        }
      }
    }
    currentList = tmp;

    if(selfDriving) {
      tmp = [];
      print("filter cars for selfdriving " + selfDriving.toString());
      for (Car c in currentList) {
        if (c.selfDriving == selfDriving) {
          tmp.add(c);
        }
      }
      currentList = tmp;
    }

    print("filter cars for max price " + maxPrice.toString());
    tmp = [];
    for (Car c in currentList) {
      if(c.price < maxPrice){
        tmp.add(c);
      }
    }
    currentList = tmp;
    if(carType.toLowerCase() != "all") {
      tmp = [];
      print("filter cars for type " + carType);
      for (Car c in currentList) {
        if (c.type == carType.toLowerCase()) {
          tmp.add(c);
        }
      }
      currentList = tmp;
    }
  }

}
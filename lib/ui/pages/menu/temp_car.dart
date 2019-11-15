///From: https://github.com/Ephenodrom/Flutter-Advanced-Examples/blob/master/lib/examples/filterList/Car.dart
class Car {
  final String name;
  final String brand;
  final String type;
  final int maxSpeed;
  final int horsePower;
  final String year;
  final bool selfDriving;
  final double price;

  Car({
    this.name,
    this.brand,
    this.type,
    this.maxSpeed,
    this.horsePower,
    this.year,
    this.selfDriving,
    this.price,
  });

  static final cars = [
    new Car(
        name: "Jazz",
        brand: "Honda",
        type: "gas",
        maxSpeed: 200,
        horsePower: 83,
        year: "2001",
        selfDriving: false,
        price: 2000.00),
    new Car(
        name: "Citigo",
        brand: "Skoda",
        type: "gas",
        maxSpeed: 200,
        horsePower: 75,
        year: "2011",
        selfDriving: false,
        price: 10840.00),
    new Car(
        name: "Octavia Combi",
        brand: "Skoda",
        type: "diesel",
        maxSpeed: 240,
        horsePower: 149,
        year: "2016",
        selfDriving: false,
        price: 32650.00),
    new Car(
        name: "Rapid",
        brand: "Skoda",
        type: "diesel",
        maxSpeed: 240,
        horsePower: 95,
        year: "2012",
        selfDriving: false,
        price: 20190.00),
    new Car(
        name: "Q2",
        brand: "Audi",
        type: "gas",
        maxSpeed: 280,
        horsePower: 140,
        year: "2018",
        selfDriving: false,
        price: 28000.00),
    new Car(
        name: "Model 3",
        brand: "Tesla",
        type: "electric",
        maxSpeed: 280,
        horsePower: 140,
        year: "2018",
        selfDriving: true,
        price: 35000),
  ];
}
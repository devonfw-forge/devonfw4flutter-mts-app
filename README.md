![Banner](https://github.com/Fasust/my-thai-star-flutter/blob/master/.additional_material/graphics/banner.png)

## Contents
- [Creation Context](#creation-context)
- [Purpose](#purpose)
- [Previous Related Work](#previous-related-work)
- [Covered Topics](#covered-topics)
- [Architecture](#architecture)
- [Screens](#screens)
  - [Original Angular](#original-angular)
  - [New Flutter](#new-flutter)
- [Set-Up _(With hosted Back-End)_](#set-up-with-hosted-back-end)
- [Set-Up _(Test)_](#set-up-test)
- [Set-Up _(With own Back-End)_](#set-up-with-own-back-end)

## Creation Context 
This project is part of a bachelor thesis written by a student in the Bachelor of Science Program “Computer Science and Media Technology” at [Technical University Cologne](https://www.th-koeln.de/en/homepage_26.php). The work was executed in collaboration with [Capgemini Cologne](https://www.capgemini.com/us-en/). Capgemini’s [DevonFw open-source initiative](https://devonfw.com/index.html) maintains the [“My Thai Star”](https://github.com/devonfw/my-thai-star) application as a reference project for using a brought range of technologies in a large-scale context. Parts of that application where recreated using Flutter for this thesis.

## Purpose
1. The thesis itself outlines the creation process of this repository, which design decisions where made and why. The thesis is not yet published, but it will be linked as soon as it is.
2. This repository is a fully documented, large-scale Flutter application. I did my best to document the reasons behind the design decisions in-code as well, so you can already check that out if you want.

## Previous Related Work
- A [guide](https://github.com/devonfw-forge/devonfw4flutter) on developing large-scale applications using Flutter.
- A [small-scale application](https://github.com/Fasust/wisgen) to test some of the recommendations made by the guide.

## Covered Topics
- Comparing State-Management Solutions
- The BLoC Pattern
  - Recommendations for Designing BLoCs 
- Layered Architecture
- The Repository Pattern
- Object Equality in Dart
- The Advantages of Immutability
- Dependency Injection
- Service Locators
- Project Structure
- Modularzitation
- Localization
- Form Validation

## Architecture
![Architecture Image](https://github.com/Fasust/my-thai-star-flutter/blob/master/.additional_material/graphics/mts-architecture-dependencies-v5.png)

## Screens
### Original Angular
![Angular](https://github.com/Fasust/my-thai-star-flutter/blob/master/.additional_material/graphics/mts-screens.png)

### New Flutter
![Flutter](https://github.com/Fasust/my-thai-star-flutter/blob/master/.additional_material/graphics/mts-flutter-screens.png)


## Set-Up _(With hosted Back-End)_
This option will only be available for a limited amount of time. I am currently hosting a Back-End of the My Thai Star application under `http://138.197.218.225:8082/`, but I will have to take it down in march 2020. Until I take it down however, this is an easy way to use all the feature of the My Thai Star Flutter application without needing to host a Back-End yourself.

#### You will need
- Flutter 
- Git
- Android Virtual Device (AVD) 

#### Step 1
Clone this repository.
```
git clone https://github.com/Fasust/my_thai_star_flutter.git
```
#### Step 2
Make sure the `lib/configuration.dart` looks like this:

```dart
///Provides a set of constant values that are used for configuration
@immutable
class Configuration {
  static final String baseUrl = "http://138.197.218.225:8082/";
  static final bool useMockData = false;
}
```

#### Step 3
Run the Flutter My Thai Star Application in your AVD.

## Set-Up _(Test)_
The easiest way to set-up the application. It will only have a limited set of features and use local mock data. A good option if you only wanna check out the code.

#### You will need
- Flutter 
- Git
- Android Virtual Device (AVD) 

#### Step 1
Clone this repository.
```
git clone https://github.com/Fasust/my_thai_star_flutter.git
```

#### Step 2
Make sure the `lib/configuration.dart` looks like this:

```dart
///Provides a set of constant values that are used for configuration
@immutable
class Configuration {
  static final String baseUrl = "http://10.0.2.2:8082/"; //Can be anything as it wont be used when mock is true.
  static final bool useMockData = true;
}
```

#### Step 3
Run the Flutter My Thai Star Application in your AVD.

## Set-Up _(With own Back-End)_
This repository is only a Front-End component for the existing My Thai Star application. Thus you will need to host a My Thai Star Back-End component for the application to fully work. This set-up is the most tedious, but it will enable you to use every feature of the My Thai Star Flutter application.

![Flutter](https://github.com/Fasust/my-thai-star-flutter/blob/master/.additional_material/graphics/mts-flutter-components.PNG)

#### You will need
- Flutter 
- Git
- Android Virtual Device (AVD) 
- Docker

#### Step 1
Clone this repository.
```
git clone https://github.com/Fasust/my_thai_star_flutter.git
```

#### Step 2
Get a My Thai Star Back-End. The easiest way is to clone [this fork I made](https://github.com/Fasust/my-thai-star/tree/master) where I already exposed the Back-End ports.

```
git clone https://github.com/Fasust/my-thai-star.git
```

#### Step 3
In the My Thai Star project cloned in step 2, run the following command in the root of the directory. Be sure you are on the master branch of the repository.

```
docker-compose up
```

This will boot up the whole My Thai Star application with exposed ports on the Back-End. You can verify if is running by going to `http://127.0.0.1:8081/restaurant` in your browser. You should see the My Thai Star Angular Front-End.

#### Step 4
Make sure the `lib/configuration.dart` looks like this:

```dart
///Provides a set of constant values that are used for configuration
@immutable
class Configuration {
  static final String baseUrl = "http://10.0.2.2:8082/";
  static final bool useMockData = false;
}
```

#### Step 5 
Run the Flutter My Thai Star Application in your AVD. It should now be able to communicate with the Back-End in the docker container.

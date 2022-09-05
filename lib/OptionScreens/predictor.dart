import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';
import 'package:flutter_final/loadingScreen.dart';
import 'package:flutter_final/vehicle.dart';
import 'package:http/http.dart' as http;

import '../result.dart';

class DropDown extends StatefulWidget {
  User user;

  DropDown({Key? key, required this.user}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState(user: user);
}

class _DropDownState extends State<DropDown> {
  User user;

  _DropDownState({required this.user});

  Vehicle vehicle = new Vehicle.empty();
  bool loading = false;
  String finalResponse = '';
  String engineCapacity = '';
  String mileage = '';
  String grade = '';
  TextEditingController model = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? select_transmission;
  List<String> transmission_type = ["Automatic", "Manual"];
  String? select_year;
  List<String> year = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020'
  ];
  String? selectFuel;
  List<String> fuelType = ['Petrol', 'Diesel', 'Hybrid'];
  String? vehicleModel;
  List<String> models = [
    'Vitz',
    'Corolla',
    'Land Cruiser Prado',
    'Toyota Aqua',
    'Axio',
    'Premio',
    'Prius',
    'Allion',
    'Hilux',
    'Land Cruiser Sahara',
    'Avanza',
    'Fortuner',
    'Yaris',
    'Passo',
    'Roomy',
    'Tank',
    'Wigo',
    'Pixis',
    'Noah',
    'Belta',
    'Sprinter',
    'Vios',
    'Camry',
    'Cynos',
    'Avensis'
  ];

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: kButtonColor,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Option(user: user),
            ));
          },
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Predictor",
          style: TextStyle(color: kButtonColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                    child: Image(
                        image:
                        AssetImage('assets/images/car_dealer.jpg'))),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Model',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kButtonColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonFormField<String>(
                    // itemHeight: 20,
                    hint: Text(
                      'Eg: Vitz',
                    ),
                    value: vehicleModel,
                    validator: (value) => value == null ? '*' : null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        errorMaxLines: 1,
                        errorStyle: TextStyle(fontSize: 20, height: 0),
                        errorBorder: new OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: kButtonColor,
                    ),
                    iconSize: 36,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    isExpanded: true,
                    onSaved: (value) {
                      vehicle.model = value!;
                      // vehicleModel=value;
                    },
                    onChanged: (value) {
                      setState(() {
                        vehicleModel = value!;
                        print(vehicleModel);
                      });
                    },
                    items: models.map((valueItem) {
                      return DropdownMenuItem<String>(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Manufacture Year',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kButtonColor, width: 2),
                  ),
                  child: DropdownButtonFormField(
                    hint: Text('Eg: 2014'),
                    value: select_year,
                    validator: (value) => value == null ? '*' : null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        errorMaxLines: 1,
                        errorStyle: TextStyle(fontSize: 20, height: 0),
                        errorBorder: new OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    icon: Icon(Icons.arrow_drop_down_outlined,
                        color: kButtonColor),
                    iconSize: 36,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    isExpanded: true,
                    onSaved: (value) {
                      vehicle.manufactureYear = value as String;
                      // select_year=value;
                    },
                    onChanged: (value) {
                      setState(() {
                        select_year = value as String;
                      });
                    },
                    items: year.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Engine Capacity',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kButtonColor, width: 2),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 48,
                        child: Container(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Engine Capacity';
                              }
                              String pattern = '[0-9]+';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Invalid Engine Capacity';
                              else
                                return null;
                            },
                            autofocus: true,
                            onSaved: (value) {
                              vehicle.engineCapacity = value!;
                              // engineCapacity=value;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'Eg: 1300(in cc)',
                                hintStyle: TextStyle(fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mileage',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kButtonColor, width: 2),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 48,
                        child: Container(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  RegExp(r'(^\d*\.?\d*)'),
                                  allow: true) //newly added allow
                            ],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Mileage of vehicle';
                              }
                              String pattern = '[0-9]+';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Mileage Invalid';
                              return null;
                            },
                            autofocus: true,
                            onSaved: (value) {
                              vehicle.mileage = value!;
                              // mileage=value;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'Eg: 10000(in km)',
                                hintStyle: TextStyle(fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Grade',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kButtonColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 1,
                            offset: Offset(0, 5))
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 48,
                        child: Container(
                          child: TextFormField(
                            autofocus: true,
                            onSaved: (value) {
                              vehicle.grade = value!;
                              // grade=value;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'Eg: Grade B',
                                hintStyle: TextStyle(fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Fuel Type',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kButtonColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 1,
                            offset: Offset(0, 5))
                      ]),
                  child: DropdownButtonFormField(
                    hint: Text(
                      'Eg: Petrol/Diesel,Hybrid',
                    ),
                    value: selectFuel,
                    validator: (value) => value == null ? '*' : null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      errorMaxLines: 1,
                      errorStyle: TextStyle(fontSize: 20, height: 0),
                      errorBorder: new OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: kButtonColor,
                    ),
                    iconSize: 36,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    isExpanded: true,
                    onSaved: (value) {
                      vehicle.fuelType = value as String;
                      // selectFuel=value;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectFuel = value as String;
                      });
                    },
                    items: fuelType.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Transmission Type',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 0, top: 10),
                  padding: EdgeInsets.only(left: 10, top: 1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kButtonColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 1,
                            offset: Offset(0, 5))
                      ]),
                  child: DropdownButtonFormField(
                    hint: Text(
                      'Eg: Automatic/ Manual',
                    ),
                    value: select_transmission,
                    validator: (value) => value == null ? '*' : null,
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: kButtonColor,
                    ),
                    iconSize: 36,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        errorMaxLines: 1,
                        errorStyle: TextStyle(fontSize: 20, height: 0),
                        errorBorder: new OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    isExpanded: true,
                    onSaved: (value) {
                      vehicle.transmissionType = value as String;
                      // select_transmission=value;
                    },
                    onChanged: (value) {
                      setState(() {
                        select_transmission = value as String;
                      });
                    },
                    items: transmission_type.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                new SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          formKey.currentState!.save();
                          // final sendResponse = await http.post(
                          //     Uri.parse(
                          //         'https://automovehicle.herokuapp.com/predict'),
                          //     body: json.encode({
                          //       'model': vehicle.model,
                          //       'year': vehicle.manufactureYear,
                          //       'engine capacity': vehicle.engineCapacity,
                          //       'mileage': vehicle.mileage,
                          //       'grade': vehicle.grade,
                          //       'fuel type': vehicle.fuelType,
                          //       'transmission type':
                          //           vehicle.transmissionType
                          //     }));
                          //
                          // final decoded = json
                          //     .decode(
                          //         sendResponse.body) as Map<String,
                          //     dynamic>; //converting it from json to key value pair
                          // finalResponse = decoded[
                          //     'response'];
                          //
                          // changing the state of our widget on data update

                          var headers = {
                            'Content-Type': 'application/json'
                          };

                          var request = http.Request(
                              'POST',
                              Uri.parse(
                                  'https://automovehicle.herokuapp.com/predict'));
                          request.body = json.encode({
                            'model': vehicle.model,
                            'year': vehicle.manufactureYear,
                            'engine capacity': vehicle.engineCapacity,
                            'mileage': vehicle.mileage,
                            'grade': vehicle.grade,
                            'fuel type': vehicle.fuelType,
                            'transmission type': vehicle.transmissionType
                          });
                          request.headers.addAll(headers);

                          http.StreamedResponse response =
                          await request.send();

                          if (response.statusCode == 200) {
                            finalResponse =
                            await response.stream.bytesToString();
                            //print(await response.stream.bytesToString());
                            // finalResponse=await response.stream.bytesToString();

                            print(finalResponse);

                            final decoded = json
                                .decode(
                                finalResponse) as Map<String,
                                dynamic>; //converting it from json to key value pair
                            finalResponse = decoded['response'];

                            // print(finalResponse+"hello");

                          } else {
                            print("hi");
                            print(response.reasonPhrase);
                          }

                          // print(finalResponse);
                          final sendResponse2 = await http.post(
                              Uri.parse(
                                  'https://automovehicle.herokuapp.com/graph'),
                              body: json.encode({
                                'model': vehicle.model,
                                'email': user.email
                              }));

                          final decoded2 = json
                              .decode(
                              sendResponse2.body) as Map<String,
                              dynamic>; //converting it from json to key value pair
                          String url = decoded2[
                          'response']; //changing the state of our widget on data update
                          print(url);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResultPage(
                                finalResponse: finalResponse,
                                user: user,
                                url: url),
                          ));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kButtonColor),
                        overlayColor:
                        MaterialStateProperty.all(Colors.blueGrey),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder()),
                      ),
                      child: new Text(
                        'Predict',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
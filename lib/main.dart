import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Colors.brown),
    home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //custom radio var
  int currentindex = 0;
  String statusA = "";
  String hasil = "";
  double height = 0;
  double weight = 0;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 8, 17, 59),
        appBar: AppBar(
          title: Text(
            "BMI Kalkulator",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          backgroundColor: Color.fromARGB(86, 140, 143, 165),
          actions: [
            IconButton(
              onPressed: (() => SystemNavigator.pop()),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // buat body
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Pria", Colors.blue, 0),
                  radioButton("Wanita", Colors.pink, 1),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              //inputform
              Text(
                "Tinggi badan dalam Cm :",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: heightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Tinggi badan dalam Cm",
                  filled: true,
                  fillColor: Color.fromARGB(86, 140, 143, 165),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              Text(
                "Berat badan dalam Kg :",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: weightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Berat badan dalam Kg",
                  filled: true,
                  fillColor: Color.fromARGB(86, 140, 143, 165),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      height = double.parse(heightController.value.text);
                      weight = double.parse(weightController.value.text);
                    });

                    hitungBmi(height, weight);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Hitung",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Hasil BMI :",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "$hasil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "$statusA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void hitungBmi(double height, double weight) {
    double finalhasil = weight / pow(height / 100, 2);
    String status = "";
    String bmi = finalhasil.toStringAsFixed(2);
    if (finalhasil >= 18.5 && finalhasil <= 22.9) {
      status = "Berat badan normal";
    } else if (finalhasil >= 23 && finalhasil <= 29.9) {
      status = "Berat badan berlebih";
    } else if (finalhasil <= 18.5) {
      status = "Berat badan kurang";
    } else {
      status = "Obesitas";
    }
    setState(() {
      hasil = bmi;
      statusA = status;
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  //custom widget
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: currentindex == index ? color : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
              color: currentindex == index ? Colors.white : color,
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

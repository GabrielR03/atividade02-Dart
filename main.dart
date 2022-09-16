import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main(){

  runApp(const MaterialApp(
    title: 'Counting the students',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Inform your data";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    _formKey = GlobalKey<FormState>();
    setState(() {
      _infoText = "Inform your data";
    });
  }

  void _calculate(){
    setState((){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      if(bmi < 18.5){
        _infoText = "You're underweight, eat more (BMI: ${bmi.toStringAsPrecision(4)})";
      }else if(bmi <= 24.9){
        _infoText = "You're normal, congratulations! (BMI: ${bmi.toStringAsPrecision(4)})";
      }else if(bmi <= 29.9){
        _infoText = "You're fat, eat less my dude (BMI: ${bmi.toStringAsPrecision(4)})";
      }else if(bmi <= 34.9){
        _infoText = "You have obesity grade 1, eat waaaay less (BMI: ${bmi.toStringAsPrecision(4)})";
      }else if(bmi <= 39.9){
        _infoText = "You have obesity grade 2, eat waaaaaaaaay less (BMI: ${bmi.toStringAsPrecision(4)})";
      }else{
        _infoText = "You have obesity grade 3, eating is your life style (BMI: ${bmi.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("BMI calculator"),
        centerTitle: true,
        backgroundColor: Colors.white12,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields,),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Image.asset("images/wallpaper.png",
          fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Icon(Icons.person, size: 120, color: Colors.green),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          labelText: "Weight (kg)",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white12,
                          filled: true,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.green, fontSize: 25.0),
                        controller: weightController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Inform your weight";
                          }else if(int.parse(value!) >= 500 || int.parse(value!) < 0){
                            return "Inform a valid weight!";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          labelText: "Height (cm)",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white12,
                          filled: true,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.green, fontSize: 25.0),
                        controller: heightController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Inform your height";
                          }else if(int.parse(value!) >= 300 || int.parse(value!) < 0){
                            return "Inform a valid height!";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 15,
                          shadowColor: Colors.greenAccent,
                        ),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _calculate();
                          }
                        },
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: const Text(
                        "INFO: ",
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: Text(
                        _infoText,
                        style: const TextStyle(color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

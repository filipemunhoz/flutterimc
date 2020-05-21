import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  String infoText = "Informe seus dados";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Widget buildTextField(String label, TextEditingController controller){
    return TextField(
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.green, fontSize: 20.0),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.green, fontSize: 25.0),
      keyboardType: TextInputType.number,
      controller: controller,
    );
  }

  void _calculate(){

    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    setState(() {
      if(imc < 17){
        infoText = "Muito abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 17 && imc <= 18.49){
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.5 && imc <= 24.99){
        infoText = "Peso ideal ou normal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 25 && imc <= 29.99){
        infoText = "Acima do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 30 && imc <= 34.99){
        infoText = "Obesidade I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 35 && imc <= 39.99){
        infoText = "Obesidade II (${imc.toStringAsPrecision(4)})";
      } else if(imc > 40){
        infoText = "Obesidade III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  void _resetFields(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      infoText = "Informe seus dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: (){
            _resetFields();
          },)

        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 170.0, color: Colors.green,),
            buildTextField("Peso", weightController),
            Divider(),
            buildTextField("Altura", heightController),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  child: Text("Verificar", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                  onPressed: (){
                    _calculate();
                  },
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(infoText, style: TextStyle(color: Colors.green, fontSize: 25.0),
              textAlign: TextAlign.center,),
            )

          ],
        ),
      ),
    );
  }
}
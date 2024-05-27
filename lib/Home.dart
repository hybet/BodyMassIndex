import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _resetFields()
  {
    weightController.text="";
    heightController.text="";
    setState((){
      _infoText="Renseignez Vos Données";
      _formkey=new GlobalKey<FormState>();
      _notZero=false;
    });
  }
  void _calculateImc()
  {
    setState(() {
      double weight = double.parse(weightController.text ) ;
      double height = double.parse(heightController.text ) ;
      _imc=weight/(height*height);
      _notZero= true;
      if (_imc <18.5){
        _infoText='YOU ARE TOO THIN';
        _textColor=Colors.purple.shade600;
      }else if (_imc>= 18.5 && _imc<25.9){
        _infoText='YOUR BMI IS PERFECT';
        _textColor=Colors.greenAccent.shade400;
      }else if (_imc>= 25.9 && _imc<29.9){
      _infoText='YOUR BMI IS A BIT HIGH';
      _textColor=Colors.deepOrange;
    }else if (_imc>= 29.9) {
        _infoText = 'YOU ARE OBEISE';
        _textColor=Colors.pinkAccent;
      }
    });
  }

  TextEditingController weightController=new TextEditingController();
  TextEditingController heightController=new TextEditingController();
  GlobalKey<FormState> _formkey= new GlobalKey <FormState>();
  String _infoText="Renseignez Vos Données";
  double _imc=0.0;
  Color _textColor= Colors.white;
  bool _notZero=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"),
      centerTitle: true,
      backgroundColor: Colors.cyan,
      actions: [
        IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
      ],),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding:  EdgeInsets.fromLTRB(16, 8, 8 , 0),
        child: Form(
          key: _formkey,
          child: Column(
          children: [
            Row(
              children: [
                Text("Weight",style: TextStyle(
                    color: Colors.cyan,fontSize:24
                ),),
                Expanded(child: Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 10, 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 1,
                            offset: Offset(1,3)
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: TextFormField(keyboardType: TextInputType.number,textAlign:TextAlign.right ,
                    controller: weightController,
                    validator: (value) {
                      if(value!.isEmpty)
                        {
                          return "TYPE YOUR WEIGHT";
                        }
                    },
                    decoration: InputDecoration(
                      hintText: "00.0",hintStyle: TextStyle(color: Colors.black26,fontSize: 20),
                      suffixIcon: Text("KG",style: TextStyle(fontSize: 16,color: Colors.cyan,
                          fontWeight: FontWeight.bold) , ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(style: BorderStyle.none,width: 0)
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),))
              ],
            ),
            Row(
              children: [
                Text("Height",style: TextStyle(
                    color: Colors.cyan,fontSize:24
                ),),
                Expanded(child: Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 10, 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        blurRadius: 1,
                        offset: Offset(1,3)
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: TextFormField(keyboardType: TextInputType.number,textAlign:TextAlign.right ,
                    controller: heightController,
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "TYPE YOUR HEIGHT";
                      }
                    },
                  decoration: InputDecoration(
                    hintText: "00.0",hintStyle: TextStyle(color: Colors.black26,fontSize: 20),
                    suffixIcon: Text("M",style: TextStyle(fontSize: 16,color: Colors.cyan,
                                     fontWeight: FontWeight.bold) , ),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50),
                   borderSide: BorderSide(style: BorderStyle.none,width: 0)
                 ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  ),))
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: ElevatedButton(onPressed: () {
                if(_formkey.currentState!.validate())
                  {
                    _calculateImc();
                  }
              }, child: Container(
                padding: EdgeInsets.all(10),
                child: Text("Calcul",style: TextStyle(fontSize:20),),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("YOU ARE",style: TextStyle(fontSize: 26,color: Colors.black26),),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(_infoText,style: TextStyle(fontSize: 18,color: _textColor),),
                ),
                if(_notZero)
                  SfRadialGauge(
                    axes: <RadialAxis> [
                      RadialAxis(
                        showLabels:false,minimum: 0,maximum: 40,
                        ranges: <GaugeRange> [
                          GaugeRange(startValue: 0, endValue: 18.5,color: Colors.purple.shade600,startWidth: 50,endWidth: 50),
                          GaugeRange(startValue:  18.5, endValue: 25.9,color: Colors.greenAccent.shade400,startWidth: 50,endWidth: 50),
                          GaugeRange(startValue: 25.9, endValue: 29.9,color: Colors.deepOrange,startWidth: 50,endWidth: 50),
                          GaugeRange(startValue: 29.9, endValue: 40,color: Colors.pinkAccent,startWidth: 50,endWidth: 50),
                        ],
                        pointers: [
                          MarkerPointer(value: _imc,markerType: MarkerType.triangle ,markerHeight:30 ,
                          markerOffset: 40,color: Colors.white,)
                        ],
                        annotations: [
                          GaugeAnnotation(axisValue:_imc,positionFactor: 0.05,widget:Text(_imc.toStringAsFixed(2),
                            style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),)
                        ],
                      )
                    ],
                  )

              ],
            )
          ],
        ),

        ),
      ),
    );
  }
}

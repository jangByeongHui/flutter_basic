import 'package:flutter/material.dart';
import 'package:fat_calculator/BmiResult.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose(){
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body:Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  print(value);
                  if(int.tryParse(value!)==null && value.trim().isEmpty){
                    return '키를 입력하세요';
                  }
                  return null;
                },
                controller: _heightController,//숫자만 입력 가능
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  print(value);
                  if(int.tryParse(value!)==null && value.trim().isEmpty){
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
                controller: _weightController,
              ),
              Container(
                margin: const EdgeInsets.only(top:16.0),
                alignment: Alignment.centerRight,
                child:ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState?.validate()==null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('키 몸무게 확인')));
                    }else
                    {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BmiResult(
                        double.parse(_heightController.text.trim()),
                        double.parse(_weightController.text.trim())
                      ))
                      );
                    }
                  },
                  child: Text('결과'),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


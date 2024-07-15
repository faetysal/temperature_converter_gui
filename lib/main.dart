import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

void main() {
  runApp(const TemperatureConverter());
}

class TemperatureConverter extends StatelessWidget {
  const TemperatureConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const Home()
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    const List scales = [
      { 'title': 'Celcius', 'value': 'c' },
      { 'title': 'Fahrenheit', 'value': 'f' },
      { 'title': 'Kelvin', 'value': 'k' },
    ];

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 64
                ),
                color: Colors.white,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text('TEMPERATURE CONVERTER', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal
                    )),
                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[200]!
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Input', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal
                          )),
                          const SizedBox(height: 16),
                          SizedBox(
                            child: TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[100]!)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[100]!)
                                )
                              ),
                            )
                          ),
                          const SizedBox(height: 8,),
                          Obx(() => SizedBox(
                            child: RadioButtonList(
                              value: controller.inputUnit.value,
                              onChanged: (String v) {
                                print('Value changed: $v');
                                controller.inputUnit.value = v;
                              },
                              children: scales.map((s) {
                                return RadioButton(
                                  label: s['title'],
                                  value: s['value']
                                );
                              }).toList(),
                            )
                          ))
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[200]!
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Output', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal
                          )),
                          const SizedBox(height: 16),
                          Obx(() => SizedBox(
                            child: RadioButtonList(
                              value: controller.outputUnit.value,
                              onChanged: (String v) {
                                print('Output unit changed: $v');
                                controller.outputUnit.value = v;
                              },
                              children: scales.map((s) => RadioButton(
                                label: s['title'],
                                value: s['value']
                              )).toList()
                            )
                          ))
                        ],
                      )
                    ),

                    const SizedBox(height: 100),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white
                        ),
                        onPressed: () {

                        }, 
                        child: Text('Convert')
                      )
                    )
                    
                  ],
                ),
              )
            ),
            Expanded(
              child: Container(
                color: Colors.teal,
                child: Center(
                  child: Text('0', style: TextStyle(
                    color: Colors.white,
                    fontSize: 140,
                    fontWeight: FontWeight.w600
                  )),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

class HomeController extends GetxController {
  RxString inputUnit = 'c'.obs;
  RxString outputUnit = 'f'.obs;
}

class RadioButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  RadioButton({super.key, this.label = '', required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<RadioButtonList>();

    return SizedBox(
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: parent!.value == value ? Colors.teal : Colors.grey[200],
          foregroundColor: parent.value == value ? Colors.white : Colors.black,
          shape: const RoundedRectangleBorder()
        ),
        onPressed: () {
          parent.onChanged(value);
        }, 
        child: Text(label)
      )
    );
  }
}

class RadioButtonList extends StatelessWidget {
  const RadioButtonList({
    super.key, 
    required this.value,
    required this.onChanged,
    this.children = const []
  });

  final String value;
  final void Function(String s) onChanged;
  final List children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children.map((c) => Expanded(child: c)).toList()
    );
  }
}

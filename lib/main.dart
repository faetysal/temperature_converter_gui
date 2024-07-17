import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'package:rinf/rinf.dart';
import './messages/generated.dart';
import 'messages/temperature.pb.dart';

void main() async {
  await initializeRust(assignRustSignal);
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

    List<TemperatureScale> scales = [
      TemperatureScale.celcius(),
      TemperatureScale.fahrenheit(),
      TemperatureScale.kelvin()
    ];

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                color: Colors.white,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text('TEMPERATURE CONVERTER', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: pryColor)
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Input', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: pryColor)
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            child: TextFormField(
                              onChanged: (v) {
                                controller.inputScale.value.value = double.tryParse(v);
                                if (v.isEmpty) {
                                  controller.outputScale.value.value = null;
                                  controller.outputScale.refresh();
                                } else {
                                  controller.convert();
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^-?(\d+(\.(\d+)?)?)?')
                                )
                              ],
                              decoration: InputDecoration(
                                hintText: 'Temperature',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[100]!)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[100]!)
                                )
                              ),
                            )
                          ),
                          const SizedBox(height: 8),
                          Obx(() => SizedBox(
                            child: RadioButtonList(
                              value: controller.inputScale.value.unit,
                              onChanged: (String v) {
                                final temp = TemperatureScale.fromSymbol(v);
                                temp.value = controller.inputScale.value.value;
                                controller.inputScale.value = temp;
                                print(
                                    'Input unit changed: ${controller.inputScale.value.unit}');
                                // controller.inputScale.refresh();

                                if (controller.inputScale.value.value != null) {
                                  controller.convert();
                                }
                              },
                              children: scales.map((s) {
                                return RadioButton(label: s.title, value: s.unit);
                              }).toList(),
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Output', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: pryColor
                          )),
                          const SizedBox(height: 16),
                          Obx(() => SizedBox(
                            child: RadioButtonList(
                              value: controller.outputScale.value.unit,
                              onChanged: (String v) {
                                controller.outputScale.value = TemperatureScale.fromSymbol(v);

                                if (controller.inputScale.value.value != null) {
                                  controller.convert();
                                }
                              },
                              children: scales.map((s) => RadioButton(
                                label: s.title, value: s.unit
                              )).toList()
                            )
                          ))
                        ],
                      )
                    )
                  ],
                ),
              )
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                color: pryColor,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: StreamBuilder(
                      stream: OutputTemperature.rustSignalStream,
                      builder: (context, snap) {
                        if (snap.hasData) {
                          final outputTemp = snap.data!.message;
                          controller.outputScale.value.value = double.parse(outputTemp.value);
                        }

                        return Obx(() => Text(controller.outputString, style: const TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                          fontWeight: FontWeight.w600
                        )));
                      },
                    )
                  )
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
  Rx<TemperatureScale> inputScale = TemperatureScale.celcius().obs;
  Rx<TemperatureScale> outputScale = TemperatureScale.fahrenheit().obs;

  String get outputString {
    if (outputScale.value.value == null) {
      return '-';
    }

    final outputValue = outputScale.value.value!;

    final isZero = outputValue.truncateToDouble() == outputValue;
    final output = outputValue.toStringAsFixed(isZero ? 0 : 2);
    return "$output${outputScale.value.unit}";
  }

  void convert() {
    InputTemperature(
      value: inputScale.value.value,
      inputUnit: inputScale.value.character,
      outputUnit: outputScale.value.character
    ).sendSignalToRust();
  }
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
          backgroundColor: parent!.value == value ? pryColor : Colors.grey[200],
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
  const RadioButtonList({super.key,
    required this.value,
    required this.onChanged,
    this.children = const []
  });

  final String value;
  final void Function(String s) onChanged;
  final List children;

  @override
  Widget build(BuildContext context) {
    return Row(children: children.map((c) => Expanded(child: c)).toList());
  }
}

class TemperatureScale {
  String title;
  double? value;
  String unit;
  String character;

  TemperatureScale({this.title = '', this.value, this.unit = '', this.character = ''});

  factory TemperatureScale.celcius() {
    return TemperatureScale(title: 'Celcius', unit: '°C', character: 'c');
  }

  factory TemperatureScale.fahrenheit() {
    return TemperatureScale(title: 'Fahrenheit', unit: '°F', character: 'f');
  }

  factory TemperatureScale.kelvin() {
    return TemperatureScale(title: 'Kelvin', unit: 'K', character: 'k');
  }

  factory TemperatureScale.fromSymbol(String symbol) {
    switch (symbol) {
      case '°F':
        return TemperatureScale.fahrenheit();
      case 'K':
        return TemperatureScale.kelvin();
      default:
        return TemperatureScale.celcius();
    }
  }
}

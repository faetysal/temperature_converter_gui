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
                          const SizedBox(
                            child: CustomRadioButtonList(id: 0)
                          )
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Output', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal
                          )),
                          SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            child: CustomRadioButtonList(id: 1)
                          )
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

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({super.key, this.label = '', this.selected = false, this.onTap});

  final String label;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: selected ? Colors.teal : Colors.grey[200],
          foregroundColor: selected ? Colors.white : Colors.black,

          shape: const RoundedRectangleBorder()
        ),
        onPressed: onTap, 
        child: Text(label)
      )
    );
  }
}

class CustomRadioButtonList extends StatelessWidget {
  const CustomRadioButtonList({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    CustomRadioButtonListController controller = Get.put(CustomRadioButtonListController(), tag: id?.toString());

    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: CustomRadioButton(
              selected: controller.index.value == 0,
              label: 'Celcius',
              onTap: () => controller.index.value = 0,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomRadioButton(
              selected: controller.index.value == 1,
              label: 'Fahrenheit',
              onTap: () => controller.index.value = 1,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomRadioButton(
              selected: controller.index.value == 2,
              label: 'Kelvin',
              onTap: () => controller.index.value = 2,
            ),
          ),
        ],
      );
    });
  }
}

class CustomRadioButtonListController extends GetxController {
  RxInt index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("Initing...");
  }
}

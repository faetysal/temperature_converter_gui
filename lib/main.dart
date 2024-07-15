import 'package:flutter/material.dart';

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
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TEMPERATURE CONVERTER'),
                    const SizedBox(height: 16),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        )
                      ),
                    ),

                    const SizedBox(height: 100),

                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        )
                      ),
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
                  child: Text('0'),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

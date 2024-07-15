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
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(color: Colors.grey[200],),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(color: Colors.grey[200],),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(color: Colors.grey[200],),
                                ),
                              ],
                            )
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Output', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal
                          )),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(color: Colors.grey[200],),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(color: Colors.grey[200],),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(color: Colors.grey[200],),
                                ),
                              ],
                            )
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

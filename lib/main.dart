import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz/question_page.dart';

import 'package:flutter/material.dart';
import 'package:quiz/model/quizz_category.dart';
import 'package:quiz/model/quizz_ques_ans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  Future<List<QuizzCategory>> fetchQuizzCategory() async {
    final response = await http.get(Uri.parse('https://mocki.io/v1/0aabaf70-8706-4f0f-bf15-87cea5ebbc88'));
    if (response.statusCode == 200) {
      final List body =jsonDecode(response.body);
      print(response.body);

      return body.map((e) =>  QuizzCategory.fromJson(e)).toList();
    }else {
      throw Exception("non");
    }
  }

  Future<List<QuizzQues>> fetchQuizzQues() async {
    final categories = await fetchQuizzCategory();
    List<QuizzQues> allques = [];

    for (var category in categories){
      allques.addAll(category.questions!);
    }
    return allques;
  }

  late Future<List<QuizzCategory>> futureQuizzCategory;
  late Future<List<QuizzQues>> futureQuizzQues;

  @override
  void initState() {
    super.initState();
    futureQuizzCategory = fetchQuizzCategory();
    futureQuizzQues = fetchQuizzQues();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('Quizz'),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text('Choississez un Quizz'),
            ),

            FutureBuilder <List<QuizzCategory>>(
                future: futureQuizzCategory,
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context,int index) {
                        QuizzCategory quizz = snapshot.data[index];
                        return
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizPage( quizCategory: snapshot.data[index].questions,)));

                          },
                          child:  Card(
                                child :   ListTile(
                                  title: Text(quizz.category!),
                                )
                            )
                        );
                         

                        }
                    );
                  }else {return Text(snapshot.error.toString());}
            }
            )

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

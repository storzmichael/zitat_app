import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String? _quote;
  String? _author;
  String? category = 'inspiration';
  List<String> categories = [
    "inspiration",
    "love",
    "success",
    "happiness",
    "age",
    "alone",
    "amazing",
    "anger",
    "architecture",
    "art",
    "attitude",
    "beauty",
    "best",
    "birthday",
    "business",
    "car",
    "change",
    "communication",
    "computers",
    "cool",
    "courage",
    "dad",
    "dating",
    "death",
    "design",
    "dreams",
    "education",
    "environmental",
    "equality",
    "experience",
    "failure",
    "faith",
    "family",
    "famous",
    "fear",
    "fitness",
    "food",
    "forgiveness",
    "freedom",
    "friendship",
    "funny",
    "future",
    "god",
    "good",
    "government",
    "graduation",
    "great",
    "happiness",
    "health",
    "history",
    "home",
    "hope",
    "humor",
    "imagination",
    "inspirational",
    "intelligence",
    "jealousy",
    "knowledge",
    "leadership",
    "learning",
    "legal",
    "life",
    "love",
    "marriage",
    "medical",
    "men",
    "mom",
    "money",
    "morning",
    "movies",
    "success"
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchQuote() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/quotes?X-API-Key=FXLpreaTuqym7qNXPrVJ5MjrbHewF7sCWZXmhFdJ'),
      headers: {'X-Api-Key': 'FXLpreaTuqym7qNXPrVJ5MjrbHewF7sCWZXmhFdJ'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          _quote = data[0]['quote'];
          _author = data[0]['author'];
        });
      } else {
        setState(() {
          _quote = 'Kein Zitat gefunden';
          _author = '';
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zufälliges Zitat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              if (categories.isNotEmpty)
                DropdownButton<String>(
                    items: categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: category,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onChanged: (String? value) {
                      setState(() {
                        category = value;
                      });
                    }),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: fetchQuote,
                child: const Text('Zufälliges Zitat'),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        const Text('Zitat:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          _quote ?? '',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Autor:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(
                          _author ?? '',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clay Doll Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String? _imagePath;
  bool _isLoading = false;
  String? _userId;
  String? _sessionId;

  @override
  void initState() {
    super.initState();
  }

  void _generateIds() {
    final random = Random();
    _userId = 'u_${random.nextInt(10000)}';
    _sessionId = 's_${random.nextInt(10000)}';
  }

  Future<void> _createSession() async {
    _generateIds();

    final url = Uri.parse(
      'http://127.0.0.1:8000/apps/clay_doll_generator/users/$_userId/sessions/$_sessionId',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'key1': 'value1', 'key2': 42}),
      );

      if (response.statusCode == 200) {
        print('Session created successfully');
      } else {
        print('Failed to create session: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating session: $e');
    }
  }

  Future<void> _generateImage() async {
    if (_controller.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _createSession();

      final url = Uri.parse('http://127.0.0.1:8000/run');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'appName': 'clay_doll_generator',
          'userId': _userId,
          'sessionId': _sessionId,
          'newMessage': {
            'role': 'user',
            'parts': [
              {'text': _controller.text},
            ],
          },
        }),
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = json.decode(response.body);
        print(response.body);
        final base64Image =
            data[0]["content"]["parts"][1]["inlineData"]["data"];
        final imageBytes = base64Decode(base64Image);

        final tempDir = await getTemporaryDirectory();
        print('temp dir = ${tempDir}');
        final file = await File('${tempDir.path}/generated_image.png').create();
        await file.writeAsBytes(imageBytes);

        print('image path = ${file.path}');

        setState(() {
          _imagePath = file.path;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image generated successfully!')),
        );
      } else {
        String errorMessage =
            'Failed to generate image: ${response.statusCode}';
        print(errorMessage);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      String errorMessage = 'Error generating image: $e';
      print(errorMessage);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clay Doll Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateImage,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Generate Image'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _imagePath != null
                  ? Image.file(File(_imagePath!))
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text('Image will appear here'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

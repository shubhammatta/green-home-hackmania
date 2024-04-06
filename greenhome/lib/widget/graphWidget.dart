import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GraphWidget extends StatefulWidget {
  final int userId;

  const GraphWidget({super.key, required this.userId});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  String? _graphData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGraphData();
  }

  Future<void> _fetchGraphData() async {
    try {
      final headers = {
        'Content-Type': 'application/json'
      };
      final body = jsonEncode({'user_id': widget.userId});

      final response = await http.post(
        Uri.parse('https://python-hello-world-three-wine.vercel.app/api/graph'),
        headers: headers,
        body: body
      );
      print('Reached Here');
      if (response.statusCode == 200) {
        setState(() {
          dynamic data = jsonDecode(response.body);
          _graphData = data['graph'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Error fetching graph data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching graph data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actual vs Predicted Daily Spending'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _graphData != null
                ? Image.memory(
                    base64Decode(_graphData!),
                    fit: BoxFit.contain,
                  )
                : Text('Error loading graph'),
      ),
    );
  }
}
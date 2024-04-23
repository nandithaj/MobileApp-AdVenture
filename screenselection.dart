import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ScreenSelectionPage extends StatefulWidget {
  const ScreenSelectionPage({Key? key}) : super(key: key);

  @override
  _ScreenSelectionPageState createState() => _ScreenSelectionPageState();
}

class _ScreenSelectionPageState extends State<ScreenSelectionPage> {
  List<String> screenNames = [];
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    fetchScreenNames();
  }

  Future<void> fetchScreenNames() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.29.169:5000/screens?owner_id=1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          screenNames = List<String>.from(data['screen_names']);
          isCheckedList = List<bool>.filled(screenNames.length, false);
        });
      } else {
        // Handle error
        print('Failed to fetch screen names: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Error fetching screen names: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen select'),
      ),
      body: ListView.builder(
        itemCount: screenNames.length,
        itemBuilder: (context, index) {
          final screenName = screenNames[index];
          return CheckboxListTile(
            title: Text(screenName),
            value: isCheckedList[index],
            onChanged: (value) {
              setState(() {
                isCheckedList[index] = value ?? false;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
 onPressed: () {
  bool isAnyChecked = false;
  for (int i = 0; i < isCheckedList.length; i++) {
    if (isCheckedList[i]) {
      isAnyChecked = true;
      break;
    }
  }
  if (isAnyChecked) {
    Navigator.pushNamed(context, '/adPlaying');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select at least one screen')),
    );
  }
},

  child: Icon(Icons.add),
  tooltip: 'Play Ad', // Add a tooltip for the button
),
    );
  }
}

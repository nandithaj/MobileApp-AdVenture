import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import for HTTP requests

import 'dart:convert';
import 'package:provider/provider.dart';
import 'UserData.dart';
class AdPlayingPage extends StatefulWidget {
  @override
  _AdPlayingPageState createState() => _AdPlayingPageState();
}

class _AdPlayingPageState extends State<AdPlayingPage> {
  String adContent = '';
  String imageUrl = ''; // Initialize image URL to empty string

  Future<void> _retrieveAdContent() async {
    try {
      final url = Uri.parse('http://192.168.29.169:5000/ads/ad_content/4'); // Replace with your API endpoint URL
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == null) {
          setState(() {
            adContent = data['ad_content'] ?? ''; // Set adContent (handle missing key gracefully)
            imageUrl = data['image_url'] ?? '';   // Set imageUrl (handle missing key gracefully)
          });
        } else {
          // Handle API error
          print('API error: ${data['error']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to retrieve ad content'),
            ),
          );
        }
      } else {
        // Handle general network or server error
        print('Error retrieving ad content: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error retrieving ad content'),
          ),
        );
      }
    } catch (error) {
      // Handle other potential errors
      print('Error retrieving ad content: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error retrieving ad content'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Playing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Text('This is the ad playing page.'),
            if (adContent.isNotEmpty && imageUrl.isNotEmpty)
              // Only show content if both adContent and imageUrl are available
              Column(
                children: [
                  Text(
                    adContent,
                    style: TextStyle(fontWeight: FontWeight.bold), // Optional styling
                  ),
                  SizedBox(height: 10), // Add some spacing between text and image
                  imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          errorBuilder: (context, error, stackTrace) =>
                              Text('Error loading image'),
                        )
                      : Text('No image available'), // Handle case where image URL is empty
                ],
              ),
            ElevatedButton(
              onPressed: _retrieveAdContent,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}


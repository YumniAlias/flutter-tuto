import 'package:flutter/material.dart';
import 'package:flutter_tut/data/classes/activity_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  late Future<Activity> futureActivity;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    futureActivity = fetchActivity();
  }

  Future<Activity> fetchActivity() async {
    final response = await http.get(
      Uri.parse('https://bored-api.appbrewery.com/random'),
    );

    if (response.statusCode == 200) {
      return Activity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Viewer'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFirst = !isFirst;
              });
            },
            icon: Icon(Icons.switch_access_shortcut),
          ),
        ],
      ),
      body: FutureBuilder<Activity>(
        future: futureActivity,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final activity = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedCrossFade(
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity: ${activity.activity}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Type: ${activity.type}'),
                    Text('Participants: ${activity.participants}'),
                    Text('Price: ${activity.price}'),
                    Text('Availability: ${activity.availability}'),
                    Text('Accessibility: ${activity.accessibility}'),
                    Text('Duration: ${activity.duration}'),
                    Text(
                      'Kid Friendly: ${activity.kidFriendly ? "Yes" : "No"}',
                    ),
                    Text('Link: ${activity.link}'),
                    Text('Key: ${activity.key}'),
                  ],
                ),
                secondChild: Center(
                  child: Image.asset('assets/images/appLogo.png'),
                ),
                crossFadeState: isFirst
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 1000),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            futureActivity = fetchActivity();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

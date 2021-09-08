import 'package:flutter/material.dart';
import 'package:time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'Dhaka', flag: 'bangladesh.png', url: 'Asia/Dhaka'),
    WorldTime(
        location: 'Kuala Lumpur',
        flag: 'malaysia.png',
        url: 'Asia/Kuala_Lumpur'),
    WorldTime(
        location: 'Sydney', flag: 'australia.png', url: 'Australia/Sydney'),
    WorldTime(location: 'Rome', flag: 'italy.png', url: 'Europe/Rome'),
    WorldTime(location: 'Paris', flag: 'france.png', url: 'Europe/Paris'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // navigate to home screen

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Choose Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('lib/assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';

class LocalNotify extends StatelessWidget {
  const LocalNotify({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text('Flutter Local Notification'),backgroundColor: Colors.yellow,),
      body: Center(child: Column(
        children: [
          //basic notification
          ListTile(
            onTap:(){
              LocalNotificationService.showBasicNotification();
            } ,
            leading: Icon(Icons.notification_add),
            title: Text('Basic Notification'),
            trailing: IconButton(onPressed: (){
              LocalNotificationService.cancelNotification(0);
            }, icon: Icon(Icons.cancel),color: Colors.red,),
          ),
          //repeated notification 
           ListTile(
            onTap:(){
              LocalNotificationService.showRepeatedNotification();
            } ,
            leading: Icon(Icons.notification_add),
            title: Text('Repeated Notification'),
            trailing: IconButton(onPressed: (){ LocalNotificationService.cancelNotification(1);}, icon: Icon(Icons.cancel),color: Colors.red,),
          ),

          //shecdule notification

           ListTile(
            onTap:(){
              LocalNotificationService.showRepeatedNotification();
            } ,
            leading: Icon(Icons.notification_add),
            title: Text('Shedule  Notification'),
            trailing: IconButton(onPressed: (){ LocalNotificationService.cancelNotification(2);}, icon: Icon(Icons.cancel),color: Colors.red,),
          )
        ],
      )),
    );
  }
}
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  init() {}

  }
  void registerMyTask()async{
  
  }

  //init work manager service
  Future <void> init()async {
   await Workmanager().initialize(actionTask, isInDebugMode: true);
    //register mytask
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
  @pragma('vm:entry-point')
    void actionTask() {
    //showi our notification
    Workmanager().executeTask((taskName, inputData) {
      // LocalNotificationService.showBasicNotification();
      return Future.value(true);
    });
}
//show notifcation at 9pm
//excute f

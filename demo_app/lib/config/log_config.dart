import 'package:demo_app/utils/log.dart';
import 'package:logging/logging.dart';

void setupLogger() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  Log.init(Logger.root);
}

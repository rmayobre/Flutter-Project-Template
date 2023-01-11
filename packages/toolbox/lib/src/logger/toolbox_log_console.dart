import 'package:framework/console.dart';
import 'package:logger/logger.dart';

class ToolboxConsole implements LogConsole {

  ToolboxConsole() : logger = Logger();

  final Logger logger;

  @override
  void output(Log log) {
    switch(log.type) {
      case LogType.verbose:
        logger.v("${log.tag}: ${log.message}", log.exception, log.stack);
        break;
      case LogType.info:
        logger.i("${log.tag}: ${log.message}", log.exception, log.stack);
        break;
      case LogType.debug:
        logger.d("${log.tag}: ${log.message}", log.exception, log.stack);
        break;
      case LogType.warning:
        logger.w("${log.tag}: ${log.message}", log.exception, log.stack);
        break;
      case LogType.error:
        logger.e("${log.tag}: ${log.message}", log.exception, log.stack);
        break;
    }
  }

}
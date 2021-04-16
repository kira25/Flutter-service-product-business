import 'package:intl/intl.dart';

String getOrderTime(DateTime orderTime) {
  final dateTimeNow = int.parse(DateFormat('d').format(DateTime.now()));

  final dateOrder = int.parse(DateFormat('d').format(orderTime));

  if (dateTimeNow - dateOrder == 1) {
    return 'AYER';
  } else if (dateTimeNow - dateOrder > 1 || dateTimeNow - dateOrder < -1) {
    return '${DateFormat('d-MM').format(orderTime)}';
  } else if (dateTimeNow - dateOrder == 0) {
    return 'HOY';
  }else{
    return '';
  }
}

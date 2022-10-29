import 'package:adminappp/constants/productInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelperMethods{



 static String getDuration({required Product product}) {

    String text='';
    if (product.date == null) {
      print(product.date);
      text='none';
      return text;
    } else {
      DateTime date = product.date!.toDate();
      // Duration duration=date.difference(Timestamp.now().toDate()).abs();
      Duration duration = Timestamp.now().toDate().difference(date).abs();

      int min = duration.inMinutes;
      int hour = duration.inHours;
      int day = duration.inDays.abs();
      int month = (day / 30.abs()).round();

      if (day == 0 && hour == 0) {
        if (min == 0) {text = 'الآن';}
        else if (min == 1) {text = 'من دقيقه';}
        else if (min == 2) {text = 'من دقيقتان';}
        else if (2 < min && min < 11) {text = 'من' ' ${min} ' 'دقائق';}
        else if (10 < min && min < 60) {text = 'من' ' ${min} ' 'دقيقه';}
      }

      else if (day == 0 && hour != 0) {
        if (hour == 1) {text = 'من ساعه';}
        else if (hour == 2) {text = 'من ساعتين';}
        else if (hour > 2 && hour < 11) {text = 'من' ' ${hour} ' 'ساعات';}
        else if (hour > 10 && hour < 24) {text = 'من' ' ${hour} ' 'ساعه';}
      }

      else if (day != 0) {
        if (day == 1) {text = 'أمس';}
        else if (day == 2) {text = 'من يومين';}
        else if (day > 2 && day < 11) {text = 'من' ' ${day} ' 'أيام';}
        else if (day > 10 && day < 30) {text = 'من' ' ${day} ' 'يوم';}
        else if (day >= 30) {
          if (day >= 30 && day < 60) {text = 'من شهر واحد';}
          else if (day >= 60 && day < 250) {text = 'من' ' ${month} ' 'شهور';}
        }
      }
      else if (day >= 250) {text = '${product.date!.toDate().day}/${product.date!.toDate().month}/${product.date!.toDate().year}';}



      else {

        text = 'none';

      }
    }

    return text;
  }
}
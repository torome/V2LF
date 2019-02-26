import 'package:flutter/material.dart';
import 'package:flutter_app/utils/navigator_app_page.dart';

// url 判断、拼接

class UrlHelper {
  static bool canLaunchInApp(BuildContext context, String url) {
    if (url.contains("https://www.v2ex.com/t/")) {
      NavigatorInApp.toTopicDetails(context, int.parse(url.replaceAll("https://www.v2ex.com/t/", "")));
      return true;
    } else if (url.startsWith('/t/') && url.contains('#reply')) {
      // <a href="/t/484922#reply11">
      NavigatorInApp.toTopicDetails(context, int.parse(url.replaceFirst("/t/", "").split('#')[0]));
      return true;
    }

    return false;
  }
}

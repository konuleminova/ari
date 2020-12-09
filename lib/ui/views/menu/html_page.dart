import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: HtmlWidget(
        'which will always be at hand. We will not leave anyone hungry! And, of course, we do not stand still, being in constant search of new tastes and options for serving dishes. We hope that we will always be welcome guests in your home or office! <\ / P> \ r \ n <p> Best regards and love, <br> \ r \ nDelivery Group. <\ / P> \ r \ n " , "image": "https: \ / \ / bees.az \ / _ assets \ / images \ /delivery-h.jpg"}',
      ),
      height: SizeConfig().screenHeight,
    );
  }
}

class HtmlView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: HtmlWidget(
        '{"header":"404","content":"404 not found","image":"https:\/\/bees.az\/_assets\/images\/404.png"}',
      ),
      height: SizeConfig().screenHeight,
    );
  }
}

class HtmlView3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: HtmlWidget(
        '{"header":"404","content":"404 not found","image":"https:\/\/bees.az\/_assets\/images\/404.png"}',
      ),
      height: SizeConfig().screenHeight,
    );
  }
}

class HtmlView4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: HtmlWidget(
        '{"header":"Контакты","content":"\r\n                        <h2>OOO DELIVERY GROUP<\/h2>\r\n                        <p>Город Баку улица Сулейман Рустам 4<\/p>\r\n                        <p>Тел 012 441 44 78<\/p>\r\n                        <p>Факс 012 441 44 79<\/p>\r\n                        <p>Электронная почта: <a style=\"color: black\" href=\"mailto:info@deliverygroup.az\">info@deliverygroup.az<\/a> <\/p>","image":"https:\/\/bees.az"}',
      ),
      height: SizeConfig().screenHeight,
    );
  }
}

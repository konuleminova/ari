import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';

class PartnerItem extends StatelessWidget {
  final index;

  PartnerItem(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: SizeConfig().screenWidth / 2,
      padding: EdgeInsets.symmetric(horizontal: 4.toWidth),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                child: ClipRRect(
                    child: Image.network(
                        'https://bees.az/___entcpanel/uploads/d3271c371aae25d4f8c747912391ce93_206431.png',
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)))),
          ),
          Expanded(
            child: Container(
              child: index % 2 == 0
                  ? Image.asset('assets/images/green_clipper.png')
                  : Image.asset('assets/images/green_clipper_right.png'),
            ),
          )
        ],
      ),
    );
  }
}

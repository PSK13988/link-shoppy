import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget Function(BuildContext context, SizeConfig sizeConfig) builder;

  BaseWidget({this.builder});

  @override
  Widget build(BuildContext context) {
    // Create SizeConfig object and init it
    var sizeConfig = SizeConfig();
    sizeConfig.init(context);
    //print('init SizeConfig');
    return builder(context, sizeConfig);
  }
}

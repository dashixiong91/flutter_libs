import 'package:app_base/src/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum LoadingType{
  ring
}
class Loading {
  static LikeToastManager show(
      BuildContext context, {
        LoadingType type=LoadingType.ring,
        LikeToastPosition position = LikeToastPosition.CENTER,
      }) {
    LikeToastManager manager = LikeToastManager.getInstance('loading');
    Widget loading;
    switch (type){
      case LoadingType.ring:
        loading=SpinKitRing(
          color: Colors.white,
          lineWidth: 2,
        );
        break;
    }
    loading=SizedBox(
      width: 18.0,
      height: 18.0,
      child: loading,
    );
    manager.createView(
        context: context,
        child: loading,
        position: position,
        isEventOpaque: false);
    return manager;
  }
}

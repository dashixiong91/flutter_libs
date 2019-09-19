# app_base

A app base library contain some widget or utils.

## Getting Started

1. add dependencie for your app
```
dependencies:
  flutter:
    sdk: flutter
  app_base:
    git:
      url: https://github.com/xinfeng-tech/flutter_libs.git
      path: packages/app_base  
```

2. import widget
```
import 'package:app_base/widgets.dart';

// loading
final loading = Loading.show(context);
loading.dismiss();

// Toast
Toast.show('app_base is ok', context);

```

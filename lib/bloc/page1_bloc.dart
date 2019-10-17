import 'package:flutter_app/route/bloc_provider.dart';

class Page1Bloc implements BlocBase {
  @override
  BlocOption option;

  Page1Bloc(this.option);

  @override
  void dispose() {}
}

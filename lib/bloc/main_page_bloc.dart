import 'package:flutter_app/route/bloc_provider.dart';

class MainPageBloc implements BlocBase {
  @override
  BlocOption option;

  MainPageBloc(this.option);

  @override
  void dispose() {}
}

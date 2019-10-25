import 'package:flutter_app/route/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Page3Bloc implements BlocBase {
  BehaviorSubject<String> _heroTagSubject = BehaviorSubject();

  Stream<String> get heroTagStream => _heroTagSubject.stream;

  @override
  BlocOption option;

  Page3Bloc(this.option);

  @override
  void dispose() {}

  void setHeroTag(String heroTag) {
    _heroTagSubject.add(heroTag);
  }
}

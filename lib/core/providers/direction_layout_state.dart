import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectionLayoutState extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }
  bool toggle(){
    state = !state;
    return state;
  }
  
}
final directionLayoutProvider = NotifierProvider<DirectionLayoutState, bool>(() => DirectionLayoutState());
  


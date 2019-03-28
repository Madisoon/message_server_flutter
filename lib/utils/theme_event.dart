import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class ThemeEvent {
  int themeIndex = 0;

  ThemeEvent(this.themeIndex);
}

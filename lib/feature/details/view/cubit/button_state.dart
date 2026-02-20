abstract class ButtonState {}

class StartReadButtonState implements ButtonState{}

class ContinuteButtonState implements ButtonState{
  final int indexChapter;

  ContinuteButtonState({required this.indexChapter});
}
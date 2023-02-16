part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  const ColorEvent();

  @override
  List<Object> get props => [];
}

class ChangeColorEvent extends ColorEvent{
  final Color newColor;

  const ChangeColorEvent({
    required this.newColor
  });

  @override
  List<Object> get props => [newColor];
}

class ResetColorEvent extends ColorEvent{
}
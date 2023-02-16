part of 'color_bloc.dart';

class ColorState extends Equatable {
  final Color appColor;
  final bool isDefaultColor;

  const ColorState({required this.appColor, required this.isDefaultColor});
  
  @override
  List<Object> get props => [appColor, isDefaultColor];

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'appColor': appColor.value,
      'isDefaultColor': isDefaultColor,
    };
  }

  factory ColorState.fromMap(Map<String, dynamic> map) {
    return ColorState(
      appColor: Color(map['appColor'] as int),
      isDefaultColor: map['isDefaultColor'] as bool,
    );
  }

}

class ColorInitial extends ColorState {
  const ColorInitial({required super.appColor, required super.isDefaultColor});
}
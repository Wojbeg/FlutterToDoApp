import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends HydratedBloc<ColorEvent, ColorState> {
  
  final SwitchBloc switchBloc;
  
  ColorBloc({required this.switchBloc, required Color colorInitial}) : super(ColorInitial(appColor: colorInitial, isDefaultColor: true)) {

    on<ChangeColorEvent>((event, emit) {
      emit(ColorState(
        appColor: event.newColor,
        isDefaultColor: false,
      ));
    });

    on<ResetColorEvent>((event, emit) {
      var theme = switchBloc.state.switchValue 
        ? AppThemes.appThemeData[AppTheme.darkTheme] 
        : AppThemes.appThemeData[AppTheme.lightTheme];
      
      emit(ColorState(
        appColor: theme?.primaryColor ?? Colors.white,
        isDefaultColor: true
      ));
    });
  }

  @override
  ColorState? fromJson(Map<String, dynamic> json) {
    return ColorState.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(ColorState state) {
    return state.toMap();
  }
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mouse_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MouseSettings _$MouseSettingsFromJson(Map<String, dynamic> json) {
  return _MouseSettings.fromJson(json);
}

/// @nodoc
mixin _$MouseSettings {
  ReduceVibrationOptions get vibrationThreshold =>
      throw _privateConstructorUsedError;
  set vibrationThreshold(ReduceVibrationOptions value) =>
      throw _privateConstructorUsedError;
  DragStartDelayOptions get dragStartDelayMS =>
      throw _privateConstructorUsedError;
  set dragStartDelayMS(DragStartDelayOptions value) =>
      throw _privateConstructorUsedError;
  DoubleClickDelayOptions get doubleClickDelayMS =>
      throw _privateConstructorUsedError;
  set doubleClickDelayMS(DoubleClickDelayOptions value) =>
      throw _privateConstructorUsedError;
  bool get invertedPointerX => throw _privateConstructorUsedError;
  set invertedPointerX(bool value) => throw _privateConstructorUsedError;
  bool get invertedPointerY => throw _privateConstructorUsedError;
  set invertedPointerY(bool value) => throw _privateConstructorUsedError;
  bool get invertedScrollX => throw _privateConstructorUsedError;
  set invertedScrollX(bool value) => throw _privateConstructorUsedError;
  bool get invertedScrollY => throw _privateConstructorUsedError;
  set invertedScrollY(bool value) => throw _privateConstructorUsedError;
  int get sensitivity => throw _privateConstructorUsedError;
  set sensitivity(int value) => throw _privateConstructorUsedError;
  int get scrollSensitivity => throw _privateConstructorUsedError;
  set scrollSensitivity(int value) => throw _privateConstructorUsedError;
  bool get keepMovingAfterScroll => throw _privateConstructorUsedError;
  set keepMovingAfterScroll(bool value) => throw _privateConstructorUsedError;

  /// Serializes this MouseSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MouseSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MouseSettingsCopyWith<MouseSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MouseSettingsCopyWith<$Res> {
  factory $MouseSettingsCopyWith(
          MouseSettings value, $Res Function(MouseSettings) then) =
      _$MouseSettingsCopyWithImpl<$Res, MouseSettings>;
  @useResult
  $Res call(
      {ReduceVibrationOptions vibrationThreshold,
      DragStartDelayOptions dragStartDelayMS,
      DoubleClickDelayOptions doubleClickDelayMS,
      bool invertedPointerX,
      bool invertedPointerY,
      bool invertedScrollX,
      bool invertedScrollY,
      int sensitivity,
      int scrollSensitivity,
      bool keepMovingAfterScroll});
}

/// @nodoc
class _$MouseSettingsCopyWithImpl<$Res, $Val extends MouseSettings>
    implements $MouseSettingsCopyWith<$Res> {
  _$MouseSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MouseSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vibrationThreshold = null,
    Object? dragStartDelayMS = null,
    Object? doubleClickDelayMS = null,
    Object? invertedPointerX = null,
    Object? invertedPointerY = null,
    Object? invertedScrollX = null,
    Object? invertedScrollY = null,
    Object? sensitivity = null,
    Object? scrollSensitivity = null,
    Object? keepMovingAfterScroll = null,
  }) {
    return _then(_value.copyWith(
      vibrationThreshold: null == vibrationThreshold
          ? _value.vibrationThreshold
          : vibrationThreshold // ignore: cast_nullable_to_non_nullable
              as ReduceVibrationOptions,
      dragStartDelayMS: null == dragStartDelayMS
          ? _value.dragStartDelayMS
          : dragStartDelayMS // ignore: cast_nullable_to_non_nullable
              as DragStartDelayOptions,
      doubleClickDelayMS: null == doubleClickDelayMS
          ? _value.doubleClickDelayMS
          : doubleClickDelayMS // ignore: cast_nullable_to_non_nullable
              as DoubleClickDelayOptions,
      invertedPointerX: null == invertedPointerX
          ? _value.invertedPointerX
          : invertedPointerX // ignore: cast_nullable_to_non_nullable
              as bool,
      invertedPointerY: null == invertedPointerY
          ? _value.invertedPointerY
          : invertedPointerY // ignore: cast_nullable_to_non_nullable
              as bool,
      invertedScrollX: null == invertedScrollX
          ? _value.invertedScrollX
          : invertedScrollX // ignore: cast_nullable_to_non_nullable
              as bool,
      invertedScrollY: null == invertedScrollY
          ? _value.invertedScrollY
          : invertedScrollY // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as int,
      scrollSensitivity: null == scrollSensitivity
          ? _value.scrollSensitivity
          : scrollSensitivity // ignore: cast_nullable_to_non_nullable
              as int,
      keepMovingAfterScroll: null == keepMovingAfterScroll
          ? _value.keepMovingAfterScroll
          : keepMovingAfterScroll // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MouseSettingsImplCopyWith<$Res>
    implements $MouseSettingsCopyWith<$Res> {
  factory _$$MouseSettingsImplCopyWith(
          _$MouseSettingsImpl value, $Res Function(_$MouseSettingsImpl) then) =
      __$$MouseSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ReduceVibrationOptions vibrationThreshold,
      DragStartDelayOptions dragStartDelayMS,
      DoubleClickDelayOptions doubleClickDelayMS,
      bool invertedPointerX,
      bool invertedPointerY,
      bool invertedScrollX,
      bool invertedScrollY,
      int sensitivity,
      int scrollSensitivity,
      bool keepMovingAfterScroll});
}

/// @nodoc
class __$$MouseSettingsImplCopyWithImpl<$Res>
    extends _$MouseSettingsCopyWithImpl<$Res, _$MouseSettingsImpl>
    implements _$$MouseSettingsImplCopyWith<$Res> {
  __$$MouseSettingsImplCopyWithImpl(
      _$MouseSettingsImpl _value, $Res Function(_$MouseSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MouseSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vibrationThreshold = null,
    Object? dragStartDelayMS = null,
    Object? doubleClickDelayMS = null,
    Object? invertedPointerX = null,
    Object? invertedPointerY = null,
    Object? invertedScrollX = null,
    Object? invertedScrollY = null,
    Object? sensitivity = null,
    Object? scrollSensitivity = null,
    Object? keepMovingAfterScroll = null,
  }) {
    return _then(_$MouseSettingsImpl(
      vibrationThreshold: null == vibrationThreshold
          ? _value.vibrationThreshold
          : vibrationThreshold // ignore: cast_nullable_to_non_nullable
              as ReduceVibrationOptions,
      dragStartDelayMS: null == dragStartDelayMS
          ? _value.dragStartDelayMS
          : dragStartDelayMS // ignore: cast_nullable_to_non_nullable
              as DragStartDelayOptions,
      doubleClickDelayMS: null == doubleClickDelayMS
          ? _value.doubleClickDelayMS
          : doubleClickDelayMS // ignore: cast_nullable_to_non_nullable
              as DoubleClickDelayOptions,
      invertedPointerX: null == invertedPointerX
          ? _value.invertedPointerX
          : invertedPointerX // ignore: cast_nullable_to_non_nullable
              as bool,
      invertedPointerY: null == invertedPointerY
          ? _value.invertedPointerY
          : invertedPointerY // ignore: cast_nullable_to_non_nullable
              as bool,
      invertedScrollX: null == invertedScrollX
          ? _value.invertedScrollX
          : invertedScrollX // ignore: cast_nullable_to_non_nullable
              as bool,
      invertedScrollY: null == invertedScrollY
          ? _value.invertedScrollY
          : invertedScrollY // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as int,
      scrollSensitivity: null == scrollSensitivity
          ? _value.scrollSensitivity
          : scrollSensitivity // ignore: cast_nullable_to_non_nullable
              as int,
      keepMovingAfterScroll: null == keepMovingAfterScroll
          ? _value.keepMovingAfterScroll
          : keepMovingAfterScroll // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(createToJson: true)
class _$MouseSettingsImpl implements _MouseSettings {
  _$MouseSettingsImpl(
      {this.vibrationThreshold = ReduceVibrationOptions.standard,
      this.dragStartDelayMS = DragStartDelayOptions.standard,
      this.doubleClickDelayMS = DoubleClickDelayOptions.standard,
      this.invertedPointerX = false,
      this.invertedPointerY = false,
      this.invertedScrollX = false,
      this.invertedScrollY = false,
      this.sensitivity = 5,
      this.scrollSensitivity = 3,
      this.keepMovingAfterScroll = false});

  factory _$MouseSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MouseSettingsImplFromJson(json);

  @override
  @JsonKey()
  ReduceVibrationOptions vibrationThreshold;
  @override
  @JsonKey()
  DragStartDelayOptions dragStartDelayMS;
  @override
  @JsonKey()
  DoubleClickDelayOptions doubleClickDelayMS;
  @override
  @JsonKey()
  bool invertedPointerX;
  @override
  @JsonKey()
  bool invertedPointerY;
  @override
  @JsonKey()
  bool invertedScrollX;
  @override
  @JsonKey()
  bool invertedScrollY;
  @override
  @JsonKey()
  int sensitivity;
  @override
  @JsonKey()
  int scrollSensitivity;
  @override
  @JsonKey()
  bool keepMovingAfterScroll;

  @override
  String toString() {
    return 'MouseSettings(vibrationThreshold: $vibrationThreshold, dragStartDelayMS: $dragStartDelayMS, doubleClickDelayMS: $doubleClickDelayMS, invertedPointerX: $invertedPointerX, invertedPointerY: $invertedPointerY, invertedScrollX: $invertedScrollX, invertedScrollY: $invertedScrollY, sensitivity: $sensitivity, scrollSensitivity: $scrollSensitivity, keepMovingAfterScroll: $keepMovingAfterScroll)';
  }

  /// Create a copy of MouseSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MouseSettingsImplCopyWith<_$MouseSettingsImpl> get copyWith =>
      __$$MouseSettingsImplCopyWithImpl<_$MouseSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MouseSettingsImplToJson(
      this,
    );
  }
}

abstract class _MouseSettings implements MouseSettings {
  factory _MouseSettings(
      {ReduceVibrationOptions vibrationThreshold,
      DragStartDelayOptions dragStartDelayMS,
      DoubleClickDelayOptions doubleClickDelayMS,
      bool invertedPointerX,
      bool invertedPointerY,
      bool invertedScrollX,
      bool invertedScrollY,
      int sensitivity,
      int scrollSensitivity,
      bool keepMovingAfterScroll}) = _$MouseSettingsImpl;

  factory _MouseSettings.fromJson(Map<String, dynamic> json) =
      _$MouseSettingsImpl.fromJson;

  @override
  ReduceVibrationOptions get vibrationThreshold;
  set vibrationThreshold(ReduceVibrationOptions value);
  @override
  DragStartDelayOptions get dragStartDelayMS;
  set dragStartDelayMS(DragStartDelayOptions value);
  @override
  DoubleClickDelayOptions get doubleClickDelayMS;
  set doubleClickDelayMS(DoubleClickDelayOptions value);
  @override
  bool get invertedPointerX;
  set invertedPointerX(bool value);
  @override
  bool get invertedPointerY;
  set invertedPointerY(bool value);
  @override
  bool get invertedScrollX;
  set invertedScrollX(bool value);
  @override
  bool get invertedScrollY;
  set invertedScrollY(bool value);
  @override
  int get sensitivity;
  set sensitivity(int value);
  @override
  int get scrollSensitivity;
  set scrollSensitivity(int value);
  @override
  bool get keepMovingAfterScroll;
  set keepMovingAfterScroll(bool value);

  /// Create a copy of MouseSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MouseSettingsImplCopyWith<_$MouseSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

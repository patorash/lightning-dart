/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Checkbox (handles input + presentation)
 */
class LCheckbox extends LEditor with LFormElement {

  /// The input
  final InputElement input = new InputElement()
    ..type = "checkbox";

  /**
   * Checkbox
   * (note that if id is not unique, it does not work!)
   */
  LCheckbox(String name, {String idPrefix}) {
    createCheckbox(this);
    input.name = name;
    input.id = createId(idPrefix, name);
    _initEditor();
  }

  /**
   * Checkbox Editor
   */
  LCheckbox.from(DColumn column, {String idPrefix, String type}) {
    createCheckbox(this);
    input.name = column.name;
    input.id = createId(idPrefix, name);
    //
    this.column = column; // base values
    _initEditor();
  } // LInput

  /// Initialize Editor
  void _initEditor() {
    input.onClick.listen(onInputChange);
  }

  void updateId(String idPrefix) {
    id = createId(idPrefix, name);
  }

  String get name => input.name;
  String get type => input.type;


  /// String Value

  String get value {
    return input.checked.toString();
  }
  void set value (String newValue) {
    input.checked = newValue == "true";
  }

  String get defaultValue => input.defaultValue;
  void set defaultValue (String newValue) {
    input.defaultValue = newValue;
  }


  /// base editor methods

  bool get readOnly => input.readOnly;
  void set readOnly (bool newValue) {
    input.readOnly = newValue;
  }

  bool get disabled => input.disabled;
  void set disabled (bool newValue) {
    input.disabled = newValue;
  }

  @override
  void set required (bool newValue) {
    // super.required = newValue; // UI - LFormElement
    _required = newValue; // don't make input required (= checked)
  }

  bool get spellcheck => input.spellcheck;
  void set spellcheck (bool newValue) { // ignore
  }

  bool get autofocus => input.autofocus;
  void set autofocus (bool newValue) {
    input.autofocus = newValue;
  }

  /// Validation

  int get maxlength => input.maxLength;
  void set maxlength (int newValue) { // ignore
  }

  String get pattern => input.pattern;
  void set pattern (String newValue) { // ignore
  }

  /// Validation state from Input
  ValidityState get inputValidationState => input.validity;
  /// Validation Message from Input
  String get inputValidationMsg => input.validationMessage;

  /// Display

  String get placeholder => input.placeholder;
  void set placeholder (String newValue) { // ignore
  }

} // LCheckbox
/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Form with FormElements
 */
class LForm extends LComponent {

  /// slds-form-element - Initializes form element | Required
  static const String C_FORM_ELEMENT = "slds-form-element";
  /// slds-form-element__label - Initializes form element label | Required
  static const String C_FORM_ELEMENT__LABEL = "slds-form-element__label";
  /// slds-form-element__control - Initializes form element control | Required
  static const String C_FORM_ELEMENT__CONTROL = "slds-form-element__control";
  /// slds-input - Initializes text input | Required
  static const String C_INPUT = "slds-input";
  /// slds-input--small - Applies styles for a smaller text input
  static const String C_INPUT__SMALL = "slds-input--small";
  /// slds-input--bare - Removes background and border from text input
  static const String C_INPUT__BARE = "slds-input--bare";
  /// slds-input-has-icon - Lets text input know how to position .slds-input__icon
  static const String C_INPUT_HAS_ICON = "slds-input-has-icon";
  /// slds-input__icon - Hook for .slds-input-has-icon
  static const String C_INPUT__ICON = "slds-input__icon";
  /// slds-input-has-icon--left - Positions .slds-input__icon to the left of the text input
  static const String C_INPUT_HAS_ICON__LEFT = "slds-input-has-icon--left";
  /// slds-input-has-icon--right - Positions .slds-input__icon to the right of the text input
  static const String C_INPUT_HAS_ICON__RIGHT = "slds-input-has-icon--right";
  /// slds-textarea - Initializes textarea | Required
  static const String C_TEXTAREA = "slds-textarea";
  /// slds-select - Initializes select | Required
  static const String C_SELECT = "slds-select";
  /// slds-checkbox - Initializes checkbox | Required
  static const String C_CHECKBOX = "slds-checkbox";
  /// slds-checkbox--faux - Creates a custom styled checkbox
  static const String C_CHECKBOX__FAUX = "slds-checkbox--faux";
  /// slds-radio - Initializes radio butotn | Required
  static const String C_RADIO = "slds-radio";
  /// slds-radio--faux - Creates a custom styled radio button
  static const String C_RADIO__FAUX = "slds-radio--faux";
  /// slds-form--horizontal - Horizontally aligns form label and control on same line
  static const String C_FORM__HORIZONTAL = "slds-form--horizontal";
  /// slds-form--stacked - Vertically aligns form label and control, provides spacing between form elements
  static const String C_FORM__STACKED = "slds-form--stacked";
  /// slds-form--inline - horizontally align form elements on the same axis
  static const String C_FORM__INLINE = "slds-form--inline";
  /// slds-form--compound - Form consists that consists of form groups
  static const String C_FORM__COMPOUND = "slds-form--compound";
  /// slds-form-element__row - Clears a row of form elements
  static const String C_FORM_ELEMENT__ROW = "slds-form-element__row";
  /// slds-form--compound--horizontal - Layout modifier for compound forms
  static const String C_FORM__COMPOUND__HORIZONTAL = "slds-form--compound--horizontal";


  static const String C_HAS_ERROR = "slds-has-error";
  static const String C_IS_REQUIRED = "slds-is-required";

  static const String C_FORM_ELEMENT__HELP = "slds-form-element__help";

  static final List<String> FORMTYPES = [C_FORM__HORIZONTAL, C_FORM__STACKED, C_FORM__INLINE];


  static final Logger _log = new Logger("LForm");

  /// Form Element
  final Element element;
  /// List of Editors
  final List<LEditor> editors = new List<LEditor>();

  /// Form - type = C_FORM__HORIZONTAL, C_FORM__STACKED, C_FORM__INLINE
  LForm(Element this.element, String type) {
    element.classes.add(type);
    if (element is FormElement) {
      (element as FormElement).onSubmit.listen(onFormSubmit);
      (element as FormElement).onReset.listen(onFormReset);
    }
  }

  LForm.horizontal() : this(new FormElement(), C_FORM__HORIZONTAL);
  LForm.stacked() : this(new FormElement(), C_FORM__STACKED);
  LForm.inline() : this(new FormElement(), C_FORM__INLINE);

  /// Add Editor
  void addEditor (LEditor editor) {
    editors.add(editor);
    element.append(editor.element);
  }

  /// Data Container
  DataRecord get data => _data;
  /// Data Container
  void set data (DataRecord data) {
    _data = data;
    display();
  }
  DataRecord _data = new DataRecord(null);

  /// Data Record
  DRecord get record => _data.record;
  /// Data Record/Row No
  void setRecord (DRecord record, int rowNo) {
    _data.setRecord(record, rowNo);
    display();
  }

  /// Display Data in Editors
  void display() {
    for (LEditor editor in editors) {
      editor.data = _data;
      DEntry entry = _data.getEntry(editor.id, editor.name, false);
      if (entry == null) {
        editor.value = "";
      } else {
        String value = null;
        if (entry.hasValueOriginal()) {
          value = entry.valueOriginal;
          if (value == DataRecord.NULLVALUE)
            value = "";
          editor.valueOriginal = value;
        }
        if (entry.hasValue()) {
          value = entry.value;
          if (value == DataRecord.NULLVALUE)
            value = null;
        }
        if (value == null)
          value = "";
        editor.value = value;
      }
    }
  } // display

  LButton addResetButton() {
    LButton btn = new LButton.neutralIcon("reset", lFormReset(),
      new LIconUtility(LIconUtility.UNDO), iconLeft:true)
      ..typeReset = true;
    element.append(btn.element);
    return btn;
  }
  LButton addSaveButton() {
    LButton btn = new LButton.brandIcon("save", lFormSave(),
      new LIconUtility(LIconAction.CHECK), iconLeft:true)
      ..typeSubmit = true;
    element.append(btn.element);
    return btn;
  }

  /// On Form Reset
  void onFormReset(Event evt) {
    _log.info("onFormReset - ${record}");
    evt.preventDefault();
  }
  /// On Form Submit
  void onFormSubmit(Event evt) {
    _log.info("onFormSubmit - ${record}");
    evt.preventDefault();
  }

  /// Layout

  /// Form Type
  String get formType {
    for (String cls in element.classes) {
      if (FORMTYPES.contains(cls))
        return cls;
    }
    return null;
  }
  /// Set Form Type, e.g. C_FORM__HORIZONTAL, C_FORM__STACKED, C_FORM__INLINE
  void set formType (String newValue) {
    element.classes.removeAll(FORMTYPES);
    if (newValue != null && newValue.isNotEmpty)
      element.classes.add(newValue);
  }


  // Trl
  static String lFormSave() => Intl.message("Save", name: "lFormSave");
  static String lFormReset() => Intl.message("Reset", name: "lFormReset");

} // LForm

/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Theme
 */
class LTheme {

  /// slds-box - Provides 1rem base padding and borders | Required
  static const String C_BOX = "slds-box";
  /// slds-box--x-small - Changes padding to .5rem
  static const String C_BOX__X_SMALL = "slds-box--x-small";
  /// slds-box--small - Changes padding to .75rem
  static const String C_BOX__SMALL = "slds-box--small";

  /// slds-theme--default - Sets the background color to white
  static const String C_THEME__DEFAULT = "slds-theme--default";
  /// slds-theme--shade - Sets a light gray background color
  static const String C_THEME__SHADE = "slds-theme--shade";
  /// slds-theme--inverse - Sets the darkest blue background and light text and links
  static const String C_THEME__INVERSE = "slds-theme--inverse";
  /// slds-theme--alt-inverse - Sets the alternative dark blue background and light text and links
  static const String C_THEME__ALT_INVERSE = "slds-theme--alt-inverse";
  /// slds-theme--success - Success feedback theme modifier
  static const String C_THEME__SUCCESS = "slds-theme--success";
  /// slds-theme--warning - Warning feedback theme modifier
  static const String C_THEME__WARNING = "slds-theme--warning";
  /// slds-theme--error - Error feedback theme modifier
  static const String C_THEME__ERROR = "slds-theme--error";
  /// slds-theme--offline - Offline feedback theme modifier
  static const String C_THEME__OFFLINE = "slds-theme--offline";
  /// slds-theme--alert-texture - Adds striped background
  static const String C_THEME__ALERT_TEXTURE = "slds-theme--alert-texture";
  /// slds-theme--inverse-text -
  static const String C_THEME__INVERSE_TEXT = "slds-theme--inverse-text";

  /// slds-page-header - Applies background color and padding | Required
  static const String C_PAGE_HEADER = "slds-page-header";


  static final List<String> SIZES = [C_BOX__SMALL, C_BOX__X_SMALL];


  static void themeDefault (Element element) {
    element.classes.add(C_THEME__DEFAULT);
  }
  static void themeShade (Element element) {
    element.classes.add(C_THEME__SHADE);
  }
  static void themeInverse (Element element) {
    element.classes.add(C_THEME__INVERSE);
  }
  static void themeAltInverse (Element element) {
    element.classes.add(C_THEME__ALT_INVERSE);
  }
  static void themeSuccess (Element element) {
    element.classes.add(C_THEME__SUCCESS);
    element.classes.add(C_THEME__INVERSE_TEXT);
  }
  static void themeWarning (Element element) {
    element.classes.add(C_THEME__WARNING);
    element.classes.add(C_THEME__INVERSE_TEXT);
  }
  static void themeError (Element element) {
    element.classes.add(C_THEME__ERROR);
    element.classes.add(C_THEME__INVERSE_TEXT);
  }
  static void themeOffline (Element element) {
    element.classes.add(C_THEME__ERROR);
    element.classes.add(C_THEME__INVERSE_TEXT);
  }
  /// add alert texture (striped)
  static void themeTexture (Element element) {
    element.classes.add(C_THEME__ALERT_TEXTURE);
  }


} // LTheme


/**
 * Box
 */
class LBox extends LComponent {

  final DivElement element = new DivElement()
    ..classes.add(LTheme.C_BOX);


  void set small (bool newValue) {
    element.classes.removeAll(LTheme.SIZES);
    if (newValue)
      element.classes.add(LTheme.C_BOX__SMALL);
  }

  void set xsmall (bool newValue) {
    element.classes.removeAll(LTheme.SIZES);
    if (newValue)
      element.classes.add(LTheme.C_BOX__X_SMALL);
  }

} // LBox

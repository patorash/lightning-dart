/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Buttons
 */
class LButton
    extends LComponent {

  /// slds-button (button or link): Initializes a 2rem (32px) height button - This neutralizes all the base styles making it look like a text link
  static const String C_BUTTON = "slds-button";
  /// slds-button--small (slds-button): Deprecated.
  //static const String C_BUTTON__SMALL = "slds-button--small";
  /// slds-button--neutral (slds-button): Creates the gray border with white background default style
  static const String C_BUTTON__NEUTRAL = "slds-button--neutral";
  /// slds-button--brand (slds-button): Creates the brand blue Salesforce style
  static const String C_BUTTON__BRAND = "slds-button--brand";
  /// slds-button--destructive (slds-button): Creates a red button style - The use case for this button is things like delete, cancel, and end call rather than errors.
  static const String C_BUTTON__DESTRUCTIVE = "slds-button--destructive";
  /// slds-button--inverse (slds-button): Creates the inverse style for dark backgrounds
  static const String C_BUTTON__INVERSE = "slds-button--inverse";

  /// slds-button__icon (svg): Sets the size and color of the icon inside a button
  static const String C_BUTTON__ICON_ = "slds-button__icon";
  /// slds-button__icon--stateful (svg): This makes the icon the same color as the text in the button - This is not used in addition to .slds-button__icon but instead of
  static const String C_BUTTON__ICON__STATEFUL = "slds-button__icon--stateful";
  /// slds-button__icon--left (slds-button__icon): Puts the icon on the left side of the button
  static const String C_BUTTON__ICON__LEFT = "slds-button__icon--left";
  /// slds-button__icon--right (slds-button__icon): Puts the icon on the right side of the button
  static const String C_BUTTON__ICON__RIGHT = "slds-button__icon--right";
  /// slds-button__icon--x-small (slds-button__icon): Creates a .5rem (8px) size icon - This is added to the icon inside the .slds-button, not the button itself
  static const String C_BUTTON__ICON__X_SMALL = "slds-button__icon--x-small";
  /// slds-button__icon--small (slds-button__icon): Creates a .75rem (12px) size icon
  static const String C_BUTTON__ICON__SMALL = "slds-button__icon--small";
  /// slds-button__icon--large (slds-button__icon): Creates a 1.5rem (24px) size icon
  static const String C_BUTTON__ICON__LARGE = "slds-button__icon--large";
  /// slds-button__icon--hint (slds-button__icon): Creates a grayed out icon until the parent is hovered - The parent must have the .slds-hint-parent class applied
  static const String C_BUTTON__ICON__HINT = "slds-button__icon--hint";
  /// slds-button__icon--inverse-hint (slds-button__icon): Creates a grayed out icon until the parent is hovered for inversed dark backgrounds - The parent must have the .slds-hint-parent class applied
  static const String C_BUTTON__ICON__INVERSE_HINT = "slds-button__icon--inverse-hint";

  /// slds-button-space-left (button parent): Adds space on the left of a button wrapped in a parent - Only required if the .slds-button is wrapped. ie- to include a dropdown
  static const String C_BUTTON_SPACE_LEFT = "slds-button-space-left";


  /// slds-button--icon (slds-button): Creates a button that looks like a plain icon - This is 1rem×1rem like an icon, not a regular button
  static const String C_BUTTON__ICON = "slds-button--icon";
  /// slds-button--icon-bare (slds-button): Creates a button that looks like a plain icon - This is 1rem×1rem like an icon, not a regular button
  //static const String C_BUTTON__ICON_BARE = "slds-button--icon-bare";
  /// slds-button--icon-container (slds-button): Creates a button that looks like a plain icon - This is 2rem×2rem (32px) like a button
  static const String C_BUTTON__ICON_CONTAINER = "slds-button--icon-container";
  /// slds-button--icon-border (slds-button): Creates an icon button with a border - This is 2rem×2rem (32px) like a button, there is no background color until hover for this style
  static const String C_BUTTON__ICON_BORDER = "slds-button--icon-border";
  /// slds-button--icon-border-filled (slds-button): Creates an icon button with a border - This is 2rem×2rem (32px) like a button
  static const String C_BUTTON__ICON_BORDER_FILLED = "slds-button--icon-border-filled";
  /// slds-button--icon-inverse (slds-button): Gives a white icon color on a dark background - When used alone it has a subtle hover. When used in a button-group it assumes the hover state of the buttons next to it.
  static const String C_BUTTON__ICON_INVERSE = "slds-button--icon-inverse";
  /// slds-button--icon-border-inverse (slds-button): Creates an icon button with a white border - There is no background color.
  static const String C_BUTTON__ICON_BORDER_INVERSE = "slds-button--icon-border-inverse";

  // container sizes
  /// slds-button--icon-small (slds-button): Creates an icon button at the smaller 1.5rem (24px) size
  static const String C_BUTTON__ICON_SMALL = "slds-button--icon-small";
  /// slds-button--icon-x-small (slds-button): Creates an icon button at the smaller 1.25rem (20px) size
  static const String C_BUTTON__ICON_X_SMALL = "slds-button--icon-x-small";
  /// slds-button--icon-xx-small (slds-button): Creates an icon button at the smaller 1rem (16px) size
  static const String C_BUTTON__ICON_XX_SMALL = "slds-button--icon-xx-small";

  /// slds-button--icon-more (slds-button): Used for the style where only two icons are in a button - This is usually an icon with a down arrow icon next to it. Each svg within is sized separately
  static const String C_BUTTON__ICON_MORE = "slds-button--icon-more";

  /// Red Icon
  static const String C_BUTTON__ICON_ERROR = "slds-button--icon-error";


  /// slds-button--hint (slds-button):
  static const String C_BUTTON__HINT = "slds-button--hint";
  static const String C_BUTTON__TRANSPARENT = "slds-button--transparent";

  /// Hint Wrapper
  static const String C_HINT_PARENT = "slds-hint-parent";

  static const String C_NOT_SELECTED = "slds-not-selected";
  static const String C_IS_SELECTED = "slds-is-selected";

  static const String C_CLOSE = "close";

  /// The Button / Link
  final Element element;
  /// Label
  Element _labelElement;
  /// The Label
  String _label;
  /// Optional Button Icon
  LIcon _icon;
  /// Icon left
  bool _iconLeft = false;
  /// true = button icon is 1rem gray - false = icon is 2rem white
  bool _iconButton = true;
  /// Optional Assistive Text Element
  SpanElement _assistive;
  /// Optional Assistive Text
  String _assistiveText;

  /**
   * Button with [name] and optional [label]
   * [element] can be a button, anchor, or input
   * if [idPrefix] is provided, the id will be idPrefix-name, if empty - the name
   */
  LButton(Element this.element,
      String name,
      String label,
      {String idPrefix,
      Element labelElement,
      List<String> buttonClasses,
      LIcon icon,
      bool iconLeft: true,
      String assistiveText}) {
    element.classes.add(C_BUTTON);
    if (element is ButtonElement) {
      (element as ButtonElement).name = name;
    } else if (element is InputElement) {
        (element as InputElement).name = name;
        (element as InputElement).value = label;
    } else { // anchor
      element.attributes[Html0.DATA_NAME] = name;
    }
    element.id = LComponent.createId(idPrefix, name);
    // classes
    if (buttonClasses != null) {
      element.classes.addAll(buttonClasses);
    }
    _label = label;
    _labelElement = labelElement;
    _icon = icon;
    _iconLeft = iconLeft;
    //
    _assistiveText = assistiveText;
    if (assistiveText != null && assistiveText.isNotEmpty) {
      element.title = assistiveText;
    }
    typeButton = true; // default = submit
    _rebuild();
  } // LButton

  /// set id prefix
  void setIdPrefix(String idPrefix) {
    element.id = LComponent.createId(idPrefix, name);
  }
  /// rebuild button
  void _rebuild() {
    element.children.clear();
    if (_icon == null) {
      if (_labelElement != null)
        element.append(_labelElement);
      else if (_label != null)
        element.appendText(_label);
    } else {
      // save general icon classes
      List<String> list = new List<String>();
      _icon.classes.forEach((String iconClass){
        if (_ICON_ATTRIB.contains(iconClass) // stateful,modal,hint
            || _ICON_SIZES.contains(iconClass))
          list.add(iconClass);
      });
      _icon.classes.clear(); // remove colors
      _icon.classes.addAll(list);
      // set classes
      if (_iconButton) {
        _icon.classes.add(C_BUTTON__ICON_); // 1rem gray - slds-button__icon
      } else {
        _icon.classes.add(C_BUTTON__ICON); // 2rem white - slds-button--icon
      }
      // left/right
      if (_label == null && _labelElement == null) {
        element.append(_icon.element);
      } else {
        if (_iconLeft) {
          if (_iconButton)
            _icon.classes.add(C_BUTTON__ICON__LEFT);
          element.append(_icon.element);
          if (_labelElement != null)
            element.append(_labelElement);
          else if (_label != null)
            element.appendText(_label);
        } else {
          if (_iconButton)
            _icon.classes.add(C_BUTTON__ICON__RIGHT);
          if (_labelElement != null)
            element.append(_labelElement);
          else if (_label != null)
            element.appendText(_label);
          element.append(_icon.element);
        }
      }
    }
    if (_assistiveText != null) {
      if (_assistive == null) {
        _assistive = new SpanElement()
          ..classes.add(LVisibility.C_ASSISTIVE_TEXT);
        element.append(_assistive);
      }
      _assistive.text = _assistiveText;
    }
    /// Add More (down) icon
    if (element.classes.contains(C_BUTTON__ICON_MORE)) {
      element.setAttribute(Html0.ARIA_HASPOPUP, "true");
      LIcon more = new LIconUtility("down", className: C_BUTTON__ICON, size: C_BUTTON__ICON__X_SMALL);
      element.append(more.element);
    }
  } // rebuild
  List<String> _ICON_ATTRIB = [C_BUTTON__ICON__STATEFUL, C_BUTTON__ICON__HINT,
    LIcon.C_ROTATE_LEFT, LIcon.C_ROTATE_RIGHT];

  /// Default Button
  LButton.base(String name, String label, {String idPrefix})
    : this(new ButtonElement(), name, label, idPrefix:idPrefix);

  /// Neutral Button
  LButton.neutral(String name, String label, {String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__NEUTRAL], idPrefix:idPrefix);
  /// Neutral Anchor
  LButton.neutralAnchor(String name, String label,
      {String href, String target:NewWindow.TARGET_BLANK, String idPrefix})
    : this(new AnchorElement(href:(href == null ? "#" : href)) ..target = target,
        name, label,
        buttonClasses: [C_BUTTON__NEUTRAL], idPrefix:idPrefix);
  /// Neutral Input Button
  LButton.neutralInput(String name, String label, {String idPrefix})
    : this(new InputElement(type: "button"), name, label,
        buttonClasses: [C_BUTTON__NEUTRAL], idPrefix:idPrefix);

  /// Neutral Button with Icon
  LButton.neutralIcon(String name, String label, LIcon icon,
      {bool iconLeft: true, String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__NEUTRAL],
        icon:icon, iconLeft:iconLeft, idPrefix:idPrefix);
  /// Neutral Anchor
  LButton.neutralAnchorIcon(String name, String label, LIcon icon,
      {String href, String target:NewWindow.TARGET_BLANK,
      bool iconLeft: true, String idPrefix})
    : this(new AnchorElement(href:(href == null ? "#" : href)) ..target = target,
        name, label,
        buttonClasses: [C_BUTTON__NEUTRAL], icon:icon,
        iconLeft:iconLeft, idPrefix:idPrefix);

  /// (Neutral) Icon Button with More
  LButton.more(String name, String label, LIcon icon, String assistiveText, {String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__ICON_MORE], icon:icon, assistiveText:assistiveText, idPrefix:idPrefix);

  /// Brand Button
  LButton.brand(String name, String label, {String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__BRAND], idPrefix:idPrefix);
  /// Brand Button with Icon
  LButton.brandIcon(String name, String label, LIcon icon,
      {bool iconLeft: true, String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__BRAND], icon:icon,
        iconLeft:iconLeft, idPrefix:idPrefix);
  /// Brand Button
  LButton.brandAnchor(String name, String label,
      {String href, String target:NewWindow.TARGET_BLANK, String idPrefix})
    : this(new AnchorElement(href: (href == null ? "#" : href)) ..target = target,
        name, label,
        buttonClasses: [C_BUTTON__BRAND], idPrefix:idPrefix);

  /// Inverse Button
  LButton.inverse(String name, String label, {String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__INVERSE], idPrefix:idPrefix);

  /// Destructive Button
  LButton.destructive(String name, String label, {String idPrefix})
    : this(new ButtonElement(), name, label,
  buttonClasses: [C_BUTTON__DESTRUCTIVE], idPrefix:idPrefix);
  /// Destructive Button with Icon
  LButton.destructiveIcon(String name, String label, LIcon icon,
      {bool iconLeft: true, String idPrefix})
    : this(new ButtonElement(), name, label,
        buttonClasses: [C_BUTTON__DESTRUCTIVE], icon:icon,
        iconLeft:iconLeft, idPrefix:idPrefix);


  /// Icon Only - bare
  LButton.iconBare(String name, LIcon icon, String assistiveText, {String idPrefix})
    : this(new ButtonElement(), name, null, icon:icon,
        buttonClasses: [C_BUTTON__ICON], assistiveText:assistiveText, idPrefix:idPrefix);
  /// Icon Only - container
  LButton.iconContainer(String name, LIcon icon, String assistiveText, {String idPrefix})
    : this(new ButtonElement(), name, null, icon:icon,
        buttonClasses: [C_BUTTON__ICON_CONTAINER], assistiveText:assistiveText, idPrefix:idPrefix);
  /// Icon Only - border
  LButton.iconBorder(String name, LIcon icon, String assistiveText, {String idPrefix})
    : this(new ButtonElement(), name, null, icon:icon,
        buttonClasses: [C_BUTTON__ICON_BORDER], assistiveText:assistiveText, idPrefix:idPrefix);
  /// Icon Only - border filled
  LButton.iconBorderFilled(String name, LIcon icon, String assistiveText, {String idPrefix})
    : this(new ButtonElement(), name, null, icon:icon,
        buttonClasses: [C_BUTTON__ICON_BORDER_FILLED], assistiveText:assistiveText, idPrefix:idPrefix);

  /// Icon Only - border filled
  LButton.iconBorderFilledAnchor(String name, LIcon icon, String assistiveText,
        {String href, String target:NewWindow.TARGET_BLANK, String idPrefix})
    : this(new AnchorElement(href: (href == null ? "#" : href)) ..target = target,
        name, null, icon:icon,
        buttonClasses: [C_BUTTON__ICON_BORDER_FILLED], assistiveText:assistiveText, idPrefix:idPrefix);
  /// Icon Only - border
  LButton.iconBorderAnchor(String name, LIcon icon, String assistiveText,
        {String href, String target:NewWindow.TARGET_BLANK, String idPrefix})
      : this(new AnchorElement(href: (href == null ? "#" : href)) ..target = target,
        name, null, icon:icon,
        buttonClasses: [C_BUTTON__ICON_BORDER], assistiveText:assistiveText, idPrefix:idPrefix);
  /// Icon Only - container
  LButton.iconContainerAnchor(String name, LIcon icon, String assistiveText,
      {String href, String target:NewWindow.TARGET_BLANK, String idPrefix})
      : this(new AnchorElement(href: (href == null ? "#" : href)) ..target = target,
      name, null, icon:icon,
      buttonClasses: [C_BUTTON__ICON_CONTAINER], assistiveText:assistiveText, idPrefix:idPrefix);


  /// Button id
  String get id => element.id;
  /// Button name
  String get name {
    if (element is ButtonElement)
      return (element as ButtonElement).name;
    else if (element is InputElement)
      return (element as InputElement).name;
    return element.attributes[Html0.DATA_NAME];
  }

  /// Button Type (null for link)
  String get type {
    if (element is ButtonElement)
      return (element as ButtonElement).type;
    else if (element is InputElement)
      return (element as InputElement).type;
    return null;
  }
  /// Button Type (button|submit|reset) - ignored if link
  void set type (String type) {
    if (element is ButtonElement)
      (element as ButtonElement).type = type;
    else if (element is InputElement)
      (element as InputElement).type = type;
  }
  bool get typeButton => type == "button";
  void set typeButton (bool newValue) {
    type = "button"; // regardless
  }
  bool get typeSubmit => type == "submit";
  void set typeSubmit (bool newValue) {
    type = newValue ? "submit" : "button";
  }
  bool get typeReset => type == "reset";
  void set typeReset (bool newValue) {
    type = newValue ? "reset" : "button";
  }

  /// auto focus if button or input
  void set autofocus (bool newValue) {
    if (element is ButtonElement)
      (element as ButtonElement).autofocus = newValue;
    else if (element is InputElement)
      (element as InputElement).autofocus = newValue;
  }

  /// Button Label
  String get label {
    if (_labelElement != null) {
      return _labelElement.text;
    }
    return _label;
  }
  /// Button Label
  void set label (String newValue) {
    if (_labelElement != null) {
      _labelElement.text = newValue;
    } else {
      _label = newValue;
    }
    _rebuild();
  }
  /// Button icon
  LIcon get icon => _icon;
  /// Button icon
  void set icon (LIcon newValue) {
    _icon = newValue;
    _rebuild();
  }
  /// Button Icon Left
  bool get iconLeft => _iconLeft;

  /// Assistive Text
  String get assistiveText => _assistiveText;
  /// Add/Set Assistive Text
  void set assistiveText (String newValue) {
    _assistiveText = newValue;
    element.title = (_assistiveText == null ? "" : _assistiveText);
    _rebuild();
  }

  /// title
  String get title => element.title;
  /// title
  void set title (String newValue) {
    element.title = newValue;
  }

  /// Set href if Anchor
  void set href (String newValue) {
    if (element is AnchorElement) {
      (element as AnchorElement).href = newValue;
    }
  }

  // button size only with icon
  bool get small => element.classes.contains(C_BUTTON__ICON_SMALL);
  // button size only with icon
  void set small (bool newValue) {
    element.classes.removeAll(_ELEMENT_SIZES);
    if (newValue)
      element.classes.add(C_BUTTON__ICON_SMALL);
  }

  List<String> _ELEMENT_SIZES = [C_BUTTON__ICON_SMALL, C_BUTTON__ICON_X_SMALL, C_BUTTON__ICON_XX_SMALL];
  List<String> _ICON_SIZES = [C_BUTTON__ICON__LARGE, C_BUTTON__ICON__SMALL, C_BUTTON__ICON__X_SMALL];

  /// button icon is 1rem gray (default) - icon is 2rem white
  void set iconButton (bool newValue) {
    _iconButton = newValue;
    _rebuild();
  }

  /// Set Icon Size e.g. C_BUTTON__ICON__X_SMALL
  void set iconSize(String newValue) {
    if (_icon != null) {
      _icon.classes.removeAll(_ICON_SIZES);
      _icon.classes.add(newValue);
    }
  }
  /// Icon Size
  void iconSizeXSmall() {
    iconSize = C_BUTTON__ICON__X_SMALL;
  }
  /// Icon Size
  void iconSizeSmall() {
    iconSize = C_BUTTON__ICON__SMALL;
  }
  /// Icon Size
  void iconSizeLarge() {
    iconSize = C_BUTTON__ICON__LARGE;
  }
  /// Icon Inverse
  void iconInverse() {
    element.classes.add(C_BUTTON__ICON_INVERSE);
  }

  /// Button in selected state
  bool get selected => element.classes.contains(LButton.C_IS_SELECTED);

  /// Set Selected State
  void set selected (bool newValue) {
    element.classes.toggle(C_NOT_SELECTED, !newValue);
    element.classes.toggle(C_IS_SELECTED, newValue);
  }

  /// Button Icon Anchor Fix
  void iconAnchorFix() {
    if (_icon != null)
      _icon.element.style.marginTop = "0.5rem";
  }

  /**
   * Hint Button wrapper - grayed out until hovered over
   * Returns div hint container with button appended
   */
  DivElement hintParent() {
    DivElement div = new DivElement()
      ..classes.add(C_HINT_PARENT);
    div.append(element);
    hint = true;
    return div;
  }

  /// Hint button
  bool get hint => _icon != null && _icon.classes.contains(C_BUTTON__ICON__HINT);
    /// Set Hint (needs to be in hint-parent)
  void set hint(bool newValue) {
    if (_icon != null) {
      _icon.classes.toggle(C_BUTTON__ICON__HINT, newValue);
    }
  }

  /// disabled
  bool get disabled {
    if (element is ButtonElement)
      return (element as ButtonElement).disabled;
    if (element is InputElement)
      return (element as InputElement).disabled;
    return Html0.DISABLED == element.attributes[Html0.DISABLED];
  }
  /// disabled
  void set disabled(bool newValue) {
    if (element is ButtonElement) {
      (element as ButtonElement).disabled = newValue;
    }
    else if (element is InputElement) {
      (element as InputElement).disabled = newValue;
    }
    else if (newValue) {
      element.attributes[Html0.ARIA_DISABLED] = "true";
      element.attributes[Html0.DISABLED] = Html0.DISABLED;
      if (_disabledClick == null) {
        _disabledClick = element.onClick.listen((MouseEvent evt) {
          evt.preventDefault();
          evt.stopImmediatePropagation();
        });
      }
    } else {
      element.attributes.remove(Html0.DISABLED);
      if (_disabledClick != null) {
        _disabledClick.cancel();
      }
      _disabledClick = null;
    }
  }
  StreamSubscription<MouseEvent> _disabledClick;

  /// Button Click
  ElementStream<MouseEvent> get onClick => element.onClick;


  /// As List Item
  DOption asDOption() {
    DOption option = new DOption();
    String theId = id;
    if (theId != null && theId.isNotEmpty)
      option.id = theId;
    String theName = name;
    if (theName != null && theName.isNotEmpty)
      option.value = name;
    String theLabel = label;
    if (theLabel != null && theLabel.isNotEmpty)
      option.label = theLabel;
    if (disabled)
      option.isActive = false;
    // no selected (otherwise button group overflow will not work)
    return option;
  } // asListItem

  /// As List Item
  ListItem asListItem({bool iconLeft:true}) {
    DOption option = asDOption();
    if (icon != null) {
      if (iconLeft)
        return new ListItem(option, icon.copy(), null, false);
      return new ListItem(option, null, icon.copy(), false);
    }
    return new ListItem(option, null, null, false);
  } // asListItem

  /// Focus on Button
  void focus() {
    element.focus();
  }

  String toString() {
    return "LButton@${name}";
  }

} // LButton


/**
 * (Toggle) Button with multiple states
 */
class LButtonStateful
    extends LButton {

  static final Logger _log = new Logger("LButtonStateful");

  final List<LButtonStatefulState> states = new List<LButtonStatefulState>();

  /**
   * Toggle Button with [name] (default Follow)
   * if [onButtonClick] is provided, it will be called after state change
   */
  LButtonStateful(String name,
        LButtonStatefulState notSelectedState,
        LButtonStatefulState selectedState,
        LButtonStatefulState selectedFocusState,
        {String idPrefix, void onButtonClick(MouseEvent evt)})
      : super(new ButtonElement(), name, null, idPrefix: idPrefix) {

    element.classes.add(LButton.C_BUTTON__NEUTRAL);
    element.classes.add(LButton.C_NOT_SELECTED);
    element.setAttribute(Html0.ARIA_LIVE, Html0.ARIA_LIVE_ASSERTIVE);
    //
    addState(notSelectedState);
    addState(selectedState);
    addState(selectedFocusState);

    element.onClick.listen((MouseEvent evt) {
      if (!disabled) {
        bool newState = toggle();
        _log.fine("${name} selected=${newState}");
        if (onButtonClick != null)
          onButtonClick(evt);
      }
    });
  } // LButtonStateful

  /**
   * Follow Toggle Button
   */
  LButtonStateful.follow(String name, {String idPrefix,
        String notSelected:"Follow",
        String selected:"Following",
        String selectedFocus:"Unfollow",
        void onButtonClick(MouseEvent evt)})
    : this (name,
      new LButtonStatefulState(new LIconUtility(LIconUtility.ADD),
          notSelected, LText.U_TEXT_NOT_SELECTED), // TODO check
      new LButtonStatefulState(new LIconUtility(LIconUtility.CHECK),
          selected, LText.U_TEXT_SELECTED),
      new LButtonStatefulState(new LIconUtility(LIconUtility.CLOSE),
          selectedFocus, LText.U_TEXT_SELECTED_FOCUS),
      idPrefix:idPrefix, onButtonClick:onButtonClick);

  /// Selected Toggle Button
  LButtonStateful.select(String name, {
      String notSelected:"Not Selected",
      String selected:"Selected",
      String selectedFocus:"Unselect",
      String idPrefix, void onButtonClick(MouseEvent evt)})
    : this (name,
      new LButtonStatefulState(new LIconUtility(LIconUtility.CLEAR),
          notSelected, LText.U_TEXT_NOT_SELECTED),
      new LButtonStatefulState(new LIconUtility(LIconUtility.SUCCESS),
          selected, LText.U_TEXT_SELECTED),
      new LButtonStatefulState(new LIconUtility(LIconUtility.CLOSE),
          selectedFocus, LText.U_TEXT_SELECTED_FOCUS),
      idPrefix:idPrefix, onButtonClick:onButtonClick);

  /// Edit/View Toggle Button
  LButtonStateful.view(String name, {
      String notSelected:"Edit",
      String selected:"View",
      String selectedFocus:"Read/Write",
      String idPrefix, void onButtonClick(MouseEvent evt)})
    : this (name,
      new LButtonStatefulState(new LIconUtility(LIconUtility.EDIT),
          notSelected, LText.U_TEXT_NOT_SELECTED),
      new LButtonStatefulState(new LIconUtility(LIconUtility.LOCK),
          selected, LText.U_TEXT_SELECTED),
      new LButtonStatefulState(new LIconUtility(LIconUtility.UNLOCK),
          selectedFocus, LText.U_TEXT_SELECTED_FOCUS),
      idPrefix:idPrefix, onButtonClick:onButtonClick);

  /// add State
  void addState(LButtonStatefulState state) {
    state.icon.classes.clear();
    state.icon.classes.addAll([LButton.C_BUTTON__ICON__STATEFUL, LButton.C_BUTTON__ICON__LEFT]);
    states.add(state);
    element.append(state.element);
  }

  /// toggle state - return new state
  bool toggle() {
    bool newState = !selected;
    selected = newState;
    return newState;
  }

} // LButtonStateful


/// Button State
class LButtonStatefulState {

  final SpanElement element = new SpanElement();
  final LIcon icon;

  /// Button State
  LButtonStatefulState(LIcon this.icon, String text, String spanClass) {
    element.classes.add(spanClass);
    element.append(icon.element);
    element.appendText(text);
  }

} // LButtonStatefulState


/**
 * Stateful Button Icon
 */
class LButtonStatefulIcon
    extends LButton {

  static final Logger _log = new Logger("LButtonIconStateful");

  /**
   * Stateful Icon
   */
  LButtonStatefulIcon(String name, String assistiveText, LIcon icon,
        {String idPrefix,
        void onButtonClick(MouseEvent evt)})
    : super(new ButtonElement(), name, null,
        buttonClasses:[LButton.C_BUTTON__ICON_BORDER],
        idPrefix:idPrefix, icon:icon, assistiveText:assistiveText) {

    element.onClick.listen((MouseEvent evt){
      if (!disabled) {
        bool newState = toggle();
        _log.fine("${name} selected=${newState}");
        if (onButtonClick != null)
          onButtonClick(evt);
      }
    });
    selected = false;
  } // LButtonStatefulIcon


  /// toggle state - return new state
  bool toggle() {
    bool newState = !selected;
    selected = newState;
    return newState;
  }

} // LButtonStatefulIcon

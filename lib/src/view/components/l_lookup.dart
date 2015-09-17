/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Lookup
 * - div .form-element
 * - div .lookup__menu
 *
 * https://www.getslds.com/components/lookups#role=regular&status=all
 */
class LLookup
    extends LEditor with LSelectI {

  /// slds-lookup - Initializes lookup | Required
  static const String C_LOOKUP = "slds-lookup";
  /// slds-lookup__menu - Initializes lookup results list container | Required
  static const String C_LOOKUP__MENU = "slds-lookup__menu";
  /// slds-lookup__list - Initializes lookup results list | Required
  static const String C_LOOKUP__LIST = "slds-lookup__list";
  /// slds-lookup__item - Results lsit item | Required
  static const String C_LOOKUP__ITEM = "slds-lookup__item";


  static final Logger _log = new Logger("LLookup");

  static const String DATA_SELECT_MULTI = "multi";
  static const String DATA_SELECT_SINGLE = "single";

  /// Lookup form + menu
  final DivElement element = new DivElement()
    ..classes.add(C_LOOKUP);

  /// Form Element - lookup needs to be top element
  final LFormElement _formElement = new LFormElement();
  /// Form Element Input
  final InputElement input = new InputElement(type: EditorI.TYPE_TEXT);
  /// Search Icon
  final LIcon _icon = new LIconUtility(LIconUtility.SEARCH);
  /// Lookup form + menu
  final DivElement _lookupMenu = new DivElement()
    ..classes.add(C_LOOKUP__MENU)
    ..attributes[Html0.ROLE] = Html0.ROLE_LISTBOX;

  final UListElement _lookupList = new UListElement()
    ..classes.add(C_LOOKUP__LIST)
    ..attributes[Html0.ROLE] = Html0.ROLE_PRESENTATION;

  /// Lookup Items
  final List<LLookupItem> _lookupItemList = new List<LLookupItem>();

  /// Pill Container
  DivElement _pillContainer;

  /// Displayed in Grid
  final bool inGrid;

  /**
   * Lookup
   * [input] should have labelText set and be of type text
   * [select] single|multi
   * [scope] single|multi
   */
  LLookup(String name, {String idPrefix,
      String select: DATA_SELECT_SINGLE,
      String scope: "single",
      bool typeahead: false,
      bool this.inGrid:false}) {
    _setAttributes(select, scope, typeahead);
    _formElement.createStandard(this, iconRight: _icon);
    input
      ..attributes[Html0.ROLE] = Html0.ROLE_COMBOBOX
      ..attributes[Html0.ARIA_AUTOCOMPLETE] = Html0.ARIA_AUTOCOMPLETE_LIST
      ..attributes[Html0.ARIA_EXPANED] = "false";
    _formElement.labelInputText = lLookupLabel();
    input.name = name;
    _formElement.id = createId(idPrefix, name);
    element.id = "${_formElement.id}-lookup";

    if (typeahead) { // show input with search icon
      input.onKeyUp.listen(onInputKeyUp);
      input.onFocus.listen((Event e) {
        _lookupMenu.classes.remove(LVisibility.C_HIDE);
      });
    } else {
      _pillContainer = new DivElement()
        ..classes.add(LPill.C_PILL_CONTAINER);

      if (select == DATA_SELECT_SINGLE) {
        input.classes.add(LVisibility.C_HIDE);
        _pillContainer.classes.add(LVisibility.C_SHOW);
        // _formElement._elementControl.insertBefore(_pillContainer, input);
        _formElement._elementControl.append(_pillContainer); // needs to be before input
        _formElement._elementControl.append(input);
      } else { /// Multi
        _formElement.element.append(_pillContainer);
      }
    }
    // div .lookup
    // - div .form-element ... label...
    // - div .menu
    // -- ul
    element.append(_formElement.element);
    element.append(_lookupMenu);
    _lookupMenu.append(_lookupList);
    //
    _lookupMenu.classes.add(LVisibility.C_AUTO_VISIBLE);
    _lookupMenu.onKeyDown.listen(onMenuKeyDown);
  } // LLookup


  LLookup.base(String name, {String idPrefix})
    : this(name, idPrefix:idPrefix, typeahead: true);

  LLookup.single(String name, {String idPrefix})
    : this(name, idPrefix:idPrefix, typeahead: false);

  LLookup.multi(String name, {String idPrefix})
    : this(name, idPrefix:idPrefix, select:DATA_SELECT_MULTI, typeahead: false);

  /// Set Lookup Attributes
  void _setAttributes(String select, String scope, bool typeahead) {
    element.attributes["data-select"] = select;
    element.attributes["data-scope"] = scope;
    element.attributes["dara-typeahead"] = typeahead.toString();
  }
  // data-select single|multi
  bool get multiple => element.attributes["data-select"] == DATA_SELECT_MULTI;
  // data-typeahead
  bool get typeahead => element.attributes["data-typeahead"] == "true";
  // data-scope single
  bool get singleScope => element.attributes["data-scope"] == "single";

  /// Editor Id
  String get id => input.id;
  void set id (String newValue) {
    _formElement.id = newValue;
    element.id = "${_formElement.id}-lookup";
  }
  void updateId(String idPrefix) {
    id = createId(idPrefix, name);
  }

  String get name => input.name;
  String get type => input.type;

  String get label => _formElement.label;
  void set label (String newValue) {
    _formElement.label = newValue;
  }
  void set help (String newValue) {
    _formElement.help = newValue;
  }
  String get help => _formElement.help;
  void set hint (String newValue) {
    _formElement.hint = newValue;
  }
  String get hint => _formElement.hint;

  /// Small Editor/Label
  void set small (bool newValue){}


  String get value => input.value;
  void set value (String newValue) {
    input.value = newValue;
    // TODO validate
  }

  String get defaultValue => null; // ignore
  void set defaultValue (String newValue) {
  }

  bool get required => input.required;
  void set required (bool newValue) {
    input.required = newValue;
  }

  bool get readOnly => input.readOnly;
  void set readOnly (bool newValue) {
    input.readOnly = newValue;
  }

  bool get disabled => input.disabled;
  void set disabled (bool newValue) {
    input.disabled = newValue;
  }

  bool get spellcheck => input.spellcheck;
  void set spellcheck (bool newValue) {
    input.spellcheck = newValue;
  }

  bool get autofocus => input.autofocus;
  void set autofocus (bool newValue) {
    input.autofocus = newValue;
  }

  String get title => _formElement.title;
  void set title (String newValue) {
    _formElement.title = title;
  }

  /// Validation state from Input
  ValidityState get inputValidationState => input.validity;
  /// Validation Message from Input
  String get inputValidationMsg => input.validationMessage;



  /// Get options
  List<OptionElement> get options {
    List<OptionElement> list = new List<OptionElement>();
    for (LLookupItem item in _lookupItemList) {
      list.add(item.asOption());
    }
    return list;
  }
  /// Set options
  void set options (List<OptionElement> list) {
    for (OptionElement oe in list) {
      LLookupItem item = new LLookupItem.fromOption(oe);
      addLookupItem(item);
    }
  }
  /// Add Option
  void addOption(OptionElement oe) {
    addLookupItem(new LLookupItem.fromOption(oe));
  }

  /// Option Count
  int get length => _lookupItemList.length;

  /// Selected count
  int get selectedCount {
    String vv = value;
    return vv == null || vv.isEmpty ? 0 : 1;
  }


  /// Get select option list
  List<SelectOption> get selectOptionList {
    List<SelectOption> retValue = new List<SelectOption>();
    for (LLookupItem item in _lookupItemList) {
      retValue.add(item.asSelectOption());
    }
    return retValue;
  }
  /// Add Option
  void addSelectOption(SelectOption op) {
    LLookupItem item = new LLookupItem.fromSelectOption(op);
    addLookupItem(item);
  }

  /// Add Option
  void addDOption(DOption option) {
    LLookupItem item = new LLookupItem(option);
    addLookupItem(item);
  }

  /// Set Lookup Items
  void set lookupItems (List<LLookupItem> itemList) {
    clearOptions();
    for (LLookupItem item in itemList) {
      addLookupItem(item);
    }
  }

  /// Clear Items
  void clearOptions() {
    _lookupItemList.clear();
    _lookupList.children.clear();
  }

  /// add Lookup Item
  void addLookupItem(LLookupItem item) {
    _lookupItemList.add(item);
    _lookupList.append(item.element);
    item.onClick.listen(onItemClick);
  }


  void onMenuKeyDown(KeyboardEvent evt) {
    int kc = evt.keyCode;
    Element telement = evt.target;
    String tvalue = telement.attributes[Html0.DATA_VALUE];
    _log.fine("onMenuKeyDown ${kc} ${tvalue}");
  }
  void onInputKeyUp(KeyboardEvent evt) {
    int kc = evt.keyCode;
    String match = input.value;
    _log.fine("onInputKeyUp ${kc} ${match}");
    if (kc == KeyCode.ESC) {
      showResults = false;
    } else {
      lookupUpdateList(false);
    }
  }

  /// update lookup list and display
  void lookupUpdateList(bool showAll) {
    String restriction = input.value;
    RegExp exp = null;
    if (!showAll && restriction.isNotEmpty) {
      exp = LUtil.createRegExp(restriction);
    }
    int count = 0;
    for (LLookupItem item in _lookupItemList) {
      if (exp == null) {
        item.show = true;
        item.labelHighlightClear();
        //item.exampleUpdate();
        count++;
      }
      else if (item.labelHighlight(exp) || item.descriptionHighlight(exp)) {
        item.show = true;
        //item.exampleUpdate();
        count++;
      }
      else { // no match
        item.show = false;
      }
    }
    if (count == 0 && _lookupItemList.isNotEmpty) {
      input.setCustomValidity("No matching options"); // TODO Trl
    } else {
      input.setCustomValidity("");
    }
    //doValidate();
    _log.fine("lookupUpdateList ${name} '${restriction}' ${count} of ${_lookupItemList.length}");
    showResults = true;
  } // lookupUpdateList

  /**
   * Clicked on Item
   */
  void onItemClick(MouseEvent evt) {
    evt.preventDefault();
    Element telement = evt.target;
    String tvalue = telement.attributes[Html0.DATA_VALUE];
    LLookupItem selectedItem = null;
    for (LLookupItem item in _lookupItemList) {
      if (item.value == tvalue) {
        selectedItem = item;
        break;
      }
    }
    // Input has aria-activedescendant attribute whose value is the id of the highlighted results list option, no value if nothing's highlighted in the list
    if (selectedItem == null) {
      input.value = "";
      input.attributes[Html0.DATA_VALUE] = "";
      input.attributes[Html0.ARIA_ACTIVEDECENDNT] = "";
      if (editorChange != null)
        editorChange(name, null, null, null);
    } else {
      input.value = selectedItem.label;
      input.attributes[Html0.DATA_VALUE] = selectedItem.value;
      input.attributes[Html0.ARIA_ACTIVEDECENDNT] = selectedItem.value;

      if (editorChange != null)
        editorChange(name, selectedItem.value, null, selectedItem);
    }
    showResults = false;
    for (LLookupItem item in _lookupItemList) { // remove restrictions
      item.show = true;
      item.labelHighlightClear();
    }
  } // onItemClick



  /// Show Popup
  void set showResults (bool newValue) {
    input.attributes[Html0.ARIA_EXPANED] = newValue.toString();
    if (newValue) {
      _lookupMenu.classes.remove(LVisibility.C_HIDE);
    } else {
      _lookupMenu.classes.add(LVisibility.C_HIDE);
      new Timer(new Duration(seconds: 5), () { // focus somewhere else
        _lookupMenu.classes.remove(LVisibility.C_HIDE);
      });
    }
  } // showResults


  void updateStatusValidationState() {
  }


  static String lLookupLabel() => Intl.message("Lookup", name: "lLookupLabel", args: []);

} // LLookup

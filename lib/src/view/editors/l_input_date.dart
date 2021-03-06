/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3  http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://lightningdart.com
 */

part of lightning_dart;

/**
 * Date Editor
 * Html5 Support:
 * - Chrome, Edge iOS
 * - NOT: IE, FF, Safari
 * http://caniuse.com/#search=date
 */
class LInputDate
    extends LInput {

  static final Logger _log = new Logger("LInputDate");

  /// Synonym date/time format
  static DateFormat synonymFormat;

  /// Min width of date editor
  static const String MIN_WIDTH = "150px";
  /// Min width of html5 date editor
  static const String MIN_WIDTH_HTML5 = "190px";

  /// The Icon
  final LIcon _iconRight = new LIconUtility(LIconUtility.EVENT);

  /// Date Formatter
  DateFormat _formatter;
  ///
  String _invalidInput = "??";
  String _type = EditorI.TYPE_DATE;

  /**
   * Date Editor
   */
  LInputDate(String name, {String type:EditorI.TYPE_DATE, String idPrefix, bool inGrid:false})
      : super(name, type, idPrefix:idPrefix, inGrid:inGrid) {
    _type = type;
    _initDate(type);
  }

  LInputDate.from(DataColumn dataColumn, String type, {String idPrefix, bool inGrid:false})
      : super.from(dataColumn, type, idPrefix:idPrefix, inGrid:inGrid) {
    _type = type;
    _initDate(type);
  }

  @override
  void _initEditor(String type) {
    input.onChange.listen(onInputChange);
    input.onKeyUp.listen(onInputKeyUp);
  }
  /// Init Date
  void _initDate(String type) {
    if (inGrid) {
      input.classes.add(LInput.C_W140); // 132 min
    }
    if (html5) {
      input.type = _validateType(_type);
    } else {
      input.type = EditorI.TYPE_TEXT;
    }
    if (type == EditorI.TYPE_DATETIME) {
      _formatter = ClientEnv.dateFormat_ymd_hm;
      _invalidInput = lInputDateInvalidInputDateTime();
      _type = EditorI.TYPE_DATETIME;
    } else if (type == EditorI.TYPE_TIME) {
      _formatter = ClientEnv.dateFormat_hm;
      _invalidInput = lInputDateInvalidInputTime();
      _type = EditorI.TYPE_TIME;
    } else {
      _formatter = ClientEnv.dateFormat_ymd; //  new DateFormat.yMd(ClientEnv.localeName);
      _invalidInput = lInputDateInvalidInputDate();
      _type = EditorI.TYPE_DATE;
    }
    isUtc = _type == EditorI.TYPE_DATE;
  } // initDate

  /// use native calendar
  void set html5 (bool newValue) {
    super.html5 = newValue;
    _initDate(_type);
  }

  /// use Utc - true for Date
  bool isUtc = true;

  @override
  LIcon getIconRight() => _iconRight;

  /**
   * Value - (milliseconds)
   */
  @override
  String get value {
    String v = input.value;
    return parse(v, false); // don't set validity
  } // value

  /// Set new value
  @override
  void set value(String newValue) {
    _valueDate = null;
    String display = renderSync(newValue, true);
    input.value = display;
    // check
    String x = value; // read back
    if (newValue != null && newValue != x) {
      if (type == EditorI.TYPE_DATE) {
        _log.config("setValue ${name}=${newValue} <> ${x} -- ${DataUtil.asDateString(newValue, html5, isUtc)} <> display=${display} html5=${html5} utc=${isUtc}");
      } else if (type == EditorI.TYPE_DATETIME) {
        _log.config("setValue ${name}=${newValue} <> ${x} -- ${DataUtil.asDateTimeString(newValue, html5)} <> display=${display} ${html5 ? 'html5' : ''}");
      } else if (type == EditorI.TYPE_TIME) {
        _log.config("setValue ${name}=${newValue} <> ${x} -- ${DataUtil.asTimeString(newValue, data, html5)} <> display=${display} ${html5 ? 'html5' : ''}");
      }
      //  updateData(x); // actual parsed value
    }
  } // value

  @override
  void set valueOriginal(String newValue) {
    if (_isEmpty(newValue)) {
      super.valueOriginal = newValue;
    } else {
      int ms = int.parse(newValue, onError: (String value) {
        return 0; // variable
      });
      if (ms == 0) {
        ms = DataUtil.parseDateVariable(newValue, type);
        if (ms == 0)
          _valueOriginal = null;
        else
          _valueOriginal = ms.toString();
      } else {
        _valueOriginal = newValue;
      }
      defaultValue = renderSync(newValue, false); // variables;
    }
  } // valueOriginal

  /// get value as date
  DateTime get valueAsDate {
    if (_valueDate == null) {
      String v = input.value;
      parse(v, false); // don't set validity
    }
    return _valueDate;
  } // valueAsDate

  /// set value as date
  void set valueAsDate (DateTime newValue) {
    _valueDate = newValue;
    if (newValue == null) {
      value = null;
    } else {
      value = newValue.millisecondsSinceEpoch.toString();
    }
  } // valueAsDate

  /**
   * Rendered Value (different from value)
   */
  @override
  String get valueDisplay {
    return input.value;
  }
  /// is the rendered [valueDisplay] different from the [value]
  @override
  bool get isValueDisplay {
    return true;
  }

  /**
   * Render [value] in ms for display or ""
   */
  String renderSync(String valueMs, bool setValidity) {
    if (setValidity)
      input.setCustomValidity("");
    if (_isEmpty(valueMs) || valueMs == "0")
      return "";
    String display = null;
    if (type == EditorI.TYPE_DATE) {
      display = DataUtil.asDateString(valueMs, html5, isUtc); // UTC
    } else if (type == EditorI.TYPE_DATETIME) {
      display = DataUtil.asDateTimeString(valueMs, html5); // local
    } else if (type == EditorI.TYPE_TIME) {
      display = DataUtil.asTimeString(valueMs, data, html5); // local
    }
    if (display == null || display.isEmpty) {
      if (setValidity)
        input.setCustomValidity("${lInputDateInvalidValue()}=${valueMs}");
      _log.config("formatTime error value=${valueMs}");
      return valueMs; // invalid
    }
    return display == null ? "" : display;
  } // renderSync
  /// render [newValue]
  @override
  Future<String> render(String newValue, bool setValidity) {
    Completer<String> completer = new Completer<String>();
    completer.complete(renderSync(newValue, setValidity));
    return completer.future;
  } // render

  /// parse manually entered display [newValue] to ms or empty string
  String parse(String newValue, bool setValidity) {
    if (setValidity)
      input.setCustomValidity("");
    if (_isEmpty(newValue))
      return ""; // incomplete date string
    _valueDate = null;
    if (type == EditorI.TYPE_DATE) {
      _valueDate = DataUtil.asDate(newValue, html5, isUtc, logWarning:false); // UTC
    } else if (type == EditorI.TYPE_DATETIME) {
      _valueDate = DataUtil.asDateTime(newValue, html5, logWarning:false); // local
    } else if (type == EditorI.TYPE_TIME) {
      _valueDate = DataUtil.asTime(newValue, data, html5, logWarning:false); // local
    }
    if (_valueDate == null) {
      if (setValidity)
        input.setCustomValidity("${_invalidInput}=${newValue} [${_formatter.pattern}]");
      return newValue; // invalid
    }
    int time = _valueDate.millisecondsSinceEpoch;
    return time.toString();
  } // render
  DateTime _valueDate = null;


  @override
  String get type {
    return _type;
  }

  @override
  void set readOnly (bool newValue) {
    input.readOnly = newValue;
    if (newValue) {
      input.type = EditorI.TYPE_TEXT; // don't show dd/mm/yyyy when empty
    } else {
      if (html5)
        input.type = _validateType(_type);
    }
  }

  @override
  String get defaultValue {
    String userInput = input.defaultValue;
    return parse(userInput, false);
  }
  @override
  void set defaultValue(String newValue) {
    if (_isEmpty(newValue) || newValue == "0") {
      input.defaultValue = "";
    } else {
      input.defaultValue = newValue;
    }
  } // defaultValue

  /// set value alternatives
  @override
  bool setValueSynonym(String newValue) {
    if (newValue == null || newValue.isEmpty) {
      value = newValue;
      return true;
    }
    DateTime dt = null;
    if (synonymFormat != null) {
      try {
        dt = synonymFormat.parseLoose(newValue);
        value = dt.millisecondsSinceEpoch.toString();
        return true;
      } catch (error) {}
    }
    try {
      // 2016-03-27T17:00:00.000
      dt = DateTime.parse(newValue);
      value = dt.millisecondsSinceEpoch.toString();
      return true;
    } catch (error) {}

    dt = DataUtil.asDate(newValue, false, false, logWarning:false); // UTC
    if (dt == null) {
      dt = DataUtil.asDateTime(newValue, false, logWarning: false); // local
      if (dt == null) {
        dt = DataUtil.asTime(newValue, data, false, logWarning: false); // local
      }
    }
    if (dt == null) {
      return false;
    }
    value = dt.millisecondsSinceEpoch.toString();
    return true;
  } // setValueSynonym


  /// Is the value changed from original
  @override
  bool get changed {
    String v = value;
    if (v == null) v = "";
    String o = _valueOriginal == null ? "" : _valueOriginal;
    if (v != o) {
      // 1424750049000
      if (o.length == 13 && v.length == 13) {
        o = o.substring(0, 10); // remove ms
        v = v.substring(0, 10);
      }
    }
    return v != o;
  } // isChanged



  /// translation
  static String lInputDateInvalidValue() => Intl.message("Invalid value", name: "lInputDateInvalidValue");
  static String lInputDateInvalidInputDate() => Intl.message("Invalid input for date", name: "lInputDateInvalidInputDate");
  static String lInputDateInvalidInputTime() => Intl.message("Invalid input for time", name: "lInputDateInvalidInputTime");
  static String lInputDateInvalidInputDateTime() => Intl.message("Invalid input for date time", name: "lInputDateInvalidInputDateTime");

} // LInputDate

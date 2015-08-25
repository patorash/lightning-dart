/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of biz_fabrik_base;

/**
 * Data Type Functionality + Mapping
 */
class DataTypeUtil {

  static final Logger _log = new Logger("DataTypeUtil");

  /// Data Type FK
  static bool isFk(DataType dt) {
    return dt == DataType.FK || dt == DataType.USER || dt == DataType.TENANT;
  }
  /// Data Type underlying String
  static bool isString(DataType dt) {
    return dt == DataType.STRING || dt == DataType.TEXT || dt == DataType.EMAIL
        || dt == DataType.IM || dt == DataType.PHONE
        || dt == DataType.PICK || dt == DataType.PICKAUTO || dt == DataType.PICKCHOICE
        || dt == DataType.PICKMULTI || dt == DataType.PICKMULTICHOICE
        || dt == DataType.TAG || dt == DataType.TIMEZONE
        || dt == DataType.URL;
  }
  /// Data Type Number
  static bool isNumber(DataType dt) {
    return (dt == DataType.INT) || (dt == DataType.NUMBER) || (dt == DataType.AMOUNT)
        || (dt == DataType.CURRENCY) || (dt == DataType.QUANTITY)
        || (dt == DataType.DECIMAL) || (dt == DataType.RATING);
  }
  /// Data Type Number
  static bool isInt(DataType dt) {
    return (dt == DataType.INT) || (dt == DataType.RATING);
  }
  /// Data Type Date
  static bool isDate(DataType dt) {
    return (dt == DataType.DATE) || (dt == DataType.DATETIME) || (dt == DataType.TIME);
  }
  /// Data Type Pick
  static bool isPick(DataType dt) {
    return dt == DataType.PICK || dt == DataType.PICKAUTO || dt == DataType.PICKCHOICE
        || dt == DataType.PICKMULTI || dt == DataType.PICKMULTICHOICE;
  }

  /// Data Type Alignment
  static bool isRightAligned(DataType dt) {
    return isNumber(dt) || dt == DataType.DURATION;
  }
  /// Data Type Alignment
  static bool isCenterAligned(DataType dt) {
    return dt == DataType.BOOLEAN;
  }
  /// Data Type w/o Editor
  static bool isNoEditor(DataType dt) {
    return dt == DataType.DATA;
  }

  /// Default Editor width or 0
  static int getEditorWidth(DataType dt) {
    if (dt == DataType.DATE)
      return 170;
    if (dt == DataType.DATETIME)
      return 240;
    if (dt == DataType.TIME)
      return 135;
    if (dt == DataType.TIMEZONE)
      return 280;
    return 0;
  } // getEditorWidth



  /**
   * Get DataType from html input [editorType]
   * returns TEXT if not found
   */
  static DataType getDataTypeFromEditorType(String editorType) {
    _init();
    for (DataTypeUtil dtu in _dataTypes) {
      if (editorType == dtu.editorType)
        return dtu.dataType;
    }
    return DataType.TEXT;
  } // getDataTypeFromEditorType

  /**
   * Find Data Type for Column in Table
   */
  static DataType getDataType(DTable table, String columnId, String columnName) {
    if (table != null) {
      for (DColumn col in table.columnList) {
        if ((columnId != null && columnId == col.columnId)
            || (columnName != null && columnName == col.name))
          return col.dataType;
      }
    }
    return null;
  } // getDataType

  static String getInputType (DataType dataType) {
    // TODO
    return EditorI.TYPE_TEXT;
  }


  /**
   * Create Editor for [tableColumn] - fallback string/text
   * register change notification with [data]
   * (see also EditorI.create)
   */
//  static EditorI createEditor(String name, String idPrefix,
//      DTable table, DColumn tableColumn, DataRecord data, bool inGrid) {
//    _init();
//    DataTypeUtil dtu = getDataTypeUtil(tableColumn.dataType, inGrid);
//    if (dtu == null) {
//      dtu = _STRING;
//    }
//    EditorI editor = _createEditorStatusAction(name, idPrefix, table, tableColumn, inGrid);
//    if (editor == null)
//      editor = dtu._createEditor(name, idPrefix, tableColumn, inGrid);
//    if (data != null) {
//      editor.data = data;
//      editor.editorChange = data.onEditorChange;
//      editor.editorKeyUp = data.onEditorChange;
//    }
//    return editor;
//  } // createEditor
  /// Create Editor or StatusAction
//  static EditorI _createEditorStatusAction(String name, String idPrefix,
//      DTable table, DColumn column, bool inGrid) {
//    if (column.name == "TrxStatus") {
//      EditorStatusAction editor = new EditorStatusAction(name, idPrefix: idPrefix, inGrid: inGrid);
//      if (column.hasColumnSize())
//        editor.maxlength = column.columnSize;
//      if (column.hasDefaultValue())
//        editor.defaultValue = column.defaultValue;
//
//      // selects
//      if (column.pickValueList.isNotEmpty) {
//      }
//      // detail info
//      editor.table = table;
//      editor.column = column;
//      return editor;
//    } else if (column.name == "TrxAction") {
//      EditorStatusAction editor = new EditorStatusAction(name, idPrefix: idPrefix, inGrid: inGrid);
//    }
//    return null;
//  }

  /**
   * Create Editor for [property]
   * - create range column when [rangeTo]
   */
//  static EditorI createEditorProperty(DProperty property, String idPrefix, DataRecord data, bool inGrid, bool rangeTo) {
//    _init();
//    DColumn tableColumn = toColumn(property, rangeTo);
//    DataTypeUtil dtu = getDataTypeUtil(tableColumn.dataType, inGrid);
//    if (dtu == null)
//      dtu = _STRING;
//    //
//    EditorI editor = dtu._createEditor(tableColumn.name, idPrefix, tableColumn, inGrid);
//    if (data != null) {
//      editor.data = data;
//      editor.editorChange = data.onEditorChange;
//      editor.editorKeyUp = data.onEditorChange;
//    }
//    return editor;
//  } // createEditorProperty


  /// Table Column from [property]
  static DColumn toColumn(DProperty property, bool rangeTo) {
    // property.isRange;
    // property.seqNo;

    DColumn tableColumn = new DColumn();
    if (property.hasId())
      tableColumn.columnId = property.id;
    if (property.hasName()) {
      tableColumn.name = property.name;
      if (rangeTo)
        tableColumn.name = property.name + "To";
    }
    if (property.hasLabel())
      tableColumn.label = property.label;
    if (property.hasDescription())
      tableColumn.description = property.description;
    if (property.hasHelp())
      tableColumn.help = property.help;

    if (property.hasIsMandatory())
      tableColumn.isMandatory = property.isMandatory;
    if (property.hasIsReadOnly())
      tableColumn.isReadOnly = property.isReadOnly;

    if (property.hasDataType())
      tableColumn.dataType = property.dataType;
    if (property.hasColumnSize())
      tableColumn.columnSize = property.columnSize;
    if (property.hasDecimalDigits())
      tableColumn.decimalDigits = property.decimalDigits;
    if (property.hasDefaultValue())
      tableColumn.defaultValue = property.defaultValue;
    if (rangeTo && property.hasDefaultValueTo())
      tableColumn.defaultValue = property.defaultValueTo;

    if (property.hasPickListName())
      tableColumn.pickListName = property.pickListName;
    for (DOption option in property.pickValueList) {
      tableColumn.pickValueList.add(option);
    }
    if (property.hasFormatMask())
      tableColumn.formatMask = property.formatMask;
    if (property.hasValFrom())
      tableColumn.valFrom = property.valFrom;
    if (property.hasValTo())
      tableColumn.valTo = property.valTo;
    //
    return tableColumn;
  } // toColumn

  /**
   * Get (first) Data Type Info for [dataType]
   */
  static DataTypeUtil getDataTypeUtil(DataType dataType, bool inGrid) {
    _init();
    DataType dt = dataType;
    if (inGrid) {
        if (dataType == DataType.PICKCHOICE)
          dt = DataType.PICK;
        else if (dataType == DataType.PICKMULTICHOICE)
          dt = DataType.PICKMULTI;
    }
    for (DataTypeUtil dtu in _dataTypes) {
      if (dt == dtu.dataType)
        return dtu;
    }
    return null;
  } // getDataTypeUtil


  /// initialize
  static void _init() {
    if (_dataTypes != null)
      return;
    _dataTypes = new List<DataTypeUtil>();
    // icons see: Icon0.dataType()
//    _STRING =      new DataTypeUtil(DataType.STRING,    EditorI.TYPE_TEXT,      EditorInput.ICON_STRING);
//    _dataTypes.add(_STRING);
//    _dataTypes.add(new DataTypeUtil(DataType.ADDRESS,   EditorI.TYPE_ADDRESS,   EditorAddress.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.AMOUNT,    EditorI.TYPE_DECIMAL,   EditorNumber.ICON_AMOUNT));
//    _dataTypes.add(new DataTypeUtil(DataType.BOOLEAN,   EditorI.TYPE_CHECKBOX,  "icon-checkmark4"));
//    _dataTypes.add(new DataTypeUtil(DataType.CODE,      EditorI.TYPE_CODE,      EditorCode.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.COLOR,     EditorI.TYPE_COLOR,     "icon-palette"));
//    _dataTypes.add(new DataTypeUtil(DataType.CURRENCY,  EditorI.TYPE_DECIMAL,   EditorNumber.ICON_CURRENCY));
//    _dataTypes.add(new DataTypeUtil(DataType.DATA,      EditorI.TYPE_FILE,      EditorFile.ICON_DATA));
//    _dataTypes.add(new DataTypeUtil(DataType.DATE,      EditorI.TYPE_DATE,      EditorDate.ICON_DATE));
//    _dataTypes.add(new DataTypeUtil(DataType.DATETIME,  EditorI.TYPE_DATETIME,  EditorDate.ICON_DATETIME));
//    _dataTypes.add(new DataTypeUtil(DataType.DECIMAL,   EditorI.TYPE_DECIMAL,   EditorNumber.ICON_DECIMAL));
//    _dataTypes.add(new DataTypeUtil(DataType.DURATION,  EditorI.TYPE_DURATION,  EditorDuration.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.EMAIL,     EditorI.TYPE_EMAIL,     "icon-envelop3"));
//    _dataTypes.add(new DataTypeUtil(DataType.FK,        EditorI.TYPE_FK,        EditorFk.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.GEO,       EditorI.TYPE_ADDRESS,   EditorAddress.ICON_GEO));
//    _dataTypes.add(new DataTypeUtil(DataType.IM,        EditorI.TYPE_EMAIL,     "icon-at-sign"));
//    _dataTypes.add(new DataTypeUtil(DataType.IMAGE,     EditorI.TYPE_FILE,      EditorFile.ICON_IMAGE));
//    _dataTypes.add(new DataTypeUtil(DataType.INT,       EditorI.TYPE_NUMBER,    EditorNumber.ICON_INT));
//    _dataTypes.add(new DataTypeUtil(DataType.NUMBER,    EditorI.TYPE_DECIMAL,   EditorNumber.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.PASSWORD,  EditorI.TYPE_PASSWORD,  "icon-key5"));
//    _dataTypes.add(new DataTypeUtil(DataType.PHONE,     EditorI.TYPE_TEL,       "icon-phone2"));
//    _dataTypes.add(new DataTypeUtil(DataType.PICK,      EditorI.TYPE_SELECT,    EditorSelect.ICON_PICK));
//    _dataTypes.add(new DataTypeUtil(DataType.PICKAUTO,  EditorI.TYPE_SELECTAUTO, EditorSelect.ICON_PICKAUTO));
//    _dataTypes.add(new DataTypeUtil(DataType.PICKCHOICE, EditorI.TYPE_SELECTCHOICE, EditorSelect.ICON_PICKCHOICE));
//    _dataTypes.add(new DataTypeUtil(DataType.PICKMULTI, EditorI.TYPE_SELECT,    EditorSelect.ICON_PICKMULTI));
//    _dataTypes.add(new DataTypeUtil(DataType.PICKMULTICHOICE, EditorI.TYPE_SELECTCHOICE, EditorSelect.ICON_PICKMULTICHOICE));
//    _dataTypes.add(new DataTypeUtil(DataType.QUANTITY,  EditorI.TYPE_DECIMAL,   EditorNumber.ICON_QUANTITY));
//    _dataTypes.add(new DataTypeUtil(DataType.RATING,    EditorI.TYPE_RANGE,     EditorRange.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.TAG,       EditorI.TYPE_TAG,       EditorTag.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.TENANT,    EditorI.TYPE_FK,        EditorFk.ICON_TENANT));
//    _dataTypes.add(new DataTypeUtil(DataType.TEXT,      EditorI.TYPE_TEXTAREA,  EditorTextArea.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.TIME,      EditorI.TYPE_TIME,      EditorDate.ICON_TIME));
//    _dataTypes.add(new DataTypeUtil(DataType.TIMEZONE,  EditorI.TYPE_TIMEZONE,  EditorTimezone.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.URL,       EditorI.TYPE_URL,       EditorUrl.ICON));
//    _dataTypes.add(new DataTypeUtil(DataType.USER,      EditorI.TYPE_FK,        EditorFk.ICON_USER));
  } // init
  static List<DataTypeUtil> _dataTypes;
//  static DataTypeUtil _STRING;


  /// Biz Data Type
  final DataType dataType;
  /// Html type +
  final String editorType;
  /// Icon Class
  final String iconClass;
  /// Data Type Util
  DataTypeUtil(DataType this.dataType, String this.editorType, String this.iconClass) {
  }

  /**
   * Create Editor for DataType
   */
//  EditorI _createEditor(String name, String idPrefix, DColumn column, bool inGrid) {
//    DataType dt = column.dataType;
//    bool multiple = dt == DataType.PICKMULTI || dt == DataType.PICKMULTICHOICE;
//    EditorI editor = EditorI.create(name, type: editorType, idPrefix: idPrefix, multiple: multiple, inGrid: inGrid);
//
//    if (column.hasIsMandatory())
//      editor.required = column.isMandatory;
//    if (column.hasIsReadOnly())
//      editor.readOnly = column.isReadOnly;
//
//    if (column.hasColumnSize())
//      editor.maxlength = column.columnSize;
//    if (column.hasDefaultValue())
//      editor.defaultValue = column.defaultValue;
//
//    if (column.hasFormatMask())
//      editor.pattern = column.formatMask;
//
//    if (column.hasValFrom() && editor is EditorInput)
//      editor.min = column.valFrom;
//    if (column.hasValTo() && editor is EditorInput)
//      editor.max = column.valTo;
//
//    // selects
//    if (column.pickValueList.isNotEmpty) {
//      if (editor is EditorDatalist) {
//        (editor as EditorDatalist).setOptionList(column.pickValueList, column.isMandatory && !multiple);
//      }
//      else if (editor is EditorDatalistAuto) {
//        (editor as EditorDatalistAuto).setOptionList(column.pickValueList);
//      }
//      else {
//        _log.warning("createEditor picklist for ${editor.type}");
//      //editor.options = column.pickValueList;
//      }
//    }
//
//    // detail info
//    editor.column = column;
//    return editor;
//  } // create Editor

} // DataTypeUtil
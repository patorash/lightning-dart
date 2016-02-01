/*
 * Copyright (c) 2016 Accorto, Inc. All Rights Reserved
 * License: GPLv3  http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://lightningdart.com
 */

part of lightning_graph;

/**
 * Graph Element
 * with Form and Panel
 */
class GraphElement {

  static const String _NAME_BY = "by";
  static const String _NAME_WHAT = "what";
  static const String _NAME_BYDATE = "date";
  static const String _NAME_PERIOD = "period";

  static const String _VALUE_NONE = "-";

  static final Logger _log = new Logger("GraphElement");

  Element element = new Element.section();

  final Datasource datasource;
  DTable get table => datasource.ui.table;
  List<DRecord> get records => datasource.recordList;

  LPicklist _whatPickList;
  LPicklist _byPickList;
  LPicklist _datePickList;
  LPicklist _periodPickList;
  GraphPanel _graphPanel;

  /**
   * Graph Element - call [init] explicitly
   */
  GraphElement(Datasource this.datasource) {
  } // GraphElement

  /// Initialize Element
  void init() {
    element
      ..id = LComponent.createId("ge", table.name)
      ..style.minHeight = "300px";

    LForm form = _initForm(element.id);
    element.append(form.element);

    _graphPanel = new GraphPanel(element.id, table.name);
    element.append(_graphPanel.element);
  }

  /**
   * Initialize Form
   */
  LForm _initForm(String id) {
    LForm form = new LForm.inline("f", idPrefix: id);
    form.formRecordChange = onFormRecordChange;

    _whatPickList = new LPicklist(_NAME_WHAT, idPrefix: id)
      ..label = StatCalc.statCalcWhat()
      ..small = true;
    _whatPickList.addDOption(new DOption()
      ..value = StatCalc.COUNT_COLUMN_NAME
      ..label = StatCalc.statCalcCount());
    _whatPickList.value = StatCalc.COUNT_COLUMN_NAME;
    form.addEditor(_whatPickList);

    _byPickList = new LPicklist(_NAME_BY, idPrefix: id)
      ..label = StatCalc.statCalcBy()
      ..small = true
      ..placeholder = StatCalc.statCalcByTitle();
    //_byPickList.addDOption(new DOption()
    //  ..value = _VALUE_NONE
    //  ..label = StatCalc.statCalcByNone());
    //_byPickList.value = _VALUE_NONE;
    form.addEditor(_byPickList);

    _datePickList = new LPicklist(_NAME_BYDATE, idPrefix: id)
      ..label = StatCalc.statCalcDate()
      ..small = true;
    _datePickList.addDOption(new DOption()
      ..value = _VALUE_NONE
      ..label = StatCalc.statCalcDateNone());
    _datePickList.value = _VALUE_NONE;
    form.addEditor(_datePickList);

    _periodPickList = new LPicklist(_NAME_PERIOD, idPrefix: id)
      ..title = StatCalc.statCalcByPeriod()
      ..small = true;
    form.addEditor(_periodPickList);
    _periodPickList.addDOption(new DOption()
      ..value = ByPeriod.Day.toString()
      ..label = StatPoint.statByPeriodDay());
    _periodPickList.addDOption(new DOption()
      ..value = ByPeriod.Week.toString()
      ..label = StatPoint.statByPeriodWeek());
    _periodPickList.addDOption(new DOption()
      ..value = ByPeriod.Month.toString()
      ..label = StatPoint.statByPeriodMonth());
    _periodPickList.addDOption(new DOption()
      ..value = ByPeriod.Quarter.toString()
      ..label = StatPoint.statByPeriodQuarter());
    _periodPickList.addDOption(new DOption()
      ..value = ByPeriod.Year.toString()
      ..label = StatPoint.statByPeriodYear());
    _periodPickList.value = ByPeriod.Week.toString();
    _periodPickList.show = false;

    // fill options
    List<DOption> whatList = new List<DOption>();
    List<DOption> byList = new List<DOption>();
    List<DOption> dateList = new List<DOption>();
    for (DColumn col in table.columnList) {
      DOption colOption = new DOption()
        ..value = col.name
        ..label = col.label;
      DataType dt = col.dataType;
      if (DataTypeUtil.isNumber(dt)) {
        whatList.add(colOption);
      } else if (DataTypeUtil.isPick(dt) || DataTypeUtil.isFk(dt)) {
        byList.add(colOption);
      } else if (DataTypeUtil.isDate(dt)) {
        dateList.add(colOption);
      }
    }
    whatList.sort(OptionUtil.compareLabel);
    for (DOption colOption in whatList)
      _whatPickList.addDOption(colOption);

    byList.sort(OptionUtil.compareLabel);
    for (DOption colOption in byList)
      _byPickList.addDOption(colOption);

    dateList.sort(OptionUtil.compareLabel);
    for (DOption colOption in dateList)
      _datePickList.addDOption(colOption);

    return form;
  } // init

  /// Selection
  void onFormRecordChange(DRecord record, DEntry columnChanged, int rowNo) {
    String what = _whatPickList.value;
    String by = _byPickList.value;
    String date = _datePickList.value;
    String period = _periodPickList.value;
    _periodPickList.show = date != null && date.isNotEmpty;
    _log.config("onFormRecordChange what=${what} by=${by} date=${date} ${period}");
    _graphPanel.reset();

    // by
    DColumn byColumn = null;
    if (by != null && by.isNotEmpty && by != _VALUE_NONE) {
      byColumn = DataUtil.findColumn(table, null, by);
      if (byColumn == null) {
        _log.info("onFormRecordChange NotFound by=${by}");
      }
      else {
        Map<String, String> keyLabelMap = new Map<String, String>();
        for (DOption option in byColumn.pickValueList) {
          keyLabelMap[option.value] = option.label;
        }
        _graphPanel.by(byColumn.name, byColumn.label, keyLabelMap);
      }
    }

    // date
    DColumn dateColumn = null;
    ByPeriod byPeriod = null;
    if (date != null && date.isNotEmpty && date != _VALUE_NONE) {
      dateColumn = DataUtil.findColumn(table, null, date);
      if (dateColumn == null) {
        _log.info("onFormRecordChange NotFound date=${by}");
      }
      byPeriod = StatPoint.findPeriod(period);
    }

    // what
    if (what == StatCalc.COUNT_COLUMN_NAME) {
      _graphPanel.calc(StatCalc.COUNT_COLUMN);
    } else {
      DColumn whatColumn = DataUtil.findColumn(table, null, what);
      if (whatColumn == null) {
        _log.info("onFormRecordChange NotFound column=${what}");
        return;
      }
      _graphPanel.calc(whatColumn);
    }
    //
    _graphPanel.calculate(records, dateColumn, byPeriod);
    _graphPanel.display();
  } // onFormRecordChange


} // GraphElement

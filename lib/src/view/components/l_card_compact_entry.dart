/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3  http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://lightningdart.com
 */

part of lightning_dart;


/**
 * Compact Card Entry (Tile)
 * - target: same api as row
 */
class LCardCompactEntry
    extends LTileGeneric {


  /// The record
  DataRecord data;

  final AppsActionTriggered recordAction;

  /**
   * Card Entry
   */
  LCardCompactEntry(String label, {Element button, AppsActionTriggered this.recordAction})
      : super(label) {
    _init(button);
  } // LCardCompactEntry

  /**
   * Card Entry
   */
  LCardCompactEntry.from(DataRecord data, {Element button, AppsActionTriggered this.recordAction})
      : super(data.record.drv) {
    this.data = data;
    element.attributes[Html0.DATA_VALUE] = data.record.recordId;
    titleLink.href = "#${data.record.urv}";
    _init(button);
  } // LCardCompactEntry

  /// add button and set action
  void _init(Element button) {
    if (button != null) {
      _heading.append(button);
    }
    if (recordAction != null) {
      titleLink.onClick.listen((MouseEvent evt) {
        evt.preventDefault();
        recordAction("record", data, null, null);
      });
    }
  } // init

  /// add action
  void addActions(List<AppsAction> actions, {Object actionReference}) {
    super.addActions(actions,
      actionReference: actionReference == null ? data : actionReference);
  }

  /**
   * [addEntry] based on UI - queryColumnList or gridColumnList
   */
  void display(UI ui, {bool useQueryColumnList:false}) {
    if (data == null)
      return;
    if (useQueryColumnList && ui.queryColumnList.isNotEmpty) {
      for (UIQueryColumn qc in ui.queryColumnList) {
        String label = qc.columnName;
        if (qc.hasColumn())
          label = qc.column.label;
        String value = "";
        DEntry entry = data.getEntry(qc.columnId, qc.columnName, false);
        if (entry != null) {
          value = DataRecord.getEntryValue(entry);
          if (entry.hasValueDisplay())
            value = entry.valueDisplay;
        }
        addEntry(label, value);
      }
    } else {
      for (UIGridColumn gc in ui.gridColumnList) {
        String label = gc.columnName;
        if (gc.hasColumn())
          label = gc.column.label;
        //
        String value = "";
        DEntry entry = data.getEntry(gc.columnId, gc.columnName, false);
        if (entry != null) {
          value = DataRecord.getEntryValue(entry);
          if (entry.hasValueDisplay())
            value = entry.valueDisplay;
        }
        addEntry(label, value);
      }
    }
  } // display

  /**
   * [addEntry] based on [record]
   */
  void displayRecord() {
    if (data == null)
      return;
    for (DEntry entry in data.record.entryList) {
      String label = entry.columnName;
      String value = DataRecord.getEntryValue(entry);
      if (entry.hasValueDisplay())
        value = entry.valueDisplay;
      addEntry(label, value);
    }
  }

} // LCardCompactEntry


/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3  http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://lightningdart.com
 */

part of lightning_ctrl;

/**
 * Table Layout Dialog
 */
class TableLayout {

  static const String _ID = "tl";

  /// Modal
  LModal modal = new LModal(_ID);
  /// Base UI
  final UI ui;
  /// Editor
  final LPicklistMulti multi = new LPicklistMulti();

  /**
   * Table Layout Dialog
   */
  TableLayout(UI this.ui, void callback()) {
    modal.large = true;
    String label = "${tableLayout()}: ${ui.table.label}";
    modal.setHeader(label, icon: new LIconUtility(LIconUtility.LAYOUT));
    // multi
    multi.selectedIndicator = LPicklistMulti.SELECTED_INDICATOR_ACTIVE;
    multi.label = tableLayoutColumns();
    modal.add(multi);
    // footer
    LButton save = modal.addFooterButtons();
    save.onClick.listen((MouseEvent evt){
      toUi();
      callback();
    });
    fromUi();
  } // TableLayout


  /// from UI to Editor
  void fromUi() {
    List<DOption> options = OptionUtil.columnGridOptions(ui);
    multi.options = options;
  } // fromUi

  /// from Editor to UI
  void toUi() {
    List<DOption> options = multi.options;
    for (UIGridColumn gc in ui.gridColumnList) {
      for (DOption option in options) {
        if (option.value == gc.column.name) {
          gc.isActive = option.isActive;
          gc.seqNo = option.seqNo;
          break;
        }
      }
    }
    // sort
    ui.gridColumnList.sort((UIGridColumn one, UIGridColumn two){
      return one.seqNo.compareTo(two.seqNo);
    });
  } // toUi


  static String tableLayout() => Intl.message("Table Layout", name: "tableLayout");
  static String tableLayoutColumns() => Intl.message("Columns", name: "tableLayoutColumns");

} // TableLayout

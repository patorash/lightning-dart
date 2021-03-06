/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart.demo;

/**
 * Demo Feature Mgt
 */
abstract class DemoFeature
    extends LComponent {


  static const String SLDS_DEV_READY = "dev ready";
  static const String SLDS_PROTOTYPE = "prototype";
  static const String SLDS_NA = "n/a";

  static const String STATUS_COMPLETE = "complete";
  static const String STATUS_PARTIAL = "partial";
  static const String STATUS_INITIAL = "initial";
  static const String STATUS_NIY = "plan";


  static const String _SLDS_URL = "https://www.lightningdesignsystem.com/components";
  static const String _SLDS_TXT = "SLDS reference";

  final DivElement element = new DivElement();

  final String id;
  final String label;
  final List<String> hints;
  final String sldsPath;
  final String sldsStatus;
  final String devStatus;
  final List<String> issues;
  final List<String> plans;

  /**
   * Feature
   */
  DemoFeature(String this.id,
      String this.label,
      {String this.sldsPath,
      String this.sldsStatus,
      String this.devStatus:STATUS_NIY,
      List<String> this.hints,
      List<String> this.issues,
      List<String> this.plans}) {
    element.id = id;

    DivElement header = new DivElement()
      ..classes.addAll([LPageHeader.C_PAGE_HEADER, LMargin.C_TOP__X_LARGE]);
    element.append(header);
    DivElement grid = new DivElement()
      ..classes.addAll([LGrid.C_GRID, LGrid.C_WRAP]);
    header.append(grid);

    // Col 1
    DivElement col1 = new DivElement()
      ..classes.addAll([LGrid.C_COL, LGrid.C_SHRINK_NONE]);
    grid.append(col1);
    HeadingElement h2 = new HeadingElement.h2()
      ..classes.add(LText.C_TEXT_HEADING__MEDIUM)
      ..text = label;
    col1.append(h2);
    LBadge slds = new LBadge(sldsStatus);
    slds.element.title ="SLDS Status";
    LBadge status = new LBadge.info(devStatus);
    status.element.title ="Development/Implementation Status";
    DivElement statusDiv = new DivElement()
      ..classes.add(LMargin.C_VERTICAL__X_SMALL)
      ..append(slds.element)
      ..append(status.element);
    col1.append(statusDiv);
    ParagraphElement ref = new ParagraphElement()
      ..classes.add(LText.C_TEXT_BODY__SMALL)
      ..text = "See: "
      ..append(createSldsLink());
    col1.append(ref);

    // Parameter
    DivElement col2 = new DivElement()
      ..classes.addAll([LGrid.C_COL]);
    grid.append(col2);
    LForm form = new LForm.stacked("options");
//      ..classes.addAll([LList.C_LIST__VERTICAL, LMargin.C_TOP__SMALL]);
    for (EditorI option in options) {
      form.addEditor(option);
    }
    // element.append(new HRElement());
    col2.append(form.element);

    // Info
    DivElement col3 = new DivElement()
      ..classes.addAll([LGrid.C_COL]);
    grid.append(col3);
    if (hints != null && hints.isNotEmpty) {
      HeadingElement h3 = new HeadingElement.h3()
        ..classes.add(LText.C_TEXT_HEADING__SMALL)
        ..text = "Hints";
      col3.append(h3);
      UListElement ulist = new UListElement()
        ..classes.add(LList.C_LIST__DOTTED);
      col3.append(ulist);
      for (String s in hints)
        ulist.append(new LIElement()..text = s);
    }
    if (issues != null && issues.isNotEmpty) {
      HeadingElement h3 = new HeadingElement.h3()
        ..classes.add(LText.C_TEXT_HEADING__SMALL)
        ..text = "Known Issues/Bugs";
      col3.append(h3);
      UListElement ulist = new UListElement()
        ..classes.add(LList.C_LIST__DOTTED);
      col3.append(ulist);
      for (String s in issues)
        ulist.append(new LIElement()..text = s);
    }
    if (plans != null && plans.isNotEmpty) {
      HeadingElement h3 = new HeadingElement.h3()
        ..classes.add(LText.C_TEXT_HEADING__SMALL)
        ..text = "Enhancement Plans";
      col3.append(h3);
      UListElement ulist = new UListElement()
        ..classes.add(LList.C_LIST__DOTTED);
      col3.append(ulist);
      for (String s in plans)
        ulist.append(new LIElement()..text = s);
    }

    // Content
    _tab = new LTab(idPrefix: id);
    DivElement wrapper = new DivElement()
      ..classes.add(LMargin.C_LEFT__SMALL);
    wrapper.append(_tab.element);
    element.append(wrapper);

    //
    if (content != null) {
      Element sc = _tab.addTab("Small", name: "s");
      sc.style.width = "480px";
      sc.style.border = "1px solid lightgray";
      Element mc = _tab.addTab("Medium", name: "m");
      mc.style.width = "768px";
      mc.style.border = "1px solid gray";
      Element lc = _tab.addTab("Large", name: "l");
      lc.style.width = "1024px";
      lc.style.border = "1px solid black";
      Element xc = _tab.addTab("Fluid", name: "x");
      xc.style.width = "calc(100% - 15px)";
      xc.style.border = "1px solid black";

      Element dc = _tab.addTab("Source", name: "d");
      ParagraphElement src = new ParagraphElement()
        ..style.fontFamily = "monospace"
        ..style.whiteSpace = "pre"
        ..text = source;
      dc.append(src);

      _tab.onTabChanged.listen(onTabChanged); // init display on tab add
      _tab.selectTabByPos(3, false);
      // fluid
    }
  } // DemoFeature
  LTab _tab;
  /// set Tab Index 0..4
  void set tabPos(int newValue) {
    _tab.selectTabByPos(newValue, false);
  }

  /// Link to Feature
  void toc(Element toc, void onlySelectedHide()) {
    AnchorElement a = new AnchorElement(href: "#${id}")
      ..text = label
      ..id = LComponent.createId("demo", id);
    a.onClick.listen((MouseEvent evt){
      evt.preventDefault();
      onlySelectedHide();
      show = true;
      element.scrollIntoView(ScrollAlignment.TOP);
    });
    //
    DivElement col = new DivElement()
      ..classes.addAll([LGrid.C_COL, LMargin.C_AROUND__SMALL])
      ..style.minWidth = "10rem"
      ..append(a);
    toc.append(col);
  }

  /// create link to SLDS
  AnchorElement createSldsLink() {
    String path = sldsPath;
    if (path == null)
      path = id;
    return new AnchorElement(href: "${_SLDS_URL}/$path")
      ..target = "slds"
      ..text = _SLDS_TXT;
  }


  LComponent get content => contentNIY;
  String get source => sourceNIY;
  List<EditorI> get options => [];


  // Tab changed
  void onTabChanged(LTab tab){
    if (_theContent == null)
      _theContent = content;
    else
      _theContent.element.remove();
    //
    _theCurrentElement = tab.currentContent;
    _theCurrentElement.append(_theContent.element);
    //
    // window.location.hash = id;
  }
  LComponent _theContent;
  Element _theCurrentElement;

  /*
  LComponent get content {
    CDiv div = new CDiv();
    return div;
  }
  String get source {
    return '''
    ''';
  }
  */

  //option changed
  void optionChanged() {
  //  _theContent.element.remove();
    _theContent = content; // new
    if (_theCurrentElement != null) {
      _theCurrentElement.children.clear();
      _theCurrentElement.append(_theContent.element);
    }
  }


  LComponent get contentNIY {
    return null;
  }
  String get sourceNIY {
    return "Not Available";
  }

  /// Generate List items
  List<ListItem> generateListItems(int count,
      {String prefix: "Item", int increment: 4, bool iconLeft: false}) {
    List<ListItem> list = new List<ListItem>();
    int no = 1;
    for (int i = 0; i < count; i++) {
      String label = "${prefix} ${no}";
      String value = "${prefix.toLowerCase()}${no}";

      LIcon leftIcon = null;
      if (iconLeft) {
        leftIcon = new LIconCustom("custom-${no}");
      }
      DOption option = new DOption()
        ..id = value
        ..value = value
        ..label = label;
      ListItem li = new ListItem(option, leftIcon, null, false);
      list.add(li);
      no += increment;
    }
    return list;
  }

} // DemoFeature

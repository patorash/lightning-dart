/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Lightning Component
 */
abstract class LComponent {

  /// Auto Id Numbering
  static int _autoId = 1;

  /// Get Element
  Element get element;

  /// Get Element Id
  String get id => element.id;

  /// append component
  void append(Element newValue) {
    element.append(newValue);
  }
  /// append component
  void add(LComponent component) {
    element.append(component.element);
  }

  /// add horizontal rule [margin] top/bottom - default 2rem
  void addHR({String margin}) {
    HRElement hr = new HRElement();
    hr.style.margin = "${margin} 0 ";
    element.append(hr);
  }
  /// add horizontal rule with .5rem top/bottom margin
  void addHrSmall() {
    addHR(margin: ".5rem");
  }
  /**
   * Set [roleAttribute] e.g. Html0.V_ROLE_MAIN
   */
  void set role (String roleAttribute) {
    element.setAttribute(Html0.ROLE, roleAttribute);
  }

  /// element data-value
  String get dataValue => element.attributes[Html0.DATA_VALUE];
  /// element data-value
  void set dataValue (String newValue) {
    element.attributes[Html0.DATA_VALUE] = newValue;
  }

  /// Append Div
  CDiv appendDiv() {
    CDiv div = new CDiv();
    element.append(div.element);
    return div;
  }

  /// Append Section
  CSection appendSection() {
    CSection div = new CSection();
    element.append(div.element);
    return div;
  }

  /// element css classes
  CssClassSet get classes => element.classes;

  /// called by sub class (does not change Id of element)
  String createId(String idPrefix, String name, {String autoPrefixId: "lc"}) {
    String theId = idPrefix;
    if (theId == null || theId.isEmpty) {
      theId = "${autoPrefixId}-${_autoId++}";
    }
    if (name != null && name.isNotEmpty)
      theId = "${theId}-${name}";
    return theId;
  }
  /// called by sub class based on current id of element
  String setAndCreateId(String name, {String autoPrefixId: "lc", String autoPrefixName: "c"}) {
    String theId = element.id;
    if (theId == null || theId.isEmpty) {
      theId = "${autoPrefixId}-${_autoId++}";
      element.id = theId;
    }
    if (name != null && name.isNotEmpty)
      return "${theId}-${name}";
    return "${theId}-${autoPrefixName}-${_autoId++}";
  }

  /**
   * Add Heading + handle aria
   */
  HeadingElement addHeading(HeadingElement h, String text, {String headingClass, List<String> headingClasses}) {
    h.text = text;
    // labelled by
    if (element.id == null || element.id.isEmpty) {
      element.id = "lc-${_autoId++}";
    }
    h.id = createId(element.id, "heading");
    element.setAttribute(Html0.ARIA_LABELLEDBY, h.id);

    // Classes
    if (headingClass != null && headingClass.isNotEmpty)
      h.classes.add(headingClass);
    if (headingClasses != null) {
      for (String cls in headingClasses) {
        if (cls != null && cls.isNotEmpty)
          h.classes.add(cls);
      }
    }
    element.append(h);
    return h;
  } // addHeading

  /// add h1
  HeadingElement addHeading1(String text, {String id, String headingClass, List<String> headingClasses}) {
    return addHeading(new HeadingElement.h1(), text, headingClass:headingClass, headingClasses:headingClasses);
  }
  /// add h2
  HeadingElement addHeading2(String text, {String id, String headingClass, List<String> headingClasses}) {
    return addHeading(new HeadingElement.h2(), text, headingClass:headingClass, headingClasses:headingClasses);
  }
  /// add h3
  HeadingElement addHeading3(String text, {String id, String headingClass, List<String> headingClasses}) {
    return addHeading(new HeadingElement.h3(), text, headingClass:headingClass, headingClasses:headingClasses);
  }
  /// add h3
  HeadingElement addHeading4(String text, {String id, String headingClass, List<String> headingClasses}) {
    return addHeading(new HeadingElement.h4(), text, headingClass:headingClass, headingClasses:headingClasses);
  }

} // LComponent


/**
 * Simple Div Element Component
 */
class CDiv extends LComponent {

  /// Div Element
  final DivElement element = new DivElement();

  String get text => element.text;
  void set text (String newValue) {
    element.text = newValue;
  }

}

/**
 * Simple Section Element Component
 */
class CSection extends LComponent {

  /// Section Element
  final Element element = new Element.section();
}

/**
 * Simple Section Element Component
 */
class CArticle extends LComponent {

  /// Article Element
  final Element element = new Element.article();
}

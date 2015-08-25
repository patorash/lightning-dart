/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Popover
 */
class LPopover extends LPopbase {

  /// slds-popover - Initializes popover | Required
  static const String C_POPOVER = "slds-popover";
  /// slds-popover__content - Hook for nubbin positioning | Required
  static const String C_POPOVER__CONTENT = "slds-popover__content";
  /// slds-popover__header - Applys styles for top area of popover
  static const String C_POPOVER__HEADER = "slds-popover__header";
  /// slds-popover__body - Applys syles for primary content area of popover
  static const String C_POPOVER__BODY = "slds-popover__body";

  /// slds-nubbin--top - Triangle that points upwards
  static const String C_NUBBIN__TOP = "slds-nubbin--top";
  /// slds-nubbin--bottom - Triangle that points downwards
  static const String C_NUBBIN__BOTTOM = "slds-nubbin--bottom";
  /// slds-nubbin--left - Triangle that points to the left
  static const String C_NUBBIN__LEFT = "slds-nubbin--left";
  /// slds-nubbin--right - Triangle that points to the right
  static const String C_NUBBIN__RIGHT = "slds-nubbin--right";

  /// Nubbin Positions
  static final List<String> NUBBINS = [C_NUBBIN__TOP, C_NUBBIN__RIGHT, C_NUBBIN__BOTTOM, C_NUBBIN__LEFT];

  /// Popover element
  final DivElement pop = new DivElement()
    ..classes.add(C_POPOVER)
    ..attributes[Html0.ROLE] = Html0.ROLE_DIALOG;

  final DivElement _content = new DivElement()
    ..classes.add(C_POPOVER__CONTENT)
    ..attributes[Html0.ROLE] = Html0.ROLE_DOCUMENT;
  final DivElement _head = new DivElement()
    ..classes.add(C_POPOVER__HEADER);
  final ParagraphElement _headParagraph = new ParagraphElement()
    ..classes.add(LText.C_TEXT_HEADING__SMALL);

  final DivElement body = new DivElement()
    ..classes.add(C_POPOVER__BODY);


  /**
   * Popover with text
   */
  LPopover() {
    pop.append(_content);
    _content.append(_head);
    _head.append(_headParagraph);
    _content.append(body);
  } // LPopover

  void set headText (String text) {
    _headParagraph.text = text;
  }
  void set bodyText (String text) {
    body.text = text;
  }


} // LPopover


/**
 * Popover/Tooltip management
 */
abstract class LPopbase extends LComponent {

  static final Logger _log = new Logger("LPopbase");

  DivElement get element {
    if (wrapper == null)
      return pop;
    return wrapper;
  }

  /// Wrapper Element
  DivElement wrapper;
  /// Trigger Element to show Popover
  Element target;
  /// Pop Element (popover)
  DivElement get pop;

  String _nub = LPopover.C_NUBBIN__BOTTOM;
  bool _clickShow = false;

  void set nubbinTop (bool newValue) {
    element.classes.removeAll(LPopover.NUBBINS);
    if (newValue) {
      _nub = LPopover.C_NUBBIN__TOP;
      element.classes.add(LPopover.C_NUBBIN__TOP);
    }
  }
  void set nubbinRight (bool newValue) {
    element.classes.removeAll(LPopover.NUBBINS);
    if (newValue) {
      _nub = LPopover.C_NUBBIN__RIGHT;
      element.classes.add(LPopover.C_NUBBIN__RIGHT);
    }
  }
  void set nubbinLeft (bool newValue) {
    element.classes.removeAll(LPopover.NUBBINS);
    if (newValue) {
      _nub = LPopover.C_NUBBIN__LEFT;
      element.classes.add(LPopover.C_NUBBIN__LEFT);
    }
  }
  void set nubbinBottom (bool newValue) {
    element.classes.removeAll(LPopover.NUBBINS);
    if (newValue) {
      _nub = LPopover.C_NUBBIN__BOTTOM;
      element.classes.add(LPopover.C_NUBBIN__BOTTOM);
    }
  }

  /// Show pop above [component]
  void showAbove(LComponent component, {
      bool showOnHover: true, bool showOnClick: true}) {
    showAboveElement(component.element,
      showOnHover:showOnHover, showOnClick:showOnClick);
  }
  /// Show pop above [target]
  void showAboveElement(Element target, {
      bool showOnHover: true, bool showOnClick: true}) {
    nubbinBottom = true;
    _showPrep(target, showOnHover, showOnClick);
  }

  /// Show pop below [component]
  void showBelow(LComponent component, {
      bool showOnHover: true, bool showOnClick: true}) {
    showBelowElement(component.element,
      showOnHover:showOnHover, showOnClick:showOnClick);
  }
  /// Show pop below [target]
  void showBelowElement(Element target, {
      bool showOnHover: true, bool showOnClick: true}) {
    nubbinTop = true;
    _showPrep(target, showOnHover, showOnClick);
  }

  /// Show pop right [component]
  void showRight(LComponent component, {
      bool showOnHover: true, bool showOnClick: true}) {
    showRightElement(component.element,
      showOnHover:showOnHover, showOnClick:showOnClick);
  }
  /// Show pop right [target]
  void showRightElement(Element target, {
      bool showOnHover: true, bool showOnClick: true}) {
    nubbinLeft = true;
    _showPrep(target, showOnHover, showOnClick);
  }

  /// Show pop left [component]
  void showLeft(LComponent component, {
      bool showOnHover: true, bool showOnClick: true}) {
    showLeftElement(component.element,
      showOnHover:showOnHover, showOnClick:showOnClick);
  }
  /// Show pop left [target]
  void showLeftElement(Element target, {
      bool showOnHover: true, bool showOnClick: true}) {
    nubbinRight = true;
    _showPrep(target, showOnHover, showOnClick);
  }


  /// show preparation - attach, triggers
  void _showPrep(Element target,
      bool showOnHover, bool showOnClick) {
    this.target = target;
    //
    wrapper = new DivElement();
    wrapper.style.position = "relative";
    wrapper.style.display = "inline-block";
    wrapper.append(target);
    wrapper.append(pop);

    pop.style.float = "left";
    pop.style.position = "absolute";
    hide();
    // trigger
    if (showOnHover) {
      target.onMouseEnter.listen((MouseEvent evt) {
        _show();
      });
      target.onMouseLeave.listen((MouseEvent evt) {
        if (!_clickShow) {
          hide();
        }
      });
    }
    if (showOnClick) {
      target.onClick.listen((MouseEvent evt){
        _clickShow = !_clickShow;
        if (_clickShow) {
          _show();
        } else {
          hide();
        }
      });
    }
  } // showPrep

  // do show
  void _show() {
    Rectangle targetRect = target.getBoundingClientRect();
    //_log.fine("-target ${targetRect}");

    pop.classes.remove(LVisibility.C_HIDE);
    pop.style.width = "20rem"; // not just max width
    // should calculate max required with from content
    Rectangle elementRect = pop.getBoundingClientRect();
    //_log.fine("element ${elementRect}");

    const double nubHeight = 12.0;
    const double nubWidth = 12.0;

    // show above
    if (_nub == LPopover. C_NUBBIN__BOTTOM) {
      double top = -(elementRect.height + nubHeight);
      pop.style.top = "${top.toInt()}px";
      double left = -(elementRect.width - targetRect.width) / 2;
      pop.style.left = "${left.toInt()}px";
    }
    // show below
    else if (_nub == LPopover. C_NUBBIN__TOP) {
      double top = targetRect.height + nubHeight;
      pop.style.top = "${top.toInt()}px";
      double left = -(elementRect.width - targetRect.width) / 2;
      pop.style.left = "${left.toInt()}px";
    }
    // show right
    else if (_nub == LPopover. C_NUBBIN__LEFT) {
      double top = -(elementRect.height - targetRect.height) / 2;
      pop.style.top = "${top.toInt()}px";
      double left = targetRect.width + nubWidth;
      pop.style.left = "${left.toInt()}px";
    }
    // show left
    else if (_nub == LPopover. C_NUBBIN__RIGHT) {
      double top = -(elementRect.height - targetRect.height) / 2;
      pop.style.top = "${top.toInt()}px";
      double left = - (elementRect.width + nubWidth);
      pop.style.left = "${left.toInt()}px";
    }
    // TODO adjust for when out of screen
  } // show


  /// Showing
  bool get show => !pop.classes.contains(LVisibility.C_HIDE);

  /// hide
  void hide() {
    pop.classes.add(LVisibility.C_HIDE);
  }

} // LPopbase
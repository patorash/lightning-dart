/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/// Modal Close/Cancel Function
typedef void ModalClose();

/**
 * Modal Dialog
 * - width: 50%, min: 20rem, max: 40rem
 * - small: width: 90%, max: 580px
 * - large: width: 90%, min: 40rem (if > 48em)
 *
 * Modal - www.lightningdesignsystem.com/components/modals/
 * - or edit dialog - www.lightningdesignsystem.com/components/forms/
 */
class LModal
    extends LComponent {

  /// slds-modal (div): Positions the modal to stretch to page edges
  static const String C_MODAL = "slds-modal";
  /// slds-fade-in-open (slds-modal): Allows the modal to be visible. - Apply this class to a modal with JavaScript to make it visible.
  static const String C_FADE_IN_OPEN = "slds-fade-in-open";
  /// slds-modal--large (slds-modal): Widens the modal to take more horizontal space
  static const String C_MODAL__LARGE = "slds-modal--large";
  /// slds-modal__container (div): Centers and sizes the modal horizontally and confines modal within viewport height - This should be nested immediately inside .slds-modal with nothing else nested on the same level.
  static const String C_MODAL__CONTAINER = "slds-modal__container";
  /// slds-modal__header (div): Creates the Modal Header container. - This should be nested immediately inside .slds-modal__container as the first element.
  static const String C_MODAL__HEADER = "slds-modal__header";
  /// slds-modal__close (slds-button): Positions the close button to the top right outside of the modal. - Use JavaScript to make clicking this button remove the modal. This button contains a Close Action Icon.
  static const String C_MODAL__CLOSE = "slds-modal__close";
  /// slds-modal__content (div): Creates the scrollable content area for the modal. - Either .slds-modal__content or .slds-modal__menu must be used. If you’re using this class, you do not need the other. This should be nested immediately inside .slds-modal_container and immediately after .slds-modal__header.
  static const String C_MODAL__CONTENT = "slds-modal__content";
  /// slds-modal__menu (div): Creates the shaded menu area for the modal. - Either .slds-modal__menu or .slds-modal__content must be used. If you’re using this class, you do not need the other. This should be nested immediately inside .slds-modal_container and immediately after .slds-modal__header.
  static const String C_MODAL__MENU = "slds-modal__menu";
  /// slds-modal__footer (div): Creates the Modal Footer container. - This should be nested immediately inside .slds-modal_container and immediately after .slds-modal__container. Nothing should follow it. Note that by default, elements will be aligned to the right.
  static const String C_MODAL__FOOTER = "slds-modal__footer";
  /// slds-modal__footer--directional (slds-modal__footer): Makes buttons inside the footer spread to both left and right. - This is only needed when you have two buttons that indicate a back and forward navigation.
  static const String C_MODAL__FOOTER__DIRECTIONAL = "slds-modal__footer--directional";

  /// slds-backdrop (div): Creates the shaded backdrop used behind the modal. - This should follow after the .slds-modal as an empty element.
  static const String C_BACKDROP = "slds-backdrop";
  /// slds-modal-backdrop (div): Creates the shaded backdrop used behind the modal. - Deprecated
  static const String C_MODAL_BACKDROP = "slds-modal-backdrop";
  /// slds-backdrop--open (slds-modal-backdrop): Allows the backdrop to be visible. - Apply this class to a modal backdrop with JavaScript to make it visible.
  static const String C_BACKDROP__OPEN = "slds-backdrop--open";


  /// slds-modal--prompt - Initializes Prompt style notification | Required
  static const String C_MODAL__PROMPT = "slds-modal--prompt"; // notification

  /// slds-modal--small default 50% - 90% max=580
  static const String C_MODAL__SMALL = "slds-modal--small";
  /// slds-modal--mobile 100%
  static const String C_MODAL__MOBILE = "slds-modal--mobile";

  /// Modal Form (Touch) square header
  static const String C_MODAL__FORM = "slds-modal--form";


  static final Logger _log = new Logger("LModal");

  /// cancel button
  static LButton createCancelButton({String label, String idPrefix}) {
    if (label == null || label.isEmpty)
      label = lModalCancel();
    return new LButton.neutralIcon("cancel", label,
        new LIconUtility(LIconUtility.CLOSE, color: LIcon.C_ICON_TEXT_ERROR),
        idPrefix: idPrefix);
  }

  /// save button
  static LButton createSaveButton({String label, String idPrefix}) {
    if (label == null || label.isEmpty)
      label = lModalSave();
    return new LButton.brandIcon("save", label,
        new LIconUtility(LIconUtility.CHECK),
        idPrefix: idPrefix);
  }

  /// execute button
  static LButton createExecuteButton({String label, String idPrefix, bool brand:false}) {
    if (label == null || label.isEmpty)
      label = lModalExecute();
    if (brand)
      return new LButton.brandIcon("execute", label,
          new LIconUtility(LIconUtility.CONNECTED_APPS),
          idPrefix: idPrefix);
    return new LButton.neutralIcon("execute", label,
        new LIconUtility(LIconUtility.CONNECTED_APPS),
        idPrefix: idPrefix);
  }


  /// open modals
  static List<LModal> _openModals = new List<LModal>();
  /// adjust z-index of nested Modals
  static void _nestedModal(LModal m) {
    if (_openModals.isEmpty)
      return;
    int openModals = 0;
    for (LModal modal in _openModals) {
      if (modal == m)
        continue;
      if (modal.show)
        openModals++;
    }
    _log.config("nestedModals count=${_openModals.length} open=${openModals}");
    if (openModals > 0) {
      m._backdrop.style.zIndex = "${9000+(openModals*2)}";
      m._dialog.style.zIndex = "${9001+(openModals*2)}";
    }
  } // nestedModals

  /// touch default
  static bool touchDefault;


  /// Outer Element
  final DivElement element = new DivElement();
  /// Touch
  bool touch = false;

  final DivElement _dialog = new DivElement()
    ..classes.add(C_MODAL)
    ..attributes[Html0.ROLE] = Html0.ROLE_DIALOG;
  final DivElement _container = new DivElement()
    ..classes.add(C_MODAL__CONTAINER)
    ..attributes[Html0.ROLE] = Html0.ROLE_DOCUMENT
    ..tabIndex = 0;

  final DivElement header = new DivElement()
    ..classes.add(C_MODAL__HEADER);
  HeadingElement _header_h2;
  DivElement _header_buttons;

  final CDiv content = new CDiv() //  AROUND__MEDIUM
    ..classes.addAll([C_MODAL__CONTENT, LPadding.C_VERTICAL__LARGE, LPadding.C_HORIZONTAL__LARGE]);
  final DivElement footer = new DivElement()
    ..classes.add(C_MODAL__FOOTER);
  /// The backdrop
  final DivElement _backdrop = new DivElement()
    ..classes.add(C_BACKDROP);

  /// Save button
  LButton buttonSave;
  /// Cancel button
  LButton buttonCancel;
  /// Callback when close or cancel
  ModalClose onModalClose;

  /**
   * Modal Dialog
   * element
   * _dialog        .slds_modal       .slds-fade-in-open
   *   _container   .slds-modal__container
   *     header     .slds-modal__header
   *     content    .slds-modal__content
   *     footer     .slds-modal__footer
   * _backdrop      .slds-backdrop    .slds-backdrop--open
   *
   * touch:
   * element
   * _dialog        .slds-modal .slds-modal--form .slds-fade-in-open
   *   _container   .slds-modl__container  .slds-modal--form
   *     header     .slds-modal__header
   *     content    .slds-modal__content
   * _backdrop      .slds-backdrop    .slds-backdrop--open
   */
  LModal(String idPrefix, {bool useTouch}) {
    element.id = idPrefix == null || idPrefix.isEmpty ? LComponent.createId("modal", null) : idPrefix;
    element.append(_dialog);
    _dialog.append(_container);
    _container.append(header);
    _container.append(content.element);
    _container.append(footer);
    element.append(_backdrop);
    //
    if (useTouch == null) {
      if (touchDefault != null)
        touch = touchDefault;
    } else {
      touch = useTouch;
    }
    if (ClientEnv.isPhone) {
      mobile = true;
      if (useTouch == null && touchDefault == null)
        touch = true;
    }
    if (touch) {
      // header buttons - first float left other float right
      _dialog.classes.add(C_MODAL__FORM);
      _container.classes.add(C_MODAL__FORM);
      footer.remove();
    }
    // enter(parent) - over(+child) - move - out - leave
    header.onMouseEnter.listen(onHeaderMouseEnter);
    header.onMouseDown.listen(onHeaderMouseDown);
    header.onMouseMove.listen(onHeaderMouseMove);
    header.onMouseUp.listen(onHeaderMouseUp);
    header.onMouseLeave.listen(onHeaderMouseLeave);
  } // LModal


  /// Large Modal - 90% 960/640 - default 50%
  bool get large => _dialog.classes.contains(C_MODAL__LARGE);
  /// Large Modal - 90% 960/640 - default 50%
  void set large (bool newValue) {
    if (mobile && ClientEnv.isPhone)
      return;
    if (newValue) {
      _dialog.classes.add(C_MODAL__LARGE);
      _dialog.classes.remove(C_MODAL__SMALL);
      _dialog.classes.remove(C_MODAL__MOBILE);
    } else
      _dialog.classes.remove(C_MODAL__LARGE);
  }

  /// Small Modal - 90% max=550 - default 50%
  bool get small => _dialog.classes.contains(C_MODAL__SMALL);
  /// Small Modal - 90% max=550 - default 50%
  void set small (bool newValue) {
    if (mobile && ClientEnv.isPhone)
      return;
    if (newValue) {
      _dialog.classes.add(C_MODAL__SMALL);
      _dialog.classes.remove(C_MODAL__LARGE);
      _dialog.classes.remove(C_MODAL__MOBILE);
    } else
      _dialog.classes.remove(C_MODAL__SMALL);
  }

  /// Mobile Modal - 100%
  bool get mobile => _dialog.classes.contains(C_MODAL__MOBILE);
  /// Mobile Modal
  void set mobile (bool newValue) {
    if (newValue) {
      _dialog.classes.add(C_MODAL__MOBILE);
      _dialog.classes.remove(C_MODAL__LARGE);
      _dialog.classes.remove(C_MODAL__SMALL);
    } else
      _dialog.classes.remove(C_MODAL__MOBILE);
  }


  /**
   * Set Header (and close)
   */
  void setHeaderComponents(HeadingElement h2, Element tagLine) {
    header.children.clear();
    if (touch) {
      if (buttonCancel != null)
        header.append(buttonCancel.element);
      if (buttonSave != null)
        header.append(buttonSave.element);
      if (_header_buttons != null)
        header.append(_header_buttons);
    }
    _header_h2 = h2;
    _header_h2.classes.add(LText.C_TEXT_HEADING__MEDIUM);
    _header_h2.id = "${id}-h2";
    header.append(_header_h2);
    _dialog.attributes[Html0.ARIA_LABELLEDBY] = _header_h2.id;
    if (tagLine != null)
      header.append(tagLine);
    //
    if (_helpHref != null) {
      if (touch) { // buttons on top
        if (tagLine == null) {
          header.append(LUtil.helpReference(_helpHref, false));
        } else {
          tagLine.append(LUtil.helpReference(_helpHref, false));
        }
      } else {
        header.append(LUtil.helpReference(_helpHref, true)); // top-right
      }
    }
    // Close
    if (!touch) {
      LButton buttonClose = new LButton(
          new ButtonElement(), "close", null, idPrefix: id,
          buttonClasses: [C_MODAL__CLOSE],
          icon: new LIconAction("close", className: LButton.C_BUTTON__ICON,
              colorOverride: LButton.C_BUTTON__ICON_INVERSE,
              size: LButton.C_BUTTON__ICON__LARGE),
          assistiveText: lModalClose());
      buttonClose.onClick.listen(onClickCancel);
      header.append(buttonClose.element);
    }
  }
  /// Set header
  void setHeader(String title, {String tagLine, LIcon icon}) {
    HeadingElement h2 = new HeadingElement.h2();
    if (icon != null) {
      if (icon.linkPrefix.contains("utility")) {
        icon.classes.add(LIcon.C_ICON_TEXT_DEFAULT);
        icon.classes.add(LIcon.C_ICON__SMALL);
      } else { // }if (icon.linkPrefix.contains("action")) {
        icon.element.style.padding = "0.25rem"; // colored space
      }
      icon.classes.add(LMargin.C_RIGHT__SMALL);
      h2.append(icon.element);
    }
    h2.appendText(title);
    ParagraphElement p;
    if (tagLine != null)
      p = new ParagraphElement()
        ..classes.add(LMargin.C_TOP__XX_SMALL)
        ..text = tagLine;
    setHeaderComponents(h2, p);
  } // setHeader

  /// Help Link
  String get helpHref => _helpHref;
  /// Help Link
  void set helpHref (String url) {
    _helpHref = url;
  }
  String _helpHref;

  /**
   * Add to Content
   */
  void addContentText(String text) {
    append(new ParagraphElement()
      ..text = text
    );
  }

  /// Add Div to content
  CDiv addDiv() {
    CDiv div = new CDiv();
    content.add(div);
    return div;
  }

  /// Add Section to content
  CDiv addSection() {
    CDiv div = new CDiv.section();
    content.add(div);
    return div;
  }

  /// append element to content
  void append(Element newValue) {
    content.append(newValue);
  }
  /// add component to content
  void add(LComponent component) {
    content.add(component);
  }
  /// add form to content + buttons to footer
  void addForm(LForm form) {
    content.add(form);
    addFooterFormButtons(form);
  }

  /**
   * Set Footer
   */
  void setFooter(List<Element> footerElements, bool directional) {
    footer.children.clear();
    if (directional)
      footer.classes.add(C_MODAL__FOOTER__DIRECTIONAL);
    else
      footer.classes.remove(C_MODAL__FOOTER__DIRECTIONAL);
    ///
    if (footerElements != null) {
      for (Element fe in footerElements) {
        if (fe != null) {
          if (touch) {
            if (_header_h2 == null) {
              header.append(fe);
            } else {
              header.insertBefore(fe, _header_h2);
            }
          } else { // !touch
            footer.append(fe);
          }
        }
      }
    }
  } // setFooter

  /**
   * Set Footer Cancel|Save Buttons - returns save button
   * [hideOnSave] hide+remove on Save
   * [addCancel] hides+removes the dialog
   */
  LButton addFooterButtons({String saveLabelOverride, bool hideOnSave: true,
      bool addCancel: true, String cancelLabelOverride}) {
    if (addCancel || touch) {
      addFooterCancel(cancelLabel: cancelLabelOverride);
    }
    buttonSave = createSaveButton(label: saveLabelOverride, idPrefix: id);
    if (hideOnSave) {
      buttonSave.onClick.listen(onClickRemove);
    }
    if (touch) {
      if (_header_h2 == null) {
        header.append(buttonSave.element);
      } else {
        header.insertBefore(buttonSave.element, _header_h2);
      }
    } else { // !touch
      footer.append(buttonSave.element);
    }
    return buttonSave;
  } // setFooterButtons

  /// add Cancel to Footer with optional [cancelLablel] override
  void addFooterCancel({String cancelLabel}) {
    if (buttonCancel == null) {
      buttonCancel = createCancelButton(label: cancelLabel, idPrefix: id);
      buttonCancel.onClick.listen(onClickCancel);
      footer.append(buttonCancel.element);
      footer.classes.add(C_MODAL__FOOTER__DIRECTIONAL);
    }
    if (touch) {
      buttonCancel.element.remove();
      if (header.children.isEmpty) {
        header.append(buttonCancel.element);
      } else {
        header.insertBefore(buttonCancel.element, header.children.first);
      }
    }
  } // addFooterCancel

  /**
   * Set Footer Actions
   */
  void addFooterActions(List<AppsAction> actions,
      {bool addCancel:false, String cancelLabelOverride, bool hideOnAction:true}) {
    if (addCancel || touch) {
      addFooterCancel(cancelLabel:cancelLabelOverride);
    }
    if (actions != null) {
      for (AppsAction action in actions) {
        action.buttonClasses = [LButton.C_BUTTON__NEUTRAL];
        LButton btn = action.asButton(true, idPrefix: id);
        if (hideOnAction)
          btn.onClick.listen(onClickRemove);
        if (touch) {
          if (_header_h2 == null) {
            header.append(btn.element);
          } else {
            header.insertBefore(btn.element, _header_h2);
          }
        } else { // !touch
          footer.append(btn.element);
        }
      }
    }
  } // setFooterActions

  /// Add Form Buttons + cancel to footer
  void addFooterFormButtons(LForm form) {
    addFooterCancel();

    LButton reset = form.addResetButton();
    reset.element.id = "${id}-reset";
    LPopover error = form.addErrorIndicator();
    error.element.id = "${id}-error";
    LButton save = form.addSaveButton();
    save.element.id = "${id}-save";
    if (touch) {
      _header_buttons = new DivElement()
        ..classes.add("buttons")
        ..append(reset.element)
        ..append(error.element)
        ..append(save.element);
      if (_header_h2 == null) {
        header.append(_header_buttons);
      } else {
        header.insertBefore(_header_buttons, _header_h2);
      }
    } else { // !touch
      footer.append(reset.element);
      footer.append(error.element);
      footer.append(save.element);
    }
    // remove button div
    if (form.buttonDiv != null) {
      form.buttonDiv.remove();
      form.buttonDiv = null;
    }
  } // addFooterFormButtons


  /// Showing Modal
  bool get show => _backdrop.classes.contains(C_BACKDROP__OPEN);
  /// Show/Hide Modal
  void set show (bool newValue) {
    _dialog.attributes[Html0.ARIA_HIDDEN] = newValue ? "false" : "true";
    if (newValue) {
      _nestedModal(this);
      _openModals.add(this);
      _dialog.classes.add(C_FADE_IN_OPEN);
      _backdrop.classes.add(C_BACKDROP__OPEN);
      content.focus();
      document.body.classes.add("modal-open");
    } else {
      _dialog.classes.remove(C_FADE_IN_OPEN);
      _backdrop.classes.remove(C_BACKDROP__OPEN);
      _openModals.remove(this);
      if (_openModals.isEmpty)
        document.body.classes.remove("modal-open");
      element.remove();
    }
  } // show

  /// Show Center Screen - or left/below evt target
  void showInComponent(LComponent parent, {MouseEvent evt}) {
    parent.append(element);
    show = true;
    if (evt != null)
      _position(evt);
  }

  /// Show Center Screen - or left/below evt target
  void showInElement(Element parent, {MouseEvent evt}) {
    parent.append(element);
    show = true;
    if (evt != null)
      _position(evt);
  }

  /// Show Modal Center or left/below evt target
  void showModal({MouseEvent evt}) {
    showInElement(PageSimple.modals, evt:evt);
  }

  /// Position left/below
  void _position(MouseEvent evt) {
    // normalize
    _containerOffset = new Point(0, 0);
    _container.style
      ..top = "0px"
      ..left = "0px";
    Element target = evt.target;
    if (target == null) {
      return;
    }
    // container is full window height
    Rectangle rectHeader = header.getBoundingClientRect();
    Rectangle rectTarget = target.getBoundingClientRect();
    // position left/below
    num dx = -(rectHeader.left - rectTarget.left);
    num dy = -(rectHeader.top - rectTarget.bottom);
    _containerOffset = new Point(dx-5, dy+5);
    _container.style
      ..top = "${_containerOffset.y}px"
      ..left = "${_containerOffset.x}px";
    //_log.fine("offset=${_containerOffset} ${window.innerWidth}x${window.innerHeight}");

    // fit on screen?
    bool needsAdjustment = false;
    rectHeader = header.getBoundingClientRect();
    num endX = rectHeader.left + rectHeader.width;
    num deltaX = window.innerWidth - endX; //
    if (deltaX < 0) {
      dx += deltaX;
      needsAdjustment = true;
    }
    Rectangle rectContent = content.element.getBoundingClientRect();
    Rectangle rectFooter = footer.getBoundingClientRect();
    num endY = rectHeader.top + rectHeader.height + rectContent.height + rectFooter.height;
    num deltaY = window.innerHeight - endY; // bottom space
    if (deltaY < 0) {
      dy += deltaY;
      needsAdjustment = true;
    }
    if (needsAdjustment) {
      _containerOffset = new Point(dx-5, dy);
      //_log.fine("offset2=${_containerOffset}");
      _container.style
        ..top = "${_containerOffset.y}px"
        ..left = "${_containerOffset.x}px";
    }
  } // _position

  /// Hide and Remove Modal
  void onClickCancel(MouseEvent ignored) {
    show = false;
    if (onModalClose != null)
      onModalClose(); // info callback
  }

  /// Hide and Remove Modal
  void onClickRemove(MouseEvent ignored) {
    show = false;
  }

  /// Move start screen (based on center screen)
  Point _mouseDownPoint = null;
  Point _containerStart = null;
  /// Container start
  Point _containerOffset = new Point(0,0);

  void onHeaderMouseEnter(MouseEvent evt) {
    // _log.fine("onHeaderMouseEnter");
    header.classes.add("grab");
  }
  void onHeaderMouseDown(MouseEvent evt) {
    _mouseDownPoint = evt.screen;
    _containerStart = _containerOffset;
    // _log.fine("onHeaderMouseDown ${_mouseDownPoint} ${_mouseDownRect}");
    header.classes.remove("grab");
    header.classes.add("grabbing");
  }
  /// Move delta
  void onHeaderMouseMove(MouseEvent evt) {
    if (_mouseDownPoint != null) {
      Point delta = evt.screen - _mouseDownPoint;
      _containerOffset = new Point(_containerStart.x + delta.x, _containerStart.y + delta.y);
      //_log.fine("onHeaderMouseMove delta=${delta} start=${_containerStart} - offset=${_containerOffset}");
      _container.style
        ..top = "${_containerOffset.y}px"
        ..left = "${_containerOffset.x}px";
      //_log.fine("onHeaderMouseMove ${_container.getBoundingClientRect()} ${_containerOffset}  ${window.innerWidth}x${window.innerHeight}");
    }
  }
  void onHeaderMouseUp(MouseEvent evt) {
    // Rectangle rect = _dialog.getBoundingClientRect();
    // _log.fine("onHeaderMouseUp - ${rect}");
    header.classes.add("grab");
    header.classes.remove("grabbing");
    _mouseDownPoint = null;
    _containerStart = null;
  }
  void onHeaderMouseLeave(MouseEvent evt) {
    // _log.fine("onHeaderMouseLeave");
    if (_mouseDownPoint != null)
      onHeaderMouseUp(evt);
    header.classes.remove("grab");
  }


  // Trl
  static String lModalClose() => Intl.message("Close", name: "lModalClose", args: []);
  static String lModalCancel() => Intl.message("Cancel", name: "lModalCancel");
  static String lModalSave() => Intl.message("Save", name: "lModalSave");
  static String lModalExecute() => Intl.message("Execute", name: "lModalExecute");

} // LModal



/**
 * Modal Confirmation
 */
class LConfirmation extends LModal {

  /**
   * Confirmation
   * - header [label] optional [tagline] text or [tagLineElement]
   * - content [text] optional [contentElements]
   * - footer [actions]
   */
  LConfirmation(String idPrefix, {
      String title,
      String tagLine,
      LIcon icon, // default ?
      Element tagLineElement,
      String text,
      List<String> textList,
      List<Element> contentElements,
      List<AppsAction> actions,
      bool addCancel:false,
      String cancelLabelOverride})
      : super(idPrefix) {
    LIcon theIcon = icon == null ? new LIconAction(LIconAction.QUESTION_POST_ACTION) : icon;
    setHeader(title, tagLine:tagLine, icon:theIcon);

    // Content
    if (text != null && text.isNotEmpty) {
      ParagraphElement p = new ParagraphElement()
        ..text = text;
      append(p);
    }
    if (textList != null && textList.isNotEmpty) {
      for (String tt in textList) {
        ParagraphElement p = new ParagraphElement()
          ..text = tt;
        append(p);
      }
    }
    if (contentElements != null) {
      for (Element e in contentElements)
        append(e);
    }

    // Footer
    addFooterActions(actions,
        addCancel:addCancel, cancelLabelOverride:cancelLabelOverride);
  } // LConfirmation

} // LConfirmation

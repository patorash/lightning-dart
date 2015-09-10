/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3  http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://lightningdart.com
 */

part of lightning_ctrl;

/**
 * Main Page Menu Item
 * - a menu Item and the container for the content
 */
abstract class AppsPage extends LComponent {

  static const String MENU_SUFFIX = "-menu";

  // Menu Entry
  AnchorElement menuEntry = new AnchorElement(href: "#")
    ..classes.add(AppsMenu.C_APPS_MENU_ENTRY);

  final String label;
  final LIcon icon;
  final String externalHref;

  /**
   * Page element with Menu
   * the [icon] is best an action or utility icon - standard and custom items have a different size
   * if [externalHref] is provided, the user is redirected with the optional [target]
   */
  AppsPage(String id, LIcon this.icon, String this.label, {String this.externalHref, String target}) {
    element.id = id;
    menuEntry.id = id + MENU_SUFFIX;
    if (externalHref != null && externalHref.isNotEmpty) {
      menuEntry.href = externalHref;
      if (target != null && target.isNotEmpty)
        menuEntry.target = target;
    } else { // internal
      menuEntry.href = "#" + id;
    }
    // Icon
    icon.removeColor();
    icon.classes.addAll([LIcon.C_ICON, LIcon.C_ICON__SMALL]);
    // Menu
    menuEntry.append(icon.element);
    if (label != null && label.isNotEmpty) {
      menuEntry.append(new SpanElement()..text = label);
    }
  }

  /// Active
  bool get active => menuEntry.classes.contains(LButton.C_IS_SELECTED);
  /// Set Active
  void set active (bool newValue) {
    if (newValue) {
      menuEntry.classes.add(LButton.C_IS_SELECTED);
    } else {
      menuEntry.classes.remove(LButton.C_IS_SELECTED);
    }
  }

  /// External Reference
  bool get external => externalHref != null && externalHref.isNotEmpty;
  /// Internal Reference
  bool get internal => externalHref == null || externalHref.isEmpty;

} // AppsPage

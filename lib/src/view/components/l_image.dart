/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart;

/**
 * Image Avatars
 */
class LImage extends LComponent {

  /// slds-avatar (span): Defines an image as an avatar - By default avatars have a rounded square shape
  static const String C_AVATAR = "slds-avatar";
  /// slds-avatar--circle (slds-avatar): Creates a circular avatar shape
  static const String C_AVATAR__CIRCLE = "slds-avatar--circle";
  /// slds-avatar--empty (slds-avatar): Creates a dashed outline around an empty avatar
  static const String C_AVATAR__EMPTY = "slds-avatar--empty";

  /// slds-avatar--x-small (slds-avatar): Creates a 1.5rem×1.5rem icon
  static const String C_AVATAR__X_SMALL = "slds-avatar--x-small";
  /// slds-avatar--small (slds-avatar): Creates a 2.25rem×2.25rem icon
  static const String C_AVATAR__SMALL = "slds-avatar--small";
  /// slds-avatar--medium (slds-avatar): Creates a 3rem×3rem icon
  static const String C_AVATAR__MEDIUM = "slds-avatar--medium";
  /// slds-avatar--large (slds-avatar): Creates a 5rem×5rem icon
  static const String C_AVATAR__LARGE = "slds-avatar--large";

  /// Image Sizes
  static final List<String> SIZES = [C_AVATAR__X_SMALL, C_AVATAR__SMALL, C_AVATAR__MEDIUM, C_AVATAR__LARGE];

  /// prepend assets [src]
  static String assetsSrc(String src) {
    if (src == null || src.contains("/"))
      return src;
    return "packages/lightning/assets/images/" + src;
  }

  /// Image Element
  final SpanElement element = new SpanElement()
    ..classes.add(C_AVATAR);

  final ImageElement img;

  /// Image
  LImage(ImageElement this.img, String size, bool circle) {
    element.append(img);
    if (size != null)
      this.size = size;
    if (circle != null && circle)
      this.circle = circle;
  }

  LImage.srcXSmall(String src, String alt, {bool circle:true})
    : this (new ImageElement(src:assetsSrc(src))..alt=alt, C_AVATAR__X_SMALL, circle);
  LImage.srcSmall(String src, String alt, {bool circle:true})
    : this (new ImageElement(src:assetsSrc(src))..alt=alt, C_AVATAR__SMALL, circle);
  LImage.srcMedium(String src, String alt, {bool circle:true})
    : this (new ImageElement(src:assetsSrc(src))..alt=alt, C_AVATAR__MEDIUM, circle);
  LImage.srcLarge(String src, String alt, {bool circle:true})
    : this (new ImageElement(src:assetsSrc(src))..alt=alt, C_AVATAR__LARGE, circle);

  LImage.imgXSmall(ImageElement img, {bool circle:true})
    : this (img, C_AVATAR__X_SMALL, circle);
  LImage.imgSmall(ImageElement img, {bool circle:true})
    : this (img, C_AVATAR__SMALL, circle);
  LImage.imgMedium(ImageElement img, {bool circle:true})
    : this (img, C_AVATAR__MEDIUM, circle);
  LImage.imgLarge(ImageElement img, {bool circle:true})
    : this (img, C_AVATAR__LARGE, circle);

  /// circle
  bool get circle => element.classes.contains(C_AVATAR__CIRCLE);
  /// circle
  void set circle (bool newValue) {
    if (newValue)
      element.classes.add(C_AVATAR__CIRCLE);
    else
      element.classes.remove(C_AVATAR__CIRCLE);
  }

  /// set Size
  void set size (String newSize) {
    element.classes.removeAll(SIZES);
    if (newSize != null && newSize.isNotEmpty)
      element.classes.add(newSize);
  }

} // LImage

/*
 * Copyright (c) 2015 Accorto, Inc. All Rights Reserved
 * License: GPLv3   http://www.gnu.org/licenses/gpl-3.0.txt
 * License options+support:  https://www.lightningdart.com
 */

part of lightning_dart.demo;

class Buttons extends DemoFeature {

  Buttons() : super("buttons", "Buttons",
  sldsStatus: DemoFeature.SLDS_DEV_READY,
  devStatus: DemoFeature.STATUS_COMPLETE,
  hints: [],
  issues: [],
  plans: []);


  LComponent get content {
    CDiv div = new CDiv()
      ..classes.add(LMargin.C_HORIZONTAL__MEDIUM);

    div.add(new LButton.base("b11", "base button"));
    div.add(new LButton.base("b12", "base disabled")..disabled = true);
    div.add(new LButton.base("b13", "base small")..small = true);

    div.appendHrSmall();
    div.add(new LButton.neutral("b21", "neutral button"));
    div.add(new LButton.neutral("b22", "default disabled")..disabled = true);
    div.add(new LButton.neutral("b23", "neutral small")..small = true);
    div.add(new LButton.neutralAnchor("b24", "neutral link"));
    div.add(new LButton.neutralAnchor("b25", "disabled link")..disabled = true);
    div.add(new LButton.neutralInput("b26", "neutral input"));
    div.add(new LButton.neutralInput("b27", "disabled input")..disabled = true);

    div.appendHrSmall();
    div.add(new LButton.brand("b31", "brand button"));
    div.add(new LButton.brand("b32", "brand disabled")..disabled = true);
    div.add(new LButton.brand("b33", "brand small")..small = true);
    div.add(new LButton.brandAnchor("b34", "brand link"));
    div.add(new LButton.brandIcon("b35", "icon brand button", new LIconUtility(LIconUtility.ADDUSER)));

    div.appendHrSmall();
    LBox box = new LBox()
      ..small = true
      ..themeAltInverse();
    div.add(box);
    box.add(new LButton.inverse("b41", "inverse button"));
    box.add(new LButton.inverse("b42", "inverse disabled")..disabled = true);
    box.add(new LButton.inverse("b43", "inverse small")..small = true);

    div.appendHrSmall();
    div.add(new LButton.neutralIcon("b51", "neutral icon", new LIconUtility(LIconUtility.DOWNLOAD), iconLeft: false));
    div.add(new LButton.neutralIcon("b52", "icon neutral", new LIconUtility(LIconUtility.DOWNLOAD)));
    div.appendText(" Toggle Buttons: ");
    div.add(new LButtonStateful.follow("b53"));
    div.add(new LButtonStatefulIcon("b53", "stateful icon", new LIconUtility(LIconUtility.LIKE)));

    div.append(new LButton.neutralIcon("b58", "hint icon", new LIconUtility(LIconUtility.DOWNLOAD)).hintParent()
      ..classes.addAll([LMargin.C_VERTICAL__SMALL, LPadding.C_AROUND__X_SMALL])
      ..style.border = "1px dotted lightgray");

    div.appendHrSmall();
    div.add(new LButton.iconBare("b61", new LIconUtility(LIconUtility.SETTINGS), "bare"));
    div.add(new LButton.iconContainer("b62", new LIconUtility(LIconUtility.SETTINGS), "container"));
    div.add(new LButton.iconBorder("b63", new LIconUtility(LIconUtility.SETTINGS), "border"));
    div.add(new LButton.iconBorderFilled("b64", new LIconUtility(LIconUtility.SETTINGS), "border filled"));
    div.add(new LButton.more("b65", null, new LIconUtility(LIconUtility.SETTINGS), "more"));
    div.add(new LButton.more("b66", "More", new LIconUtility(LIconUtility.SETTINGS), "more"));
    div.append(new NewWindow().element);

    div.appendHrSmall();
    div.add(new LButton.destructive("b71", "destructive button"));
    div.add(new LButton.destructive("b72", "destructive disabled")..disabled = true);
    div.add(new LButton.destructiveIcon("b73", "icon destructive", new LIconUtility(LIconUtility.BAN)));

    return div;
  }

  String get source {
    return '''
    CDiv div = new CDiv()
      ..classes.add(LMargin.C_HORIZONTAL__MEDIUM);

    div.add(new LButton.base("b11", "base button"));
    div.add(new LButton.base("b12", "base disabled")..disabled = true);
    div.add(new LButton.base("b13", "base small")..small = true);

    div.appendHrSmall();
    div.add(new LButton.neutral("b21", "neutral button"));
    div.add(new LButton.neutral("b22", "default disabled")..disabled = true);
    div.add(new LButton.neutral("b23", "neutral small")..small = true);
    div.add(new LButton.neutralAnchor("b24", "neutral link"));
    div.add(new LButton.neutralAnchor("b25", "disabled link")..disabled = true);
    div.add(new LButton.neutralInput("b26", "neutral input"));
    div.add(new LButton.neutralInput("b27", "disabled input")..disabled = true);

    div.appendHrSmall();
    div.add(new LButton.brand("b31", "brand button"));
    div.add(new LButton.brand("b32", "brand disabled")..disabled = true);
    div.add(new LButton.brand("b33", "brand small")..small = true);
    div.add(new LButton.brandAnchor("b34", "brand link"));
    div.add(new LButton.brandIcon("b35", "icon brand button", new LIconUtility(LIconUtility.ADDUSER)));

    div.appendHrSmall();
    LBox box = new LBox()
      ..small = true
      ..themeAltInverse();
    div.add(box);
    box.add(new LButton.inverse("b41", "inverse button"));
    box.add(new LButton.inverse("b42", "inverse disabled")..disabled = true);
    box.add(new LButton.inverse("b43", "inverse small")..small = true);

    div.appendHrSmall();
    div.add(new LButton.neutralIcon("b51", "neutral icon", new LIconUtility(LIconUtility.DOWNLOAD)));
    div.add(new LButton.neutralIcon("b52", "icon neutral", new LIconUtility(LIconUtility.DOWNLOAD), iconLeft: true));
    div.appendText(" Toggle Buttons: ");
    div.add(new LButtonStateful("b53"));
    div.add(new LButtonStatefulIcon("b53", "stateful icon", new LIconUtility(LIconUtility.LIKE)));

    div.append(new LButton.neutralIcon("b58", "hint icon", new LIconUtility(LIconUtility.DOWNLOAD)).hintParent()
      ..classes.addAll([LMargin.C_VERTICAL__SMALL, LPadding.C_AROUND__X_SMALL])
      ..style.border = "1px dotted lightgray");

    div.appendHrSmall();
    div.add(new LButton.iconBare("b61", new LIconUtility(LIconUtility.SETTINGS), "bare"));
    div.add(new LButton.iconContainer("b62", new LIconUtility(LIconUtility.SETTINGS), "container"));
    div.add(new LButton.iconBorder("b63", new LIconUtility(LIconUtility.SETTINGS), "border"));
    div.add(new LButton.iconBorderFilled("b64", new LIconUtility(LIconUtility.SETTINGS), "border filled"));
    div.add(new LButton.more("b65", null, new LIconUtility(LIconUtility.SETTINGS), "more"));
    div.add(new LButton.more("b66", "More", new LIconUtility(LIconUtility.SETTINGS), "more"));

    div.appendHrSmall();
    div.add(new LButton.destructive("b71", "destructive button"));
    div.add(new LButton.destructive("b72", "destructive disabled")..disabled = true);
    div.add(new LButton.destructiveIcon("b73", "icon destructive", new LIconUtility(LIconUtility.BAN)));

    ''';
  }

}

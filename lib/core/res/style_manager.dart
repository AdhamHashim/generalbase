import 'package:flutter/material.dart'; 

import 'font_manager.dart'; 
 

TextStyle _getTextStyle(
  double fontSized,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontFamily: FontManager.fontFamily,
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSized,
  );
}

// lightFont
TextStyle lightFont({
  double fontSized = FontSize.s12,
  required Color color,
}) =>
    _getTextStyle(fontSized, FontWieghtManager.light, color);

// regularFont
TextStyle regularFont({
  double fontSized = FontSize.s12,
  required Color color,
}) =>
    _getTextStyle(fontSized, FontWieghtManager.regular, color);

// mediumFont
TextStyle mediumFont({
  double fontSized = FontSize.s12,
  required Color color,
}) =>
    _getTextStyle(fontSized, FontWieghtManager.medium, color);

// boldFont
TextStyle boldFont({
  double fontSized = FontSize.s12,
  required Color color,
}) =>
    _getTextStyle(fontSized, FontWieghtManager.bold, color);

// semiBoldFont
TextStyle semiBoldFont({
  double fontSized = FontSize.s12,
  required Color color,
}) =>
    _getTextStyle(fontSized, FontWieghtManager.semiBold, color);

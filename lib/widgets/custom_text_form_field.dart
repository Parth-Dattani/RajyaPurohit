import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool isRequired;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? helperText;
  final String? errorText;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final Color? fillColor;
  final bool filled;
  final bool isNumberInput;
  final bool allowDecimal; // ✅ NEW PARAMETER

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.hintText,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.fillColor,
    this.filled = false,
    this.isNumberInput = false,
    this.allowDecimal = false, // ✅ NEW PARAMETER WITH DEFAULT
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors to match the design
    const Color primaryOrange = Color(0xFFFF9F66);
    const Color lightFill = Color(0xfff0f0f0);

    // ✅ UPDATED: Define input formatters based on keyboard type and allowDecimal
    List<TextInputFormatter> inputFormatters = [];

    // Check for decimal first (most specific case)
    if (keyboardType == TextInputType.numberWithOptions(decimal: true) || allowDecimal) {
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')));
    }
    // Then check for regular numbers
    else if (isNumberInput || keyboardType == TextInputType.number) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }
    // Then check for phone numbers
    else if (keyboardType == TextInputType.phone) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label outside the field
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              isRequired ? '$label *' : label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          // Text field
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            enabled: enabled,
            maxLines: maxLines,
            maxLength: maxLength,
            obscureText: obscureText,
            focusNode: focusNode,
            textInputAction: textInputAction,
            autofocus: autofocus,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
              // DEFAULT BORDER (when not focused) - TRANSPARENT
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              // FOCUSED BORDER (when selected/typing) - ORANGE
              focusedBorder: focusedBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: primaryOrange,
                  width: 2.0,
                ),
              ),
              // ERROR BORDER (when validation fails) - RED
              errorBorder: errorBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
              // FOCUSED ERROR BORDER - RED
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              // DISABLED BORDER - GREY
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              // Prefix icon with orange color
              prefixIcon: prefixIcon != null
                  ? Icon(
                prefixIcon,
                color: primaryOrange,
                size: 22,
              )
                  : null,
              suffixIcon: suffixIcon,
              helperText: helperText,
              errorText: errorText,
              // Content padding for better spacing
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              // Light background fill
              fillColor: fillColor ?? lightFill,
              filled: true,
              alignLabelWithHint: maxLines != null && maxLines! > 1,
            ),
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator ?? (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return "$label is required";
              }

              // ✅ UPDATED: Additional validation for number fields with decimal support
              if ((isNumberInput || allowDecimal) && value != null && value.isNotEmpty) {
                if (allowDecimal) {
                  // Allow numbers with optional decimal point
                  if (!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value)) {
                    return "Please enter valid numbers only";
                  }
                } else {
                  // Only integers
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Please enter valid numbers only";
                  }
                }
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
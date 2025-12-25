import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';

class DropDownOutlined extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>> items;
  final FormFieldValidator<String>? validator;
  const DropDownOutlined({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      items: items,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColor.abudalamcontainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColor.hijauaccent),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}

class ItemDetail extends StatelessWidget {
  final String judul;
  final Widget sub;
  const ItemDetail({super.key, required this.judul, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          judul,
          style: GoogleFonts.robotoFlex(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.all(2), child: sub),
      ],
    );
  }
}

class ItemDetailOutline extends StatelessWidget {
  final String judul;
  final Widget sub;
  const ItemDetailOutline({super.key, required this.judul, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          judul,
          style: GoogleFonts.robotoFlex(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            border: Border.all(color: MyColor.abudalamcontainer),
            borderRadius: BorderRadius.circular(8),
          ),
          child: sub,
        ),
      ],
    );
  }
}

class ItemDetailInputOutline extends StatelessWidget {
  final String judul;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputFormatter? textInputFormatter;
  final bool enabled;
  const ItemDetailInputOutline({
    super.key,
    required this.judul,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.enabled = true, this.textInputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          judul,
          style: GoogleFonts.robotoFlex(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: GoogleFonts.robotoFlex(
            color: MyColor.abuinactivetulisan,
            fontWeight: FontWeight.w200,
          ),
          keyboardType: keyboardType,
          enabled: enabled,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.abudalamcontainer),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.hijauaccent),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColor.abudalamcontainer,
                width: 0.5,
              ),
            ),
          ),
          controller: controller,
        ),
      ],
    );
  }
}

class ItemDetailInputOutlineGreenText extends StatelessWidget {
  final String judul;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textInputFormatter;
  final bool enabled;
  const ItemDetailInputOutlineGreenText({
    super.key,
    required this.judul,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.enabled = true, this.textInputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          judul,
          style: GoogleFonts.robotoFlex(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          inputFormatters: textInputFormatter,
          style: GoogleFonts.robotoFlex(
            color: MyColor.hijauaccent,
            fontWeight: FontWeight.w200,
          ),
          keyboardType: keyboardType,
          enabled: enabled,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.abudalamcontainer),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.hijauaccent),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColor.abudalamcontainer,
                width: 0.5,
              ),
            ),
          ),
          controller: controller,
        ),
      ],
    );
  }
}


class ItemDetailText extends StatelessWidget {
  final String textSub;
  const ItemDetailText({super.key, required this.textSub});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textSub,
            style: GoogleFonts.robotoFlex(
              color: MyColor.abuinactivetulisan,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemDetailTextButton extends StatelessWidget {
  final String textSub;
  final VoidCallback ontap;
  const ItemDetailTextButton({
    super.key,
    required this.textSub,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          InkWell(
            onTap: ontap,
            child: Text(
              textSub,
              style: GoogleFonts.robotoFlex(
                color: MyColor.hijauaccent,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


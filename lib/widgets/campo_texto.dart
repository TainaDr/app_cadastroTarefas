import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget campoTexto(
    {Key? key,
    String label = '',
    Color? corLabel,
    String? hintText,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    bool aceitarApenasNumerosReais = false,
    bool aceitarApenasNumerosTelefone = false,
    int numeroCasasDecimais = 2,
    int? limiteMaximoCaracteres,
    bool aceitarApenasNumerosInteiros = false,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    Function(String?)? onSaved,
    FocusNode? focusNode,
    bool obscureText = false,
    double height = 45,
    String? initialValue,
    bool readOnly = false,
    Widget? suffixIcon,
    Function()? onTap,
    Function(String)? onFieldSubmitted}) {
  if ((inputFormatters ?? []).isEmpty) {
    if (aceitarApenasNumerosInteiros) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
      ];
      keyboardType ??= const TextInputType.numberWithOptions(decimal: false);
    } else {
      if (aceitarApenasNumerosReais) {
        inputFormatters = [
          // ignore: prefer_interpolation_to_compose_strings
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,' + numeroCasasDecimais.toString() + '}')),
        ];
        keyboardType ??= const TextInputType.numberWithOptions(decimal: true);
      } 
    }
  }
  const corBordaNormal = Color(0xFF333333);
  var corBordaErro = Colors.red.shade700;

  var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: corBordaNormal, width: 0));
  var errorBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: corBordaErro, width: 3));

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.trim().isNotEmpty) ...[
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 2),
          child: Text(
            label,
          ),
        )
      ],
      SizedBox(
        height: validator == null ? height : null,
        child: TextFormField(
          keyboardType: keyboardType,
          key: key,
          maxLength: limiteMaximoCaracteres,
          controller: controller,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          focusNode: focusNode,
          readOnly: readOnly,
          initialValue: initialValue,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
              counterText: '',
              suffixIcon: suffixIcon,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              isDense: false,
              isCollapsed: false,
              fillColor: Colors.white,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              hintText: hintText,
              errorBorder: errorBorder,
              ),
        ),
      ),
    ],
  );
}
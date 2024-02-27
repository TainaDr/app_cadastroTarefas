import 'package:flutter/material.dart';
import '../visao/utilitarios.dart';
import 'campo_texto.dart';

Widget campoData(BuildContext context,
    {String label = '',
    bool incluirHora = false,
    DateTime? initialValue,
    String? Function(String?)? validator,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    Function(String?)? onSaved,
    Function(DateTime? dataSelecionada)? onChanged}) {
      
  return campoTexto(
      key: Key((initialValue != null ? initialValue.toString() : "") + DateTime.now().toString()),
      label: label,
      validator: validator,
      initialValue: formatarData(initialValue),
      onSaved: onSaved,
      readOnly: true,
      onTap: () {
        showDatePicker(
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                    child: child ?? Container(),
                  );
                },
                context: context,
                initialEntryMode: initialEntryMode,
                initialDate: initialValue ?? DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100))
            .then((dataSelecionada) {
          initialValue = dataSelecionada;
          if (dataSelecionada != null && onChanged != null) {
            onChanged(dataSelecionada);
          }
        }
        
        );
        
      });
}
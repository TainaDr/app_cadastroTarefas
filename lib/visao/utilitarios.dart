
import 'package:intl/intl.dart';

String? formatarData(DateTime? data, {String? formato}) {
  if (data == null) return null;

  if (formato == 'MMMM') {
    switch (data.month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
    }
  }

  return DateFormat(formato ?? 'dd/MM/yyyy').format(data);
}

DateTime? converterStringParaDateTime(String? texto, {String? formato}){
    if (texto == null) return null;
    return DateFormat(formato ?? 'dd/MM/yyyy').parse(texto);
}


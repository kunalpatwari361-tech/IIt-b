// Rupee amounts in the Indian style: Rs 45,00,000, or 45 lakh / 1.2 crore in short form.
import 'package:intl/intl.dart';

final _inr = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

String rupees(num amount) => _inr.format(amount.round());

String rupeesShort(num amount, {String lang = 'en'}) {
  final hi = lang == 'hi';
  if (amount >= 1e7) return '₹${_trim(amount / 1e7)} ${hi ? 'करोड़' : 'crore'}';
  if (amount >= 1e5) return '₹${_trim(amount / 1e5)} ${hi ? 'लाख' : 'lakh'}';
  return rupees(amount);
}

String _trim(num x) => x.toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '');

String percent(double share) => '${(share * 100).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}%';

// Reason codes from the engine, in the customer's language. The wording is the
// report's (R-... codes); OK-... are the facts behind an offer.
import 'l10n/app_localizations.dart';
import 'format.dart';
import 'services/models.dart';

String reasonText(AppLocalizations t, Reason r, String lang) {
  String v(String k) => r.values[k] ?? '';
  switch (r.code) {
    case 'OK-SCORE':
      return t.okScore(v('score'));
    case 'OK-FOIR':
      return t.okFoir(v('pct'), v('cap'));
    case 'OK-LTV':
      return t.okLtv(v('pct'), v('cap'));
    case 'OK-VALUE':
      return t.okValue(rupeesShort(double.parse(v('low')), lang: lang), rupeesShort(double.parse(v('high')), lang: lang));
    case 'OK-TITLE':
      return t.okTitle;
    case 'R-KYC-01':
      return t.reasonKyc01;
    case 'R-FRD-02':
      return t.reasonFrd02;
    case 'R-FRD-03':
      return t.reasonFrd03;
    case 'R-POL-01':
      return t.reasonPol01;
    case 'R-POL-02':
      return t.reasonPol02;
    case 'R-BUR-01':
      return t.reasonBur01;
    case 'R-BUR-04':
      return t.reasonBur04;
    case 'R-BUR-05':
      return t.reasonBur05;
    case 'R-PRP-01':
      return t.reasonPrp01;
    case 'R-PRP-03':
      return t.reasonPrp03;
    case 'R-PRP-04':
      return t.reasonPrp04;
    case 'R-AFF-01':
      return t.reasonAff01;
    case 'R-AUT-01':
      return t.reasonAut01;
    case 'R-RSK-01':
      return t.reasonRsk01;
    case 'R-RSK-02':
      return t.reasonRsk02;
    default:
      return r.code;
  }
}

String docName(AppLocalizations t, DocSlot s) => switch (s) {
      DocSlot.pan => t.docPan,
      DocSlot.aadhaar => t.docAadhaar,
      DocSlot.salarySlip => t.docSalarySlip,
      DocSlot.form16 => t.docForm16,
      DocSlot.itr => t.docItr,
      DocSlot.gst => t.docGst,
      DocSlot.bankStatement => t.docBankStatement,
      _ => s.name,
    };

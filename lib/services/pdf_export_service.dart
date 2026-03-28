import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../providers/invoice_provider.dart';
import '../providers/profile_provider.dart';

class PdfExportService {
  static Future<void> printInvoice(
    Invoice invoice,
    ProfileProvider profile,
  ) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header(profile, 'FATTURA'),
              pw.SizedBox(height: 24),
              _infoRow('N. Fattura:', invoice.id.length > 8
                  ? invoice.id.substring(0, 8).toUpperCase()
                  : invoice.id.toUpperCase()),
              _infoRow('Data emissione:',
                  _fmtDate(invoice.createdAt)),
              _infoRow('Scadenza:', _fmtDate(invoice.dueDate)),
              _infoRow('Stato:', invoice.status),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 12),
              pw.Text('Cliente / Destinatario',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 13)),
              pw.SizedBox(height: 6),
              pw.Text(invoice.clientId),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 12),
              pw.Text('Descrizione',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 13)),
              pw.SizedBox(height: 6),
              pw.Text(invoice.description.isNotEmpty
                  ? invoice.description
                  : '—'),
              pw.SizedBox(height: 24),
              _totalRow(invoice.amount),
              pw.Spacer(),
              _footer(profile),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
      name:
          'fattura_${invoice.id.length > 8 ? invoice.id.substring(0, 8) : invoice.id}.pdf',
    );
  }

  static Future<void> printQuote(
    Map<String, dynamic> quote,
    ProfileProvider profile,
  ) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          final createdAt = quote['createdAt'] as DateTime;
          final id = quote['id'] as String;

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header(profile, 'PREVENTIVO'),
              pw.SizedBox(height: 24),
              _infoRow('N. Preventivo:',
                  id.length > 8 ? id.substring(0, 8).toUpperCase() : id.toUpperCase()),
              _infoRow('Data:', _fmtDate(createdAt)),
              _infoRow('Stato:', (quote['status'] as String?) ?? 'Draft'),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 12),
              pw.Text('Cliente',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 13)),
              pw.SizedBox(height: 6),
              pw.Text((quote['clientName'] as String?) ?? ''),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 12),
              pw.Text('Descrizione',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 13)),
              pw.SizedBox(height: 6),
              pw.Text((quote['description'] as String?)?.isNotEmpty == true
                  ? quote['description'] as String
                  : '—'),
              pw.SizedBox(height: 24),
              _totalRow((quote['amount'] as num).toDouble()),
              pw.Spacer(),
              _footer(profile),
            ],
          );
        },
      ),
    );

    final id = quote['id'] as String;
    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
      name:
          'preventivo_${id.length > 8 ? id.substring(0, 8) : id}.pdf',
    );
  }

  static pw.Widget _header(ProfileProvider profile, String docType) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (profile.company.isNotEmpty)
                pw.Text(profile.company,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 18)),
              if (profile.name.isNotEmpty)
                pw.Text(profile.name,
                    style: const pw.TextStyle(fontSize: 13)),
              if (profile.vatNumber.isNotEmpty)
                pw.Text('P.IVA: ${profile.vatNumber}',
                    style: const pw.TextStyle(fontSize: 11)),
              if (profile.address.isNotEmpty)
                pw.Text(profile.address,
                    style: const pw.TextStyle(fontSize: 11)),
            ],
          ),
        ),
        pw.Text(docType,
            style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blueGrey700)),
      ],
    );
  }

  static pw.Widget _infoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 140,
            child: pw.Text(label,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text(value),
        ],
      ),
    );
  }

  static pw.Widget _totalRow(double amount) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.blueGrey50,
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('TOTALE',
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
          pw.Text('€ ${amount.toStringAsFixed(2)}',
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }

  static pw.Widget _footer(ProfileProvider profile) {
    final parts = <String>[];
    if (profile.email.isNotEmpty) parts.add(profile.email);
    if (profile.phone.isNotEmpty) parts.add(profile.phone);
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Divider(),
        pw.SizedBox(height: 4),
        if (parts.isNotEmpty)
          pw.Text(
            parts.join(' · '),
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            textAlign: pw.TextAlign.center,
          ),
      ],
    );
  }

  static String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

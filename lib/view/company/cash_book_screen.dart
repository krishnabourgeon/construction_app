import 'dart:io';
import 'package:construction_app/models/cash_book_model.dart';
import 'package:construction_app/models/get_payment_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';



class CashbookScreen extends StatefulWidget {
  const CashbookScreen({super.key});

  @override
  State<CashbookScreen> createState() => _CashbookScreenState();
}

class _CashbookScreenState extends State<CashbookScreen> {
  SitesbyCompany? _selectedSite;
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  bool _generating = false;

  // Separate lists loaded independently
  // List<GetPayment> _receipts = [];
  // List<GetPayment> _payments = [];
  bool _loading = false;
  CashBook? _cashBook;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  Future<void> _init() async {
    final provider = context.read<CompanyProvider>();
    final companyId = await SharedPreferenceHelper.getCompanyId();
    await provider.sitesbycompanies(companyId: companyId);
    if (provider.sitesList.isNotEmpty) {
      setState(() => _selectedSite = provider.sitesList.first);
      await _load();
    }
    
  }

   Future<void> _load() async {
    if (_selectedSite == null) return;

    setState(() {
      _loading = true;
    });

    final provider = context.read<CompanyProvider>();

    final response = await provider.getCashBook(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      _selectedSite!.id,
      DateFormat('yyyy-MM-dd').format(_fromDate),
      DateFormat('yyyy-MM-dd').format(_toDate),
    );

    if (response != null) {
      setState(() {
        _cashBook = response.data;
      });
    }

     setState(() {
      _loading = false;
    });
  }

  Future<void> _pickDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? _fromDate : _toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromDate = picked;

          if (_toDate.isBefore(_fromDate)) {
            _toDate = _fromDate;
          }
        } else {
          _toDate = picked;

          if (_fromDate.isAfter(_toDate)) {
            _fromDate = _toDate;
          }
        }
      });
    }
  }

  String _fmt(double v) {
    return NumberFormat('#,##,##0.00').format(v);
  }

  Future<void> _generateAndShare() async {
    if (_cashBook == null) return;

    setState(() {
      _generating = true;
    });

    try {
      final pdf = pw.Document();

      final receipts = _cashBook!.receipts;
      final payments = _cashBook!.payments;

      final maxRows =
          receipts.length > payments.length
              ? receipts.length
              : payments.length;

      final dateRange =
          '${DateFormat('dd-MM-yyyy').format(_fromDate)} to ${DateFormat('dd-MM-yyyy').format(_toDate)}';

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(20),
          build:
              (context) => [
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "Cash Book",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      pw.SizedBox(height: 6),

                      pw.Text(
                        dateRange,
                        style: const pw.TextStyle(fontSize: 11),
                      ),

                      pw.SizedBox(height: 14),
                    ],
                  ),
                ),

                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(35),
                    1: const pw.FlexColumnWidth(3),
                    2: const pw.FixedColumnWidth(70),
                    3: const pw.FixedColumnWidth(80),
                    4: const pw.FixedColumnWidth(35),
                    5: const pw.FlexColumnWidth(3),
                    6: const pw.FixedColumnWidth(70),
                    7: const pw.FixedColumnWidth(80),
                  },
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      children: [
                        _pdfCell("No", bold: true),
                        _pdfCell("Receipts", bold: true),
                        _pdfCell("Date", bold: true),
                        _pdfCell("Amount", bold: true),

                        _pdfCell("No", bold: true),
                        _pdfCell("Payments", bold: true),
                        _pdfCell("Date", bold: true),
                        _pdfCell("Amount", bold: true),
                      ],
                    ),

                    pw.TableRow(
                      children: [
                        _pdfCell(""),
                        _pdfCell("Opening Balance"),
                        _pdfCell(""),
                        _pdfCell(
                          _fmt(
                            _cashBook!.openingBalance.toDouble(),
                          ),
                        ),

                        _pdfCell(""),
                        _pdfCell(""),
                        _pdfCell(""),
                        _pdfCell(""),
                      ],
                    ),

                    for (int i = 0; i < maxRows; i++)
                      pw.TableRow(
                        children: [
                          _pdfCell(
                            i < receipts.length
                                ? receipts[i].no.toString()
                                : '',
                          ),

                          _pdfCell(
                            i < receipts.length
                                ? receipts[i].particulars
                                : '',
                          ),

                          _pdfCell(
                            i < receipts.length
                                ? DateFormat(
                                  'dd/MM/yyyy',
                                ).format(receipts[i].date)
                                : '',
                          ),

                          _pdfCell(
                            i < receipts.length
                                ? _fmt(
                                  receipts[i].amount.toDouble(),
                                )
                                : '',
                          ),

                          _pdfCell(
                            i < payments.length
                                ? payments[i].no.toString()
                                : '',
                          ),

                          _pdfCell(
                            i < payments.length
                                ? payments[i].particulars
                                : '',
                          ),

                          _pdfCell(
                            i < payments.length
                                ? DateFormat(
                                  'dd/MM/yyyy',
                                ).format(payments[i].date)
                                : '',
                          ),

                          _pdfCell(
                            i < payments.length
                                ? _fmt(
                                  payments[i].amount.toDouble(),
                                )
                                : '',
                          ),
                        ],
                      ),

                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey200,
                      ),
                      children: [
                        _pdfCell(""),
                        _pdfCell("Total", bold: true),
                        _pdfCell(""),
                        _pdfCell(
                          _fmt(
                            _cashBook!.totalReceipts.toDouble(),
                          ),
                          bold: true,
                        ),

                        _pdfCell(""),
                        _pdfCell("Total", bold: true),
                        _pdfCell(""),
                        _pdfCell(
                          _fmt(
                            _cashBook!.totalPayments.toDouble(),
                          ),
                          bold: true,
                        ),
                      ],
                    ),

                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey100,
                      ),
                      children: [
                        _pdfCell(""),
                        _pdfCell(""),
                        _pdfCell(""),
                        _pdfCell(""),

                        _pdfCell(""),
                        _pdfCell("Closing Balance", bold: true),
                        _pdfCell(""),
                        _pdfCell(
                          _fmt(
                            _cashBook!.closingBalance.toDouble(),
                          ),
                          bold: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
        ),
      );

      final dir = await getTemporaryDirectory();

      final file = File(
        '${dir.path}/cashbook.pdf',
      );

      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [
          XFile(
            file.path,
            mimeType: 'application/pdf',
          ),
        ],
        text: 'Cash Book Report',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      _generating = false;
    });
  }

  pw.Widget _pdfCell(
    String text, {
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight:
              bold
                  ? pw.FontWeight.bold
                  : pw.FontWeight.normal,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();
    final dateRangeLabel =
        '${DateFormat('dd MMM yyyy').format(_fromDate)}  →  ${DateFormat('dd MMM yyyy').format(_toDate)}';

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 14,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Accounts',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: AppColors.greyLight)),
                          Text('Cash Book',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              )),
                        ],
                      ),
                    ),
                    // Share/WhatsApp button
                    GestureDetector(
                      onTap: (_loading || _generating) ? null : _generateAndShare,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: const Color(0xFF25D366),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _generating
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Row(
                                children: [
                                  const Icon(Icons.share_rounded,
                                      size: 16, color: Colors.white),
                                  const SizedBox(width: 5),
                                  Text('Share PDF',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Filters row ─────────────────────────────────────────
                Row(
                  children: [
                    // Site dropdown
                    Expanded(
                      flex: 2,
                      child: _FilterDropdown(
                        value: _selectedSite,
                        items: provider.sitesList,
                        onChanged: (v) {
                          setState(() => _selectedSite = v);
                          _load();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    // From date
                    Expanded(
                      child: _DateChip(
                        label: 'From',
                        date: _fromDate,
                        onTap: () async {
                          await _pickDate(true);
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    // To date
                    Expanded(
                      child: _DateChip(
                        label: 'To',
                        date: _toDate,
                        onTap: () async {
                          await _pickDate(false);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Search button
                    GestureDetector(
                      onTap: _load,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.search_rounded,
                            color: AppColors.dark, size: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Date range label ────────────────────────────────────────────
          Container(
            width: double.infinity,
            color: AppColors.navy.withOpacity(0.85),
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(
              'Cash Book  ·  $dateRangeLabel',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppColors.amberLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // ── Body ────────────────────────────────────────────────────────
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.amber))
                : _cashBook == null
    ? const Center(
        child: Text(
          "No Cash Book Data",
          style: TextStyle(fontSize: 16),
        ),
      )
    : _CashbookTable(
        cashBook: _cashBook!,
        fromDate: _fromDate,
        toDate: _toDate,
      ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Double-column cashbook table
// ─────────────────────────────────────────────────────────────────────────────

class _CashbookTable extends StatelessWidget {
  final CashBook cashBook;
  final DateTime fromDate;
  final DateTime toDate;

  const _CashbookTable({
    required this.cashBook,
    required this.fromDate,
    required this.toDate,
  });

   List<Payment> get receipts => cashBook.receipts;

  List<Payment> get payments => cashBook.payments;

  double get _totalR =>
      cashBook.totalReceipts.toDouble();

  double get _totalP =>
      cashBook.totalPayments.toDouble();

  double get _closing =>
      cashBook.closingBalance.toDouble();

  String _fmt(double v) {
    return NumberFormat('#,##,##0.00').format(v);
  }

  String _fmtDate(DateTime d) {
    return DateFormat('dd/MM/yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {
    final maxRows = receipts.length > payments.length
        ? receipts.length
        : payments.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // ── Double column table ────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      // ── Column headers ─────────────────────────────────
                      Row(
                        children: [
                          // Left header (Receipts)
                          _HeaderCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_downward_rounded,
                                    size: 13, color: AppColors.white),
                                const SizedBox(width: 4),
                                Text('RECEIPTS  (വരവ്)',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white)),
                              ],
                            ),
                            color: AppColors.green,
                            flex: 5,
                          ),
                          // Divider
                          Container(width: 1, height: 38, color: AppColors.border),
                          // Right header (Payments)
                          _HeaderCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_upward_rounded,
                                    size: 13, color: AppColors.white),
                                const SizedBox(width: 4),
                                Text('PAYMENTS  (ചെലവ്)',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white)),
                              ],
                            ),
                            color: AppColors.red,
                            flex: 5,
                          ),
                        ],
                      ),

                      // ── Sub-headers ────────────────────────────────────
                      _SubHeaderRow(),

                      const Divider(height: 1, color: AppColors.border),

                      // ── Opening balance row ────────────────────────────
                      _DataRow(
                        rNo: '',
                        rDesc: 'Opening Balance',
                        rDate: _fmtDate(fromDate),
                        rAmt: '',
                        pNo: '',
                        pDesc: '',
                        pDate: '',
                        pAmt: '',
                        highlight: true,
                        highlightColor: const Color(0xFFF0FDF4),
                      ),

                      const Divider(height: 1, color: AppColors.border),

                      // ── Data rows ──────────────────────────────────────
                      if (maxRows == 0)
                        _DataRow(
                          rNo: '-', rDesc: 'No receipts', rDate: '-', rAmt: '-',
                          pNo: '-', pDesc: 'No payments', pDate: '-', pAmt: '-',
                        ),

                      for (int i = 0; i < maxRows; i++) ...[
                        _DataRow(
                          rNo: i < receipts.length ? '${i + 1}' : '',
                          rDesc: i < receipts.length
                              ? '${receipts[i].stageName}\n${receipts[i].siteName}'
                              : '',
                          rDate: i < receipts.length
                              ? _fmtDate(receipts[i].date)
                              : '',
                          rAmt: i < receipts.length
                              ? _fmt(double.tryParse(
                                      receipts[i].amount.toString()) ??
                                  0)
                              : '',
                          pNo: i < payments.length ? '${i + 1}' : '',
                          pDesc: i < payments.length
                              ? '${payments[i].stageName}\n${payments[i].siteName}'
                              : '',
                          pDate: i < payments.length
                              ? _fmtDate(payments[i].date)
                              : '',
                          pAmt: i < payments.length
                              ? _fmt(double.tryParse(
                                      payments[i].amount.toString()) ??
                                  0)
                              : '',
                          even: i % 2 == 1,
                        ),
                        if (i < maxRows - 1)
                          const Divider(height: 1, color: AppColors.borderLight),
                      ],

                      const Divider(height: 1, color: AppColors.border),

                      // ── Total row ──────────────────────────────────────
                      _TotalRow(
                        label: 'ആകെ  (Total)',
                        rTotal: _fmt(_totalR),
                        pTotal: _fmt(_totalP),
                        bgColor: const Color(0xFFF9FAFB),
                      ),

                      const Divider(height: 1, color: AppColors.border),

                      // ── Closing balance row ────────────────────────────
                      _DataRow(
                        rNo: '',
                        rDesc: '',
                        rDate: '',
                        rAmt: '',
                        pNo: '',
                        pDesc: 'Closing Balance',
                        pDate: _fmtDate(toDate),
                        pAmt: _fmt(_closing),
                        highlight: true,
                        highlightColor: const Color(0xFFFFF7ED),
                      ),

                      const Divider(height: 1, color: AppColors.border),

                      // ── Grand total row ────────────────────────────────
                      _TotalRow(
                        label: 'Grand Total',
                        rTotal: _fmt(_totalR),
                        pTotal: _fmt(_closing < 0
                            ? _totalP
                            : _totalR),
                        bgColor: AppColors.amberLight,
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Summary cards ────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  label: 'Total Receipts',
                  amount: _fmt(_totalR),
                  icon: Icons.arrow_downward_rounded,
                  color: AppColors.green,
                  bgColor: const Color(0xFFF0FDF4),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryCard(
                  label: 'Total Payments',
                  amount: _fmt(_totalP),
                  icon: Icons.arrow_upward_rounded,
                  color: AppColors.red,
                  bgColor: const Color(0xFFFFF1F2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _SummaryCard(
            label: _closing >= 0 ? 'Closing Balance (Surplus)' : 'Closing Balance (Deficit)',
            amount: _fmt(_closing),
            icon: Icons.account_balance_wallet_rounded,
            color: _closing >= 0 ? AppColors.blue : AppColors.red,
            bgColor: _closing >= 0 ? AppColors.blueLight : AppColors.redLight,
            wide: true,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _HeaderCell extends StatelessWidget {
  final Widget child;
  final Color color;
  final int flex;
  const _HeaderCell(
      {required this.child, required this.color, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 38,
        color: color,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class _SubHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(
        fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.grey);
    return Container(
      color: AppColors.greyBg,
      child: Row(
        children: [
          SizedBox(width: 32, child: Center(child: Text('No', style: style))),
          _vDivider(),
          SizedBox(
              width: 160,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text('Particulars', style: style))),
          _vDivider(),
          SizedBox(
              width: 70,
              child: Center(child: Text('Date', style: style))),
          _vDivider(),
          SizedBox(
              width: 90,
              child: Center(child: Text('Amount (₹)', style: style))),
          _vDivider(),
          SizedBox(width: 32, child: Center(child: Text('No', style: style))),
          _vDivider(),
          SizedBox(
              width: 160,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text('Particulars', style: style))),
          _vDivider(),
          SizedBox(
              width: 70,
              child: Center(child: Text('Date', style: style))),
          _vDivider(),
          SizedBox(
              width: 90,
              child: Center(child: Text('Amount (₹)', style: style))),
        ],
      ),
    );
  }

  Widget _vDivider() =>
      Container(width: 1, height: 30, color: AppColors.border);
}

class _DataRow extends StatelessWidget {
  final String rNo, rDesc, rDate, rAmt;
  final String pNo, pDesc, pDate, pAmt;
  final bool highlight;
  final Color? highlightColor;
  final bool even;

  const _DataRow({
    required this.rNo,
    required this.rDesc,
    required this.rDate,
    required this.rAmt,
    required this.pNo,
    required this.pDesc,
    required this.pDate,
    required this.pAmt,
    this.highlight = false,
    this.highlightColor,
    this.even = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = highlight
        ? highlightColor!
        : even
            ? const Color(0xFFFAFAFA)
            : AppColors.white;

    final descStyle =
        GoogleFonts.poppins(fontSize: 11, color: AppColors.dark, height: 1.4);
    final noStyle =
        GoogleFonts.poppins(fontSize: 11, color: AppColors.grey);
    final amtStyle = GoogleFonts.poppins(
        fontSize: 11, color: AppColors.dark, fontWeight: FontWeight.w500);
    final dateStyle =
        GoogleFonts.poppins(fontSize: 10, color: AppColors.grey);

    return Container(
      color: bg,
      constraints: const BoxConstraints(minHeight: 38),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 32,
                child: Center(child: Text(rNo, style: noStyle))),
            _vDivider(),
            SizedBox(
                width: 160,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(rDesc, style: descStyle),
                )),
            _vDivider(),
            SizedBox(
                width: 70,
                child: Center(child: Text(rDate, style: dateStyle))),
            _vDivider(),
            SizedBox(
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(rAmt, style: amtStyle),
                  ),
                )),
            // ── center divider ──────────────────────────────────────────
            Container(width: 2, color: AppColors.border),
            SizedBox(
                width: 32,
                child: Center(child: Text(pNo, style: noStyle))),
            _vDivider(),
            SizedBox(
                width: 160,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(pDesc, style: descStyle),
                )),
            _vDivider(),
            SizedBox(
                width: 70,
                child: Center(child: Text(pDate, style: dateStyle))),
            _vDivider(),
            SizedBox(
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(pAmt, style: amtStyle),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _vDivider() =>
      Container(width: 1, color: AppColors.borderLight);
}

class _TotalRow extends StatelessWidget {
  final String label, rTotal, pTotal;
  final Color bgColor;
  final bool bold;

  const _TotalRow({
    required this.label,
    required this.rTotal,
    required this.pTotal,
    required this.bgColor,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
      color: AppColors.dark,
    );
    return Container(
      color: bgColor,
      height: 40,
      child: Row(
        children: [
          SizedBox(width: 32, child: const SizedBox()),
          Container(width: 1, height: 40, color: AppColors.border),
          SizedBox(
            width: 160,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(label, style: style),
            ),
          ),
          Container(width: 1, height: 40, color: AppColors.border),
          SizedBox(width: 70),
          Container(width: 1, height: 40, color: AppColors.border),
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(rTotal,
                    style: style.copyWith(color: AppColors.green)),
              ),
            ),
          ),
          Container(width: 2, color: AppColors.border),
          SizedBox(width: 32),
          Container(width: 1, height: 40, color: AppColors.border),
          SizedBox(
            width: 160,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(label, style: style),
            ),
          ),
          Container(width: 1, height: 40, color: AppColors.border),
          SizedBox(width: 70),
          Container(width: 1, height: 40, color: AppColors.border),
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(pTotal,
                    style: style.copyWith(color: AppColors.red)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label, amount;
  final IconData icon;
  final Color color, bgColor;
  final bool wide;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
    required this.bgColor,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: color.withOpacity(0.8))),
                Text('₹$amount',
                    style: GoogleFonts.poppins(
                      fontSize: wide ? 16 : 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small reusable widgets ────────────────────────────────────────────────────

class _FilterDropdown extends StatelessWidget {
  final SitesbyCompany? value;
  final List<SitesbyCompany> items;
  final ValueChanged<SitesbyCompany?> onChanged;

  const _FilterDropdown(
      {required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SitesbyCompany>(
          value: value,
          isExpanded: true,
          hint: Text('Select site',
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.greyLight)),
          dropdownColor: AppColors.navy,
          style:
              GoogleFonts.poppins(fontSize: 12, color: AppColors.white),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.greyLight, size: 18),
          items: items
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s.sitename,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.white)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _DateChip(
      {required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.amber.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.amber.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 12, color: AppColors.amber),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                DateFormat('dd MMM').format(date),
                style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.amber),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




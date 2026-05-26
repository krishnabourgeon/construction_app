// // To parse this JSON data, do
// //
// //     final cashBookModel = cashBookModelFromJson(jsonString);

// import 'dart:convert';

// CashBookModel cashBookModelFromJson(String str) => CashBookModel.fromJson(json.decode(str));

// String cashBookModelToJson(CashBookModel data) => json.encode(data.toJson());

// class CashBookModel {
//     bool status;
//     String message;
//     CashBook data;

//     CashBookModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory CashBookModel.fromJson(Map<String, dynamic> json) => CashBookModel(
//         status: json["status"],
//         message: json["message"],
//         data: CashBook.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class CashBook {
//     int siteId;
//     DateTime fromDate;
//     DateTime toDate;
//     int openingBalance;
//     List<Payment> receipts;
//     int totalReceipts;
//     List<Payment> payments;
//     int totalPayments;
//     int closingBalance;
//     String balanceType;

//     CashBook({
//         required this.siteId,
//         required this.fromDate,
//         required this.toDate,
//         required this.openingBalance,
//         required this.receipts,
//         required this.totalReceipts,
//         required this.payments,
//         required this.totalPayments,
//         required this.closingBalance,
//         required this.balanceType,
//     });

//     factory CashBook.fromJson(Map<String, dynamic> json) => CashBook(
//         siteId: json["site_id"],
//         fromDate: DateTime.parse(json["from_date"]),
//         toDate: DateTime.parse(json["to_date"]),
//         openingBalance: json["opening_balance"],
//         receipts: List<Payment>.from(json["receipts"].map((x) => Payment.fromJson(x))),
//         totalReceipts: json["total_receipts"],
//         payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
//         totalPayments: json["total_payments"],
//         closingBalance: json["closing_balance"],
//         balanceType: json["balance_type"],
//     );

//     Map<String, dynamic> toJson() => {
//         "site_id": siteId,
//         "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
//         "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
//         "opening_balance": openingBalance,
//         "receipts": List<dynamic>.from(receipts.map((x) => x.toJson())),
//         "total_receipts": totalReceipts,
//         "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
//         "total_payments": totalPayments,
//         "closing_balance": closingBalance,
//         "balance_type": balanceType,
//     };
// }

// class Payment {
//     int no;
//     int id;
//     String particulars;
//     String ledgerGroup;
//     String paymentMode;
//     DateTime date;
//     int amount;
//     String? remarks;

//     Payment({
//         required this.no,
//         required this.id,
//         required this.particulars,
//         required this.ledgerGroup,
//         required this.paymentMode,
//         required this.date,
//         required this.amount,
//         this.remarks,
//     });

//     factory Payment.fromJson(Map<String, dynamic> json) => Payment(
//         no: json["no"],
//         id: json["id"],
//         particulars: json["particulars"],
//         ledgerGroup: json["ledger_group"],
//         paymentMode: json["payment_mode"],
//         date: DateTime.parse(json["date"]),
//         amount: json["amount"],
//         remarks: json["remarks"]?.toString(),
//     );

//     Map<String, dynamic> toJson() => {
//         "no": no,
//         "id": id,
//         "particulars": particulars,
//         "ledger_group": ledgerGroup,
//         "payment_mode": paymentMode,
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "amount": amount,
//         "remarks": remarks,
//     };
// }





// To parse this JSON data, do
//
//     final cashBookModel = cashBookModelFromJson(jsonString);

import 'dart:convert';

CashBookModel cashBookModelFromJson(String str) => CashBookModel.fromJson(json.decode(str));

String cashBookModelToJson(CashBookModel data) => json.encode(data.toJson());

class CashBookModel {
    bool status;
    String message;
    CashBook data;

    CashBookModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CashBookModel.fromJson(Map<String, dynamic> json) => CashBookModel(
        status: json["status"],
        message: json["message"],
        data: CashBook.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class CashBook {
    int siteId;
    DateTime fromDate;
    DateTime toDate;
    int openingBalance;
    List<Payment> receipts;
    int totalReceipts;
    List<Payment> payments;
    int totalPayments;
    int closingBalance;
    String balanceType;

    CashBook({
        required this.siteId,
        required this.fromDate,
        required this.toDate,
        required this.openingBalance,
        required this.receipts,
        required this.totalReceipts,
        required this.payments,
        required this.totalPayments,
        required this.closingBalance,
        required this.balanceType,
    });

    factory CashBook.fromJson(Map<String, dynamic> json) => CashBook(
        siteId: json["site_id"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        openingBalance: json["opening_balance"],
        receipts: List<Payment>.from(json["receipts"].map((x) => Payment.fromJson(x))),
        totalReceipts: json["total_receipts"],
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
        totalPayments: json["total_payments"],
        closingBalance: json["closing_balance"],
        balanceType: json["balance_type"],
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "opening_balance": openingBalance,
        "receipts": List<dynamic>.from(receipts.map((x) => x.toJson())),
        "total_receipts": totalReceipts,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "total_payments": totalPayments,
        "closing_balance": closingBalance,
        "balance_type": balanceType,
    };
}

class Payment {
    int no;
    int id;
    String particulars;
    String ledgerGroup;
    String paymentMode;
    String siteName;
    String stageName;
    DateTime date;
    int amount;
    String? remarks;

    Payment({
        required this.no,
        required this.id,
        required this.particulars,
        required this.ledgerGroup,
        required this.paymentMode,
        required this.siteName,
        required this.stageName,
        required this.date,
        required this.amount,
        this.remarks,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        no: json["no"],
        id: json["id"],
        particulars: json["particulars"],
        ledgerGroup: json["ledger_group"],
        paymentMode: json["payment_mode"],
        siteName: json["site_name"],
        stageName: json["stage_name"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        remarks: json["remarks"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "particulars": particulars,
        "ledger_group": ledgerGroup,
        "payment_mode": paymentMode,
        "site_name": siteName,
        "stage_name": stageName,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "remarks": remarks,
    };
}






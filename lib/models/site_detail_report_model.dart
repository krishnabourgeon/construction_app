// To parse this JSON data, do
//
//     final siteDetailReportModel = siteDetailReportModelFromJson(jsonString);

import 'dart:convert';

SiteDetailReportModel siteDetailReportModelFromJson(String str) => SiteDetailReportModel.fromJson(json.decode(str));

String siteDetailReportModelToJson(SiteDetailReportModel data) => json.encode(data.toJson());

class SiteDetailReportModel {
    bool status;
    String message;
    SiteDetailReportData data;

    SiteDetailReportModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SiteDetailReportModel.fromJson(Map<String, dynamic> json) => SiteDetailReportModel(
        status: json["status"],
        message: json["message"],
        data: SiteDetailReportData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class SiteDetailReportData {
    int siteId;
    String siteName;
    FinancialSummary financialSummary;
    ExpenseBreakdown expenseBreakdown;
    ProjectProgress projectProgress;

    SiteDetailReportData({
        required this.siteId,
        required this.siteName,
        required this.financialSummary,
        required this.expenseBreakdown,
        required this.projectProgress,
    });

    factory SiteDetailReportData.fromJson(Map<String, dynamic> json) => SiteDetailReportData(
        siteId: json["site_id"],
        siteName: json["site_name"],
        financialSummary: FinancialSummary.fromJson(json["financial_summary"]),
        expenseBreakdown: ExpenseBreakdown.fromJson(json["expense_breakdown"]),
        projectProgress: ProjectProgress.fromJson(json["project_progress"]),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "site_name": siteName,
        "financial_summary": financialSummary.toJson(),
        "expense_breakdown": expenseBreakdown.toJson(),
        "project_progress": projectProgress.toJson(),
    };
}

class ExpenseBreakdown {
    Labour materials;
    Labour labour;

    ExpenseBreakdown({
        required this.materials,
        required this.labour,
    });

    factory ExpenseBreakdown.fromJson(Map<String, dynamic> json) => ExpenseBreakdown(
        materials: Labour.fromJson(json["materials"]),
        labour: Labour.fromJson(json["labour"]),
    );

    Map<String, dynamic> toJson() => {
        "materials": materials.toJson(),
        "labour": labour.toJson(),
    };
}

class Labour {
    int count;
    double amount;

    Labour({
        required this.count,
        required this.amount,
    });

    factory Labour.fromJson(Map<String, dynamic> json) => Labour(
        count: json["count"],
        amount: _parseDouble(json["amount"]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "amount": amount,
    };
}

class FinancialSummary {
    double estimatedBudget;
    double totalSpent;
    double totalReceived;
    double balance;

    FinancialSummary({
        required this.estimatedBudget,
        required this.totalSpent,
        required this.totalReceived,
        required this.balance,
    });

    factory FinancialSummary.fromJson(Map<String, dynamic> json) => FinancialSummary(
        estimatedBudget: _parseDouble(json["estimated_budget"]),
        totalSpent: _parseDouble(json["total_spent"]),
        totalReceived: _parseDouble(json["total_received"]),
        balance: _parseDouble(json["balance"]),
    );

    Map<String, dynamic> toJson() => {
        "estimated_budget": estimatedBudget,
        "total_spent": totalSpent,
        "total_received": totalReceived,
        "balance": balance,
    };
}

class ProjectProgress {
    int totalStages;
    int completed;
    int inProgress;
    double budgetUsedPct;

    ProjectProgress({
        required this.totalStages,
        required this.completed,
        required this.inProgress,
        required this.budgetUsedPct,
    });

    factory ProjectProgress.fromJson(Map<String, dynamic> json) => ProjectProgress(
        totalStages: json["total_stages"] ?? 0,
        completed: json["completed"] ?? 0,
        inProgress: json["in_progress"] ?? 0,
        budgetUsedPct: _parseDouble(json["budget_used_pct"]),
    );

    Map<String, dynamic> toJson() => {
        "total_stages": totalStages,
        "completed": completed,
        "in_progress": inProgress,
        "budget_used_pct": budgetUsedPct,
    };
}

double _parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

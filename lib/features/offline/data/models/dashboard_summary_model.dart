class DashboardSummaryModel {
  final int totalTenants;
  final int paidCount;
  final int unpaidCount;
  final int overdueCount;

  const DashboardSummaryModel({
    required this.totalTenants,
    required this.paidCount,
    required this.unpaidCount,
    required this.overdueCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardSummaryModel &&
          other.totalTenants == totalTenants &&
          other.paidCount == paidCount &&
          other.unpaidCount == unpaidCount &&
          other.overdueCount == overdueCount;

  @override
  int get hashCode =>
      totalTenants.hashCode ^
      paidCount.hashCode ^
      unpaidCount.hashCode ^
      overdueCount.hashCode;
}

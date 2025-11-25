class DashboardSummaryModel {
  final int totalTenants;
  final int totalPaid;
  final int totalUnpaid;
  final int totalOverdue;

  DashboardSummaryModel({
    required this.totalTenants,
    required this.totalPaid,
    required this.totalUnpaid,
    required this.totalOverdue,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DashboardSummaryModel &&
            other.totalTenants == totalTenants &&
            other.totalPaid == totalPaid &&
            other.totalUnpaid == totalUnpaid &&
            other.totalOverdue == totalOverdue;
  }

  @override
  int get hashCode =>
      totalTenants.hashCode ^
      totalPaid.hashCode ^
      totalUnpaid.hashCode ^
      totalOverdue.hashCode;
}

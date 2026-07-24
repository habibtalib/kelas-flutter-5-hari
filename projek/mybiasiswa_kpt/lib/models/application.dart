import 'package:flutter/material.dart';

/// Status kitaran hayat sesuatu permohonan biasiswa.
enum ApplicationStatus {
  draft,
  submitted,
  underReview,
  interview,
  approved,
  rejected;

  String get label => switch (this) {
        ApplicationStatus.draft => 'Draf',
        ApplicationStatus.submitted => 'Dihantar',
        ApplicationStatus.underReview => 'Dalam Semakan',
        ApplicationStatus.interview => 'Temuduga',
        ApplicationStatus.approved => 'Diluluskan',
        ApplicationStatus.rejected => 'Ditolak',
      };

  /// Warna badge status untuk paparan UI.
  Color get color => switch (this) {
        ApplicationStatus.draft => Colors.grey,
        ApplicationStatus.submitted => Colors.blue,
        ApplicationStatus.underReview => Colors.orange,
        ApplicationStatus.interview => Colors.purple,
        ApplicationStatus.approved => Colors.green,
        ApplicationStatus.rejected => Colors.red,
      };

  static ApplicationStatus fromString(String value) {
    return ApplicationStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => ApplicationStatus.draft,
    );
  }
}

/// Satu permohonan yang dibuat oleh pelajar untuk sesuatu biasiswa.
class ScholarshipApplication {
  final String id;
  final String scholarshipId;
  final String scholarshipName;
  final String applicantName;
  final String icNumber;
  final String email;
  final String phone;
  final String institution;
  final double currentCgpa;
  final ApplicationStatus status;
  final DateTime? submittedAt;
  final String? notes;

  const ScholarshipApplication({
    required this.id,
    required this.scholarshipId,
    required this.scholarshipName,
    required this.applicantName,
    required this.icNumber,
    required this.email,
    required this.phone,
    required this.institution,
    required this.currentCgpa,
    this.status = ApplicationStatus.submitted,
    this.submittedAt,
    this.notes,
  });

  /// Salin dengan sebahagian medan ditukar (corak immutable).
  ScholarshipApplication copyWith({ApplicationStatus? status, String? notes}) {
    return ScholarshipApplication(
      id: id,
      scholarshipId: scholarshipId,
      scholarshipName: scholarshipName,
      applicantName: applicantName,
      icNumber: icNumber,
      email: email,
      phone: phone,
      institution: institution,
      currentCgpa: currentCgpa,
      status: status ?? this.status,
      submittedAt: submittedAt,
      notes: notes ?? this.notes,
    );
  }

  factory ScholarshipApplication.fromJson(Map<String, dynamic> json) {
    return ScholarshipApplication(
      id: json['id'] as String,
      scholarshipId: json['scholarshipId'] as String,
      scholarshipName: json['scholarshipName'] as String,
      applicantName: json['applicantName'] as String,
      icNumber: json['icNumber'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      institution: json['institution'] as String,
      currentCgpa: (json['currentCgpa'] as num).toDouble(),
      status: ApplicationStatus.fromString(json['status'] as String),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'scholarshipId': scholarshipId,
        'scholarshipName': scholarshipName,
        'applicantName': applicantName,
        'icNumber': icNumber,
        'email': email,
        'phone': phone,
        'institution': institution,
        'currentCgpa': currentCgpa,
        'status': status.name,
        'submittedAt': submittedAt?.toIso8601String(),
        'notes': notes,
      };
}

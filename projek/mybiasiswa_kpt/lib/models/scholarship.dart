/// Model utama: satu tawaran biasiswa KPT.
///
/// Cermin portal sebenar biasiswa.mohe.gov.my.
library;

/// Kategori biasiswa mengikut portal rasmi KPT.
enum ScholarshipCategory {
  praPerkhidmatan,
  dalamPerkhidmatan,
  bantuanKewangan,
  antarabangsa;

  /// Label Bahasa Melayu untuk paparan UI.
  String get label => switch (this) {
        ScholarshipCategory.praPerkhidmatan => 'Pra Perkhidmatan',
        ScholarshipCategory.dalamPerkhidmatan => 'Dalam Perkhidmatan',
        ScholarshipCategory.bantuanKewangan => 'Bantuan Kewangan',
        ScholarshipCategory.antarabangsa => 'Antarabangsa',
      };

  static ScholarshipCategory fromString(String value) {
    return ScholarshipCategory.values.firstWhere(
      (c) => c.name == value,
      orElse: () => ScholarshipCategory.praPerkhidmatan,
    );
  }
}

/// Peringkat pengajian yang ditaja.
enum StudyLevel {
  sijil,
  diploma,
  bachelor,
  master,
  phd,
  postDoctoral;

  String get label => switch (this) {
        StudyLevel.sijil => 'Sijil',
        StudyLevel.diploma => 'Diploma',
        StudyLevel.bachelor => 'Ijazah Sarjana Muda',
        StudyLevel.master => 'Sarjana',
        StudyLevel.phd => 'PhD',
        StudyLevel.postDoctoral => 'Pasca Kedoktoran',
      };

  static StudyLevel fromString(String value) {
    return StudyLevel.values.firstWhere(
      (s) => s.name == value,
      orElse: () => StudyLevel.bachelor,
    );
  }
}

class Scholarship {
  final String id;
  final String code;
  final String name;
  final String provider;
  final ScholarshipCategory category;
  final StudyLevel studyLevel;
  final String fieldOfStudy;
  final double monthlyAllowance;
  final bool tuitionCoverage;
  final double minCgpa;
  final int maxAge;
  final DateTime applicationDeadline;
  final bool isOpen;
  final String description;
  final List<String> requirements;
  final String websiteUrl;

  const Scholarship({
    required this.id,
    required this.code,
    required this.name,
    required this.provider,
    required this.category,
    required this.studyLevel,
    required this.fieldOfStudy,
    required this.monthlyAllowance,
    required this.tuitionCoverage,
    required this.minCgpa,
    required this.maxAge,
    required this.applicationDeadline,
    required this.isOpen,
    required this.description,
    required this.requirements,
    required this.websiteUrl,
  });

  /// Bina objek Scholarship daripada JSON (guna bila sambung API — Hari 4).
  factory Scholarship.fromJson(Map<String, dynamic> json) {
    return Scholarship(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      provider: json['provider'] as String,
      category: ScholarshipCategory.fromString(json['category'] as String),
      studyLevel: StudyLevel.fromString(json['studyLevel'] as String),
      fieldOfStudy: json['fieldOfStudy'] as String,
      monthlyAllowance: (json['monthlyAllowance'] as num).toDouble(),
      tuitionCoverage: json['tuitionCoverage'] as bool,
      minCgpa: (json['minCgpa'] as num).toDouble(),
      maxAge: json['maxAge'] as int,
      applicationDeadline: DateTime.parse(json['applicationDeadline'] as String),
      isOpen: json['isOpen'] as bool,
      description: json['description'] as String,
      requirements: (json['requirements'] as List).cast<String>(),
      websiteUrl: json['websiteUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'provider': provider,
        'category': category.name,
        'studyLevel': studyLevel.name,
        'fieldOfStudy': fieldOfStudy,
        'monthlyAllowance': monthlyAllowance,
        'tuitionCoverage': tuitionCoverage,
        'minCgpa': minCgpa,
        'maxAge': maxAge,
        'applicationDeadline': applicationDeadline.toIso8601String(),
        'isOpen': isOpen,
        'description': description,
        'requirements': requirements,
        'websiteUrl': websiteUrl,
      };
}

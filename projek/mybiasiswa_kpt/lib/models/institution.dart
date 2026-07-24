/// Institusi Pendidikan Tinggi (IPT) — untuk dropdown borang permohonan.
enum InstitutionType {
  iptaUniversity,
  politeknik,
  kolejKomuniti,
  ipts;

  String get label => switch (this) {
        InstitutionType.iptaUniversity => 'Universiti Awam (IPTA)',
        InstitutionType.politeknik => 'Politeknik',
        InstitutionType.kolejKomuniti => 'Kolej Komuniti',
        InstitutionType.ipts => 'Institusi Swasta (IPTS)',
      };
}

class Institution {
  final String id;
  final String name;
  final String shortName;
  final String state;
  final InstitutionType type;

  const Institution({
    required this.id,
    required this.name,
    required this.shortName,
    required this.state,
    required this.type,
  });
}

import '../models/institution.dart';

/// Senarai IPTA untuk dropdown borang permohonan (Hari 2).
const List<Institution> institutions = [
  Institution(id: 'UM', name: 'Universiti Malaya', shortName: 'UM', state: 'Kuala Lumpur', type: InstitutionType.iptaUniversity),
  Institution(id: 'USM', name: 'Universiti Sains Malaysia', shortName: 'USM', state: 'Pulau Pinang', type: InstitutionType.iptaUniversity),
  Institution(id: 'UKM', name: 'Universiti Kebangsaan Malaysia', shortName: 'UKM', state: 'Selangor', type: InstitutionType.iptaUniversity),
  Institution(id: 'UPM', name: 'Universiti Putra Malaysia', shortName: 'UPM', state: 'Selangor', type: InstitutionType.iptaUniversity),
  Institution(id: 'UTM', name: 'Universiti Teknologi Malaysia', shortName: 'UTM', state: 'Johor', type: InstitutionType.iptaUniversity),
  Institution(id: 'UiTM', name: 'Universiti Teknologi MARA', shortName: 'UiTM', state: 'Selangor', type: InstitutionType.iptaUniversity),
  Institution(id: 'UUM', name: 'Universiti Utara Malaysia', shortName: 'UUM', state: 'Kedah', type: InstitutionType.iptaUniversity),
  Institution(id: 'UMS', name: 'Universiti Malaysia Sabah', shortName: 'UMS', state: 'Sabah', type: InstitutionType.iptaUniversity),
  Institution(id: 'UNIMAS', name: 'Universiti Malaysia Sarawak', shortName: 'UNIMAS', state: 'Sarawak', type: InstitutionType.iptaUniversity),
  Institution(id: 'IIUM', name: 'Universiti Islam Antarabangsa Malaysia', shortName: 'UIAM', state: 'Selangor', type: InstitutionType.iptaUniversity),
];

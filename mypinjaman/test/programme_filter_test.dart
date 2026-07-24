import 'package:flutter_test/flutter_test.dart';
import 'package:mypinjaman/data/sample_programmes.dart';
import 'package:mypinjaman/utils/programme_filter.dart';

void main() {
  test('no filter returns all 8 programmes', () {
    expect(filterProgrammes(sampleProgrammes).length, 8);
  });

  test('country filter Morocco returns only Morocco offers', () {
    final r = filterProgrammes(sampleProgrammes, country: 'Morocco');
    expect(r.every((p) => p.country == 'Morocco'), isTrue);
    expect(r.isNotEmpty, isTrue);
  });

  test('search matches field of study (case-insensitive)', () {
    final r = filterProgrammes(sampleProgrammes, query: 'perubatan');
    expect(r.isNotEmpty, isTrue);
    expect(r.every((p) => p.fieldOfStudy.toLowerCase().contains('perubatan')), isTrue);
  });

  test('uniqueCountries returns Egypt and Morocco', () {
    final c = uniqueCountries(sampleProgrammes)..sort();
    expect(c, ['Egypt', 'Morocco']);
  });

  test('byCountryAndField filters to matching offers', () {
    final field = sampleProgrammes.first.fieldOfStudy;
    final country = sampleProgrammes.first.country;
    final r = byCountryAndField(sampleProgrammes, country, field);
    expect(r.every((p) => p.country == country && p.fieldOfStudy == field), isTrue);
    expect(r.isNotEmpty, isTrue);
  });
}

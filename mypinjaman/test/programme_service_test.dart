import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mypinjaman/data/sample_programmes.dart';
import 'package:mypinjaman/services/programme_service.dart';

void main() {
  test('falls back to local list on non-200 response', () async {
    final client = MockClient((_) async => http.Response('nope', 500));
    final service = ProgrammeService(client: client);
    final result = await service.fetchProgrammes();
    expect(result.length, sampleProgrammes.length);
  });

  test('parses a valid JSON list', () async {
    const json = '[{"id":"X-1","universityName":"Uni Test","country":"Egypt",'
        '"city":"Cairo","fieldOfStudy":"Perubatan","studyLevel":"bachelor",'
        '"category":"spm","estimatedAnnualCostMyr":10000,'
        '"intakeMonth":"September","recognitionNote":"nota","quotaSeats":10}]';
    final client = MockClient((_) async => http.Response(json, 200));
    final service = ProgrammeService(client: client);
    final result = await service.fetchProgrammes();
    expect(result.single.universityName, 'Uni Test');
  });
}

import 'package:fast_immutable_collections_benchmarks/'
    'fast_immutable_collections_benchmarks.dart';

void main() {
  final FullListReporter fullReporter = FullListReporter()..report();

  fullReporter.benchmarks.forEach((MultiBenchmarkReporter benchmarkReporter) {
    benchmarkReporter.benchmarks.forEach((CollectionBenchmarkBase benchmark) {
      print(benchmark.emitter);
    });
  });
}

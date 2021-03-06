import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../utils/config.dart';
import '../../utils/multi_benchmark_reporter.dart';
import '../../utils/collection_benchmark_base.dart';

class ListRemoveBenchmark extends MultiBenchmarkReporter<ListBenchmarkBase> {
  @override
  final String prefixName;
  @override
  final List<Config> configs;
  @override
  final List<ListBenchmarkBase> baseBenchmarks = [
    MutableListRemoveBenchmark(config: null, emitter: null),
    IListRemoveBenchmark(config: null, emitter: null),
    KtListRemoveBenchmark(config: null, emitter: null),
    BuiltListRemoveBenchmark(config: null, emitter: null),
  ];

  ListRemoveBenchmark(
      {this.prefixName = 'list_remove', @required this.configs});
}

class MutableListRemoveBenchmark extends ListBenchmarkBase {
  MutableListRemoveBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'List (Mutable)', config: config, emitter: emitter);

  @override
  MutableListRemoveBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      MutableListRemoveBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  List<int> _list;

  @override
  List<int> toMutable() => _list;

  @override
  void setup() => _list = ListBenchmarkBase.getDummyGeneratedList();

  @override
  void run() => _list.remove(1);
}

class IListRemoveBenchmark extends ListBenchmarkBase {
  IListRemoveBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'IList', config: config, emitter: emitter);

  @override
  IListRemoveBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      IListRemoveBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  IList<int> _iList;

  @override
  List<int> toMutable() => _iList.unlock;

  @override
  void setup() =>
      _iList = IList<int>(ListBenchmarkBase.getDummyGeneratedList());

  @override
  void run() => _iList = _iList.remove(1);
}

class KtListRemoveBenchmark extends ListBenchmarkBase {
  KtListRemoveBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'KtList', config: config, emitter: emitter);

  @override
  KtListRemoveBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      KtListRemoveBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  KtList<int> _ktList;

  @override
  List<int> toMutable() => _ktList.asList();

  @override
  void setup() =>
      _ktList = KtList<int>.from(ListBenchmarkBase.getDummyGeneratedList());

  @override
  void run() => _ktList = _ktList.minusElement(1);
}

class BuiltListRemoveBenchmark extends ListBenchmarkBase {
  BuiltListRemoveBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'BuiltList', config: config, emitter: emitter);

  @override
  BuiltListRemoveBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      BuiltListRemoveBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  BuiltList<int> _builtList;

  @override
  List<int> toMutable() => _builtList.asList();

  @override
  void setup() =>
      _builtList = BuiltList<int>.of(ListBenchmarkBase.getDummyGeneratedList());

  @override
  void run() => _builtList = _builtList
      .rebuild((ListBuilder<int> listBuilder) => listBuilder.remove(1));
}

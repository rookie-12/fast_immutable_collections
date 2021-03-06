import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../utils/config.dart';
import '../../utils/multi_benchmark_reporter.dart';
import '../../utils/collection_benchmark_base.dart';

class ListAddAllBenchmark extends MultiBenchmarkReporter<ListBenchmarkBase> {
  static const List<int> baseList = [1, 2, 3], listToAdd = [4, 5, 6];

  @override
  final String prefixName;
  @override
  final List<Config> configs;
  @override
  final List<ListBenchmarkBase> baseBenchmarks = [
    MutableListAddAllBenchmark(config: null, emitter: null),
    IListAddAllBenchmark(config: null, emitter: null),
    KtListAddAllBenchmark(config: null, emitter: null),
    BuiltListAddAllBenchmark(config: null, emitter: null),
  ];

  ListAddAllBenchmark(
      {this.prefixName = 'list_add_all', @required this.configs});
}

class MutableListAddAllBenchmark extends ListBenchmarkBase {
  MutableListAddAllBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'List (Mutable)', config: config, emitter: emitter);

  @override
  MutableListAddAllBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      MutableListAddAllBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  List<int> _list;
  List<int> _fixedList;

  @override
  List<int> toMutable() => _list;

  @override
  void setup() => _fixedList = List<int>.of(ListAddAllBenchmark.baseList);

  @override
  void run() {
    _list = List<int>.of(_fixedList);
    _list.addAll(ListAddAllBenchmark.listToAdd);
  }
}

class IListAddAllBenchmark extends ListBenchmarkBase {
  IListAddAllBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'IList', config: config, emitter: emitter);

  @override
  IListAddAllBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      IListAddAllBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  IList<int> _iList;
  IList<int> _result;

  @override
  List<int> toMutable() => _result.unlock;

  @override
  void setup() => _iList = IList<int>(ListAddAllBenchmark.baseList);

  @override
  void run() => _result = _iList.addAll(ListAddAllBenchmark.listToAdd);
}

class KtListAddAllBenchmark extends ListBenchmarkBase {
  KtListAddAllBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'KtList', config: config, emitter: emitter);

  @override
  KtListAddAllBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      KtListAddAllBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  KtList<int> _ktList;
  KtList<int> _result;

  @override
  List<int> toMutable() => _result.asList();

  @override
  void setup() => _ktList = KtList<int>.from(ListAddAllBenchmark.baseList);

  /// If the added list were already of type `KtList`, then it would be much
  /// faster.
  @override
  void run() =>
      _result = _ktList.plus(KtList<int>.from(ListAddAllBenchmark.listToAdd));
}

class BuiltListAddAllBenchmark extends ListBenchmarkBase {
  BuiltListAddAllBenchmark(
      {@required Config config, @required ScoreEmitter emitter})
      : super(name: 'BuiltList', config: config, emitter: emitter);

  @override
  BuiltListAddAllBenchmark reconfigure(
          {Config newConfig, ScoreEmitter newEmitter}) =>
      BuiltListAddAllBenchmark(
          config: newConfig ?? config, emitter: newEmitter ?? emitter);

  BuiltList<int> _builtList;
  BuiltList<int> _result;

  @override
  List<int> toMutable() => _result.asList();

  @override
  void setup() => _builtList = BuiltList<int>.of(ListAddAllBenchmark.baseList);

  @override
  void run() => _result = _builtList.rebuild((ListBuilder<int> listBuilder) =>
      listBuilder.addAll(ListAddAllBenchmark.listToAdd));
}

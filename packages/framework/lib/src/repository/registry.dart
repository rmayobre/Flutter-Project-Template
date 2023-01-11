import 'package:flutter/widgets.dart';

import 'repository.dart';
import 'state_listenable.dart';

typedef RepoRegistryBuilder = RepoRegistry Function(BuildContext context);

/// Collection of repositories mapped by a String key. Functions are available to
/// shorten the task of fetching data from the repository.
class RepoRegistry {

  ///
  const RepoRegistry({
    Map<String, FutureRepository<dynamic>> futures = const {},
    Map<String, StreamRepository<dynamic>> streams = const {},
    Map<String, StatefulRepository<dynamic>> states = const {},
  }) : _futures = futures,
        _streams = streams,
        _states = states;

  /// Filters monolithic Map of Repositories into maps per class types.
  factory RepoRegistry.from({required Map<String, Repository> repos}) {
    Map<String, FutureRepository<dynamic>> futures = const {};
    Map<String, StreamRepository<dynamic>> streams = const {};
    Map<String, StatefulRepository<dynamic>> states = const {};
    repos.forEach((key, repo) {
      if (repo is FutureRepository<dynamic>) { futures[key] = repo; }
      if (repo is StreamRepository<dynamic>) { streams[key] = repo; }
      if (repo is StatefulRepository<dynamic>) { states[key] = repo; }
    });
    return RepoRegistry(futures: futures, streams: streams, states: states);
  }

  final Map<String, FutureRepository<dynamic>> _futures;

  final Map<String, StreamRepository<dynamic>> _streams;

  final Map<String, StatefulRepository<dynamic>> _states;

  /// Get [Future] data associated with [key].
  Future<T> fetch<T>(String key) {
    var future = _futures[key];
    if (future is FutureRepository<T>) {
      return future.data;
    }
    throw MissingRepoException.repo(key);
  }

  /// Get [Stream] of data associated with [key].v
  Stream<T> stream<T>(String key) {
    var streamRepo = _streams[key];
    if (streamRepo is StreamRepository<T>) {
      return streamRepo.stream;
    }
    throw MissingRepoException.stream(key);
  }

  /// Get the [StateListenable] associated with [key].
  StateListenable<T> state<T>(String key) {
    var stateRepo = _states[key];
    if (stateRepo is StatefulRepository<T>) {
      return stateRepo.state;
    }
    throw MissingRepoException.state(key);
  }

  Future closeAll() async {
    for (var repo in _futures.values) { repo.close(); }
    for (var repo in _streams.values) { repo.close(); }
    for (var repo in _states.values) { repo.close(); }
  }
}

// class _RepoRegistry {
//
//   ///
//   const RepoRegistry({
//     Map<String, FutureRepository<dynamic>> futures = const {},
//     Map<String, StreamRepository<dynamic>> streams = const {},
//     Map<String, StatefulRepository<dynamic>> states = const {},
//   }) : _futures = futures,
//         _streams = streams,
//         _states = states;
//
//   /// Filters monolithic Map of Repositories into maps per class types.
//   factory RepoRegistry.from({required Map<String, Repository> repos}) {
//     Map<String, FutureRepository<dynamic>> futures = const {};
//     Map<String, StreamRepository<dynamic>> streams = const {};
//     Map<String, StatefulRepository<dynamic>> states = const {};
//     repos.forEach((key, repo) {
//       if (repo is FutureRepository<dynamic>) {
//         futures[key] = repo;
//       }
//       if (repo is StreamRepository<dynamic>) {
//         streams[key] = repo;
//       }
//       if (repo is StatefulRepository<dynamic>) {
//         states[key] = repo;
//       }
//     });
//     return RepoRegistry(futures: futures, streams: streams, states: states);
//   }
//
//   final Map<String, FutureRepository<dynamic>> _futures;
//
//   final Map<String, StreamRepository<dynamic>> _streams;
//
//   final Map<String, StatefulRepository<dynamic>> _states;
//
//   /// Get [Future] data associated with [key].
//   Future<T> fetch<T>(String key) {
//     var future = _futures[key];
//     if (future is FutureRepository<T>) {
//       return future.data;
//     } else {
//       return Future.error(MissingRepoException.repo(key));
//     }
//   }
//
//   /// Get [Stream] of data associated with [key].v
//   Stream<T> stream<T>(String key) {
//     var streamRepo = _streams[key];
//     if (streamRepo is StreamRepository<T>) {
//       return streamRepo.stream;
//     } else {
//       return Stream.error(MissingRepoException.stream(key));
//     }
//   }
//
//   /// Get the [StateListenable] associated with [key].
//   StateListenable<T> state<T>(String key) {
//     var stateRepo = _states[key];
//     if (stateRepo is StatefulRepository<T>) {
//       return stateRepo.state;
//     } else {
//       return StateListenable.error(MissingRepoException.state(key));
//     }
//   }
//
//   Future closeAll() async {
//     for (var repo in _futures.values) { repo.close(); }
//     for (var repo in _streams.values) { repo.close(); }
//     for (var repo in _states.values) { repo.close(); }
//   }
// }

/// An exception thrown by the [RepoRegistry] whenever a repository cannot be found.
class MissingRepoException implements Exception {

  static const String _missingRepo = "Missing Repository";
  static const String _missingStream = "Missing Stream Repository";
  static const String _missingState = "Missing State Repository";

  const MissingRepoException(this.message);

  factory MissingRepoException.repo(String key) {
    return MissingRepoException("$_missingRepo: $key");
  }

  factory MissingRepoException.stream(String key) {
    return MissingRepoException("$_missingStream: $key");
  }

  factory MissingRepoException.state(String key) {
    return MissingRepoException("$_missingState: $key");
  }

  final String message;

  @override
  String toString() => message;
}
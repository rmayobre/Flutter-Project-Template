import 'package:flutter/foundation.dart';

import 'repo_state.dart';

/// Interface for the State of a [Repository].
abstract class StateListenable<T> implements ValueListenable<RepoState<T>> {}
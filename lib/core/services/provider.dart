import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tcp_clone/core/server/server.dart';

final registerProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => Server()),
];
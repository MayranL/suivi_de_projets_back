import 'package:dart_frog/dart_frog.dart';
import 'package:suivi_de_projets_back_data_source/suivi_de_projets_back_data_source.dart';
import 'package:database/database.dart';

final _dataSource = DatabaseUser();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<UserDataSource>((_) => _dataSource));
}
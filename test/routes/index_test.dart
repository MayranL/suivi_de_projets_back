import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:suivi_de_projets_back_data_source/suivi_de_projets_back_data_source.dart';

import '../../routes/user/index.dart' as route;
class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockTodosDataSource extends Mock implements UserDataSource {}

class _MockUri extends Mock implements Uri {}

void main() {
  late RequestContext context;
  late Request request;
  late UserDataSource dataSource;
  late Uri uri;

  const id = 'id';
  final user = User(
    id: id,
    name: 'Test name',
    surname: 'Test surname',
    role: 'test role',
    email: 'test email',
    password: 'test password',
  );

  setUpAll(() => registerFallbackValue(user));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    dataSource = _MockTodosDataSource();
    uri = _MockUri();
    when(() => context.read<UserDataSource>()).thenReturn(dataSource);
    when(() => context.request).thenReturn(request);
    when(() => request.uri).thenReturn(uri);
    when(() => uri.resolve(any())).thenAnswer(
          (_) => Uri.parse('http://localhost/user${_.positionalArguments.first}'),
    );
    when(() => uri.queryParameters).thenReturn({});
  });

  group('responds with a 405', () {
    test('when method is DELETE', () async {
      when(() => request.method).thenReturn(HttpMethod.delete);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is HEAD', () async {
      when(() => request.method).thenReturn(HttpMethod.head);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is OPTIONS', () async {
      when(() => request.method).thenReturn(HttpMethod.options);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PATCH', () async {
      when(() => request.method).thenReturn(HttpMethod.patch);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PUT', () async {
      when(() => request.method).thenReturn(HttpMethod.put);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });

  group('GET /user', () {
    test('responds with a 200 and an empty list', () async {
      when(() => dataSource.readAll()).thenAnswer((_) async => []);
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(isEmpty));

      verify(() => dataSource.readAll()).called(1);
    });

    test('responds with a 200 and a populated list', () async {
      when(() => dataSource.readAll()).thenAnswer((_) async => [user]);
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals([user.toJson()])));

      verify(() => dataSource.readAll()).called(1);
    });
  });

  group('POST /user', () {
    test('responds with a 201 and the newly created user', () async {
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.json()).thenAnswer((_) async {
        return <String, dynamic>{
          'name': 'Test name',
          'surname': 'Test surname',
          'birthdate': DateTime(1990, 1, 1),
          'role': 'test role',
          'email': 'test email',
          'password': 'test password',
        };
      });
      when(() => dataSource.create(any())).thenAnswer((_) async => user);

      final response = await route.onRequest(context);

      expect(response.statusCode, equals(HttpStatus.created));
      expect(response.json(), completion(equals(user.toJson())));

      verify(() => dataSource.create(any())).called(1);
    });
  });
}
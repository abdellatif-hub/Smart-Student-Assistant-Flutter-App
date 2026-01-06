import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/rag_response.dart';

part 'rag_api.g.dart';

// Ajout : définition minimale attendue par rag_api.g.dart
abstract class ParseErrorLogger {
  void logError(Object error, StackTrace? stackTrace, RequestOptions requestOptions);
}

@RestApi(baseUrl: "http://10.0.2.2:8000") // ou ton IP si appareil réel
abstract class RagApi {
  factory RagApi(Dio dio, {String? baseUrl}) = _RagApi;

  @POST("/rag-chat")
  Future<RagResponse> askQuestion(@Body() Map<String, dynamic> body);
}

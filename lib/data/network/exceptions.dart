//Exception that is thrown when http request call response is not 200
class HttpRequestException implements Exception {}

//Exception that is thrown when Entity to Model conversion is performed
class EntityModelMapperException implements Exception {
  final String message;

  EntityModelMapperException({required this.message});
}

class RemoteServerException implements Exception {}

/// Derives Socket.IO origin from API base URL ending with `/api/v1`.
String socketOriginFromApiBaseUrl(String apiBaseUrl) {
  final uri = Uri.parse(apiBaseUrl);
  final path = uri.path.endsWith('/api/v1')
      ? uri.path.substring(0, uri.path.length - '/api/v1'.length)
      : uri.path;
  return uri.replace(path: path.isEmpty ? '' : path).origin;
}

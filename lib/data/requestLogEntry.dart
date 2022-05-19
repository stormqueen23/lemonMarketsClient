
class RequestLogEntry {
  DateTime time;
  String url;

  RequestLogEntry(this.time, this.url);

  @override
  String toString() {
    return 'RequestLogEntry{time: $time, url: $url}';
  }
}
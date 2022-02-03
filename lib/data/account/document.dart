import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/helper/lemonMarketsTimeConverter.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {

  @JsonKey(name: 'id')
  String uuid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(
      name: 'created_at', fromJson: LemonMarketsTimeConverter.fromIsoTime, toJson: LemonMarketsTimeConverter.toIsoTime)
  DateTime createdAt;

  @JsonKey(
      name: 'viewed_first_at', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? firstViewedAt;

  @JsonKey(
      name: 'viewed_last_at', fromJson: LemonMarketsTimeConverter.fromIsoTimeNullable, toJson: LemonMarketsTimeConverter.toIsoTimeNullable)
  DateTime? lastViewedAt;

  Document(this.uuid, this.name, this.category, this.link, this.createdAt, this.firstViewedAt, this.lastViewedAt);

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  String toString() {
    return 'Document{\n'
        'uuid: $uuid,\n'
        'name: $name,\n'
        'category: $category,\n'
        'link: $link,\n'
        'createdAt: $createdAt,\n'
        'firstViewedAt: $firstViewedAt,\n'
        'lastViewedAt: $lastViewedAt'
        '\n}';
  }
}

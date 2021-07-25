import 'package:json_annotation/json_annotation.dart';
import 'package:lemon_markets_client/data/spaceState.dart';

part 'space.g.dart';

@JsonSerializable()
class Space {
  @JsonKey(name: 'uuid')
  String uuid;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'state')
  SpaceState state;

  Space(this.uuid, this.name, this.type, this.state);

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);


}
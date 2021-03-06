import 'package:flutter_conference_app/utils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class Speaker {
  final String id;
  final String name;
  final String bio;
  final String company;
  final String twitter;
  final String github;

  @JsonKey(name: "linked_in")
  final String linkedIn;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  Speaker(this.id, this.name, this.bio, this.imageUrl, this.company, this.twitter, this.linkedIn, this.github);

  AugmentedSpeaker createAugmented() {
    return AugmentedSpeaker(this.id, this.name, this.bio, this.imageUrl, this.company,
      this.twitter, this.linkedIn, this.github);
  }

  factory Speaker.fromJson(Map<String, dynamic> content) => _$SpeakerFromJson(content);
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);
}

@JsonSerializable()
class Track {
  final String id;
  final String name;
  final String color;

  Track(this.id, this.name, this.color);

  factory Track.fromJson(Map<String, dynamic> content) => _$TrackFromJson(content);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable()
class TalkType {
  final String id;
  final String name;

  @JsonKey(name: 'material_icon')
  final String materialIcon;

  final String description;

  TalkType(this.id, this.name, this.materialIcon, this.description);

  factory TalkType.fromJson(Map<String, dynamic> content) => _$TalkTypeFromJson(content);
  Map<String, dynamic> toJson() => _$TalkTypeToJson(this);
}

@JsonSerializable()
class Talk {
  @JsonKey(name: 'speaker_id')
  final String speakerId;

  @JsonKey(name: 'track_id')
  final String trackId;

  @JsonKey(name: 'talk_type_id')
  final String talkTypeId;

  final String title;
  final String description;

  Talk(this.speakerId, this.trackId, this.talkTypeId, this.title, this.description);

  AugmentedTalk createAugmented(tracks, talkTypes, time, talkHash) {
    return AugmentedTalk(title, description, speakerId,
        Utils.findItemById(tracks, trackId), Utils.findItemById(talkTypes, talkTypeId),
        time, talkHash);
  }

  factory Talk.fromJson(Map<String, dynamic> content) => _$TalkFromJson(content);
  Map<String, dynamic> toJson() => _$TalkToJson(this);

  @override
  String toString() {
    return title;
  }
}

@JsonSerializable()
class Schedule {
  final String time;
  final List<Talk> talks;

  Schedule(this.time, this.talks);

  factory Schedule.fromJson(Map<String, dynamic> content) => _$ScheduleFromJson(content);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  String toString() {
    String str = "$time";
    talks.forEach(((f) => str += "\n" + f.toString()));
    return str;
  }
}

class AugmentedTalk {
  final String title;
  final String description;
  final String speakerId;
  final Track track;
  final TalkType talkType;
  final String time;
  final int talkHash;

  AugmentedTalk(this.title, this.description, this.speakerId, this.track,
      this.talkType, this.time, this.talkHash);
}

class AugmentedSpeaker {
  final String id;
  final String name;
  final String bio;
  final String company;
  final String twitter;
  final String github;
  final String linkedIn;
  final String imageUrl;

  AugmentedSpeaker(this.id, this.name, this.bio, this.imageUrl, this.company,
      this.twitter, this.linkedIn, this.github);
}

class TalkBoss {
  final List<AugmentedTalk> talks;
  final AugmentedSpeaker speaker;
  int index = 0;

  AugmentedTalk get currentTalk {
    return talks[index];
  }

  TalkBoss(this.talks, this.speaker, [this.index]);
}


// To parse this JSON data, do
//
//     final wikiModel = wikiModelFromJson(jsonString);

import 'dart:convert';

WikiModel wikiModelFromJson(String str) => WikiModel.fromJson(json.decode(str));

String wikiModelToJson(WikiModel data) => json.encode(data.toJson());

class WikiModel {
    List<Event> events;

    WikiModel({
        required this.events,
    });

    factory WikiModel.fromJson(Map<String, dynamic> json) => WikiModel(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
    };
}

class Event {
    String text;
    List<Page> pages;
    int year;

    Event({
        required this.text,
        required this.pages,
        required this.year,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        text: json["text"],
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
        "year": year,
    };
}

class Page {
    Type type;
    String title;
    String displaytitle;
    Namespace namespace;
    String wikibaseItem;
    Titles titles;
    int pageid;
    Originalimage? thumbnail;
    Originalimage? originalimage;
    Lang lang;
    Dir dir;
    String revision;
    String tid;
    DateTime timestamp;
    String? description;
    DescriptionSource? descriptionSource;
    ContentUrls contentUrls;
    String extract;
    String extractHtml;
    String normalizedtitle;
    Coordinates? coordinates;

    Page({
        required this.type,
        required this.title,
        required this.displaytitle,
        required this.namespace,
        required this.wikibaseItem,
        required this.titles,
        required this.pageid,
        this.thumbnail,
        this.originalimage,
        required this.lang,
        required this.dir,
        required this.revision,
        required this.tid,
        required this.timestamp,
        this.description,
        this.descriptionSource,
        required this.contentUrls,
        required this.extract,
        required this.extractHtml,
        required this.normalizedtitle,
        this.coordinates,
    });

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        type: typeValues.map[json["type"]]!,
        title: json["title"],
        displaytitle: json["displaytitle"],
        namespace: Namespace.fromJson(json["namespace"]),
        wikibaseItem: json["wikibase_item"],
        titles: Titles.fromJson(json["titles"]),
        pageid: json["pageid"],
        thumbnail: json["thumbnail"] == null ? null : Originalimage.fromJson(json["thumbnail"]),
        originalimage: json["originalimage"] == null ? null : Originalimage.fromJson(json["originalimage"]),
        lang: langValues.map[json["lang"]]!,
        dir: dirValues.map[json["dir"]]!,
        revision: json["revision"],
        tid: json["tid"],
        timestamp: DateTime.parse(json["timestamp"]),
        description: json["description"],
        descriptionSource: descriptionSourceValues.map[json["description_source"]],
        contentUrls: ContentUrls.fromJson(json["content_urls"]),
        extract: json["extract"],
        extractHtml: json["extract_html"],
        normalizedtitle: json["normalizedtitle"],
        coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "title": title,
        "displaytitle": displaytitle,
        "namespace": namespace.toJson(),
        "wikibase_item": wikibaseItem,
        "titles": titles.toJson(),
        "pageid": pageid,
        "thumbnail": thumbnail?.toJson(),
        "originalimage": originalimage?.toJson(),
        "lang": langValues.reverse[lang],
        "dir": dirValues.reverse[dir],
        "revision": revision,
        "tid": tid,
        "timestamp": timestamp.toIso8601String(),
        "description": description,
        "description_source": descriptionSourceValues.reverse[descriptionSource],
        "content_urls": contentUrls.toJson(),
        "extract": extract,
        "extract_html": extractHtml,
        "normalizedtitle": normalizedtitle,
        "coordinates": coordinates?.toJson(),
    };
}

class ContentUrls {
    Desktop desktop;
    Desktop mobile;

    ContentUrls({
        required this.desktop,
        required this.mobile,
    });

    factory ContentUrls.fromJson(Map<String, dynamic> json) => ContentUrls(
        desktop: Desktop.fromJson(json["desktop"]),
        mobile: Desktop.fromJson(json["mobile"]),
    );

    Map<String, dynamic> toJson() => {
        "desktop": desktop.toJson(),
        "mobile": mobile.toJson(),
    };
}

class Desktop {
    String page;
    String revisions;
    String edit;
    String talk;

    Desktop({
        required this.page,
        required this.revisions,
        required this.edit,
        required this.talk,
    });

    factory Desktop.fromJson(Map<String, dynamic> json) => Desktop(
        page: json["page"],
        revisions: json["revisions"],
        edit: json["edit"],
        talk: json["talk"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "revisions": revisions,
        "edit": edit,
        "talk": talk,
    };
}

class Coordinates {
    double lat;
    double lon;

    Coordinates({
        required this.lat,
        required this.lon,
    });

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
    };
}

enum DescriptionSource {
    CENTRAL
}

final descriptionSourceValues = EnumValues({
    "central": DescriptionSource.CENTRAL
});

enum Dir {
    LTR
}

final dirValues = EnumValues({
    "ltr": Dir.LTR
});

enum Lang {
    DE
}

final langValues = EnumValues({
    "de": Lang.DE
});

class Namespace {
    int id;
    String text;

    Namespace({
        required this.id,
        required this.text,
    });

    factory Namespace.fromJson(Map<String, dynamic> json) => Namespace(
        id: json["id"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
    };
}

class Originalimage {
    String source;
    int width;
    int height;

    Originalimage({
        required this.source,
        required this.width,
        required this.height,
    });

    factory Originalimage.fromJson(Map<String, dynamic> json) => Originalimage(
        source: json["source"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "source": source,
        "width": width,
        "height": height,
    };
}

class Titles {
    String canonical;
    String normalized;
    String display;

    Titles({
        required this.canonical,
        required this.normalized,
        required this.display,
    });

    factory Titles.fromJson(Map<String, dynamic> json) => Titles(
        canonical: json["canonical"],
        normalized: json["normalized"],
        display: json["display"],
    );

    Map<String, dynamic> toJson() => {
        "canonical": canonical,
        "normalized": normalized,
        "display": display,
    };
}

enum Type {
    STANDARD
}

final typeValues = EnumValues({
    "standard": Type.STANDARD
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

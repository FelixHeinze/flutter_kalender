class CommandsModel {
    final List<Event> events;

    CommandsModel({
        required this.events,
    });

}
/* Model klasse für API von wikipedia bzgl der historischen ereignisse
app.quicktype.io --> json eingefügt und in dart konvertiert
https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/X/Y
wobei X = Monat und Y = Tag



 */
class Event {
    final String text;
    final List<Page> pages;
    final int year;

    Event({
        required this.text,
        required this.pages,
        required this.year,
    });

}

class Page {
    final Type type;
    final String title;
    final String displaytitle;
    final Namespace namespace;
    final String wikibaseItem;
    final Titles titles;
    final int pageid;
    final Originalimage? thumbnail;
    final Originalimage? originalimage;
    final Lang lang;
    final Dir dir;
    final String revision;
    final String tid;
    final DateTime timestamp;
    final String? description;
    final DescriptionSource? descriptionSource;
    final ContentUrls contentUrls;
    final String extract;
    final String extractHtml;
    final String normalizedtitle;
    final Coordinates? coordinates;

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

}

class ContentUrls {
    final Desktop desktop;
    final Desktop mobile;

    ContentUrls({
        required this.desktop,
        required this.mobile,
    });

}

class Desktop {
    final String page;
    final String revisions;
    final String edit;
    final String talk;

    Desktop({
        required this.page,
        required this.revisions,
        required this.edit,
        required this.talk,
    });

}

class Coordinates {
    final double lat;
    final double lon;

    Coordinates({
        required this.lat,
        required this.lon,
    });

}

enum DescriptionSource {
    CENTRAL
}

enum Dir {
    LTR
}

enum Lang {
    DE
}

class Namespace {
    final int id;
    final String text;

    Namespace({
        required this.id,
        required this.text,
    });

}

class Originalimage {
    final String source;
    final int width;
    final int height;

    Originalimage({
        required this.source,
        required this.width,
        required this.height,
    });

}

class Titles {
    final String canonical;
    final String normalized;
    final String display;

    Titles({
        required this.canonical,
        required this.normalized,
        required this.display,
    });

}

enum Type {
    STANDARD
}

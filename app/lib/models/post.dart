// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    this.date,
    this.link,
    this.title,
    this.content,
    this.links,
    this.embedded,
  });

  final int id;
  final DateTime date;
  final String link;
  final Title title;
  final Content content;
  final PostLinks links;
  final Embedded embedded;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        title: Title.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        links: PostLinks.fromJson(json["_links"]),
        embedded: Embedded.fromJson(json["_embedded"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "link": link,
        "title": title.toJson(),
        "content": content.toJson(),
        "_links": links.toJson(),
        "_embedded": embedded.toJson(),
      };
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  final String rendered;
  final bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

class Embedded {
  Embedded({
    this.author,
    this.wpFeaturedmedia,
    this.wpTerm,
  });

  final List<EmbeddedAuthor> author;
  final List<WpFeaturedmedia> wpFeaturedmedia;
  final List<List<EmbeddedWpTerm>> wpTerm;

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        author: List<EmbeddedAuthor>.from(
            json["author"].map((x) => EmbeddedAuthor.fromJson(x))),
        wpFeaturedmedia: List<WpFeaturedmedia>.from(
            json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x))),
        wpTerm: List<List<EmbeddedWpTerm>>.from(json["wp:term"].map((x) =>
            List<EmbeddedWpTerm>.from(
                x.map((x) => EmbeddedWpTerm.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "wp:featuredmedia":
            List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(
            wpTerm.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class EmbeddedAuthor {
  EmbeddedAuthor({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatarUrls,
    this.links,
  });

  final int id;
  final String name;
  final String url;
  final String description;
  final String link;
  final String slug;
  final Map<String, String> avatarUrls;
  final AuthorLinks links;

  factory EmbeddedAuthor.fromJson(Map<String, dynamic> json) => EmbeddedAuthor(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        avatarUrls: Map.from(json["avatar_urls"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        links: AuthorLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "avatar_urls":
            Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links.toJson(),
      };
}

class AuthorLinks {
  AuthorLinks({
    this.self,
    this.collection,
  });

  final List<About> self;
  final List<About> collection;

  factory AuthorLinks.fromJson(Map<String, dynamic> json) => AuthorLinks(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  final String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.id,
    this.date,
    this.slug,
    this.type,
    this.link,
    this.title,
    this.author,
    this.caption,
    this.altText,
    this.mediaType,
    this.mimeType,
    this.mediaDetails,
    this.sourceUrl,
    this.links,
  });

  final int id;
  final DateTime date;
  final String slug;
  final String type;
  final String link;
  final Title title;
  final int author;
  final Title caption;
  final String altText;
  final String mediaType;
  final String mimeType;
  final MediaDetails mediaDetails;
  final String sourceUrl;
  final WpFeaturedmediaLinks links;

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmedia(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        slug: json["slug"],
        type: json["type"],
        link: json["link"],
        title: Title.fromJson(json["title"]),
        author: json["author"],
        caption: Title.fromJson(json["caption"]),
        altText: json["alt_text"],
        mediaType: json["media_type"],
        mimeType: json["mime_type"],
        mediaDetails: MediaDetails.fromJson(json["media_details"]),
        sourceUrl: json["source_url"],
        links: WpFeaturedmediaLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "slug": slug,
        "type": type,
        "link": link,
        "title": title.toJson(),
        "author": author,
        "caption": caption.toJson(),
        "alt_text": altText,
        "media_type": mediaType,
        "mime_type": mimeType,
        "media_details": mediaDetails.toJson(),
        "source_url": sourceUrl,
        "_links": links.toJson(),
      };
}

class Title {
  Title({
    this.rendered,
  });

  final String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}

class WpFeaturedmediaLinks {
  WpFeaturedmediaLinks({
    this.self,
    this.collection,
    this.about,
    this.author,
    this.replies,
  });

  final List<About> self;
  final List<About> collection;
  final List<About> about;
  final List<ReplyElement> author;
  final List<ReplyElement> replies;

  factory WpFeaturedmediaLinks.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmediaLinks(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        author: List<ReplyElement>.from(
            json["author"].map((x) => ReplyElement.fromJson(x))),
        replies: List<ReplyElement>.from(
            json["replies"].map((x) => ReplyElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class ReplyElement {
  ReplyElement({
    this.embeddable,
    this.href,
  });

  final bool embeddable;
  final String href;

  factory ReplyElement.fromJson(Map<String, dynamic> json) => ReplyElement(
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
      };
}

class MediaDetails {
  MediaDetails({
    this.width,
    this.height,
    this.file,
    this.sizes,
    this.imageMeta,
  });

  final int width;
  final int height;
  final String file;
  final Sizes sizes;
  final ImageMeta imageMeta;

  factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
        width: json["width"],
        height: json["height"],
        file: json["file"],
        sizes: Sizes.fromJson(json["sizes"]),
        imageMeta: ImageMeta.fromJson(json["image_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "file": file,
        "sizes": sizes.toJson(),
        "image_meta": imageMeta.toJson(),
      };
}

class ImageMeta {
  ImageMeta({
    this.aperture,
    this.credit,
    this.camera,
    this.caption,
    this.createdTimestamp,
    this.copyright,
    this.focalLength,
    this.iso,
    this.shutterSpeed,
    this.title,
    this.orientation,
    this.keywords,
  });

  final String aperture;
  final String credit;
  final String camera;
  final String caption;
  final String createdTimestamp;
  final String copyright;
  final String focalLength;
  final String iso;
  final String shutterSpeed;
  final String title;
  final String orientation;
  final List<dynamic> keywords;

  factory ImageMeta.fromJson(Map<String, dynamic> json) => ImageMeta(
        aperture: json["aperture"],
        credit: json["credit"],
        camera: json["camera"],
        caption: json["caption"],
        createdTimestamp: json["created_timestamp"],
        copyright: json["copyright"],
        focalLength: json["focal_length"],
        iso: json["iso"],
        shutterSpeed: json["shutter_speed"],
        title: json["title"],
        orientation: json["orientation"],
        keywords: List<dynamic>.from(json["keywords"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "aperture": aperture,
        "credit": credit,
        "camera": camera,
        "caption": caption,
        "created_timestamp": createdTimestamp,
        "copyright": copyright,
        "focal_length": focalLength,
        "iso": iso,
        "shutter_speed": shutterSpeed,
        "title": title,
        "orientation": orientation,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
      };
}

class Sizes {
  Sizes({
    this.medium,
    this.large,
    this.thumbnail,
    this.mediumLarge,
    this.onepressBlogSmall,
    this.onepressSmall,
    this.onepressMedium,
    this.full,
  });

  final Full medium;
  final Full large;
  final Full thumbnail;
  final Full mediumLarge;
  final Full onepressBlogSmall;
  final Full onepressSmall;
  final Full onepressMedium;
  final Full full;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        medium: Full.fromJson(json["medium"]),
        large: Full.fromJson(json["large"]),
        thumbnail: Full.fromJson(json["thumbnail"]),
        mediumLarge: Full.fromJson(json["medium_large"]),
        onepressBlogSmall: Full.fromJson(json["onepress-blog-small"]),
        onepressSmall: Full.fromJson(json["onepress-small"]),
        onepressMedium: Full.fromJson(json["onepress-medium"]),
        full: Full.fromJson(json["full"]),
      );

  Map<String, dynamic> toJson() => {
        "medium": medium.toJson(),
        "large": large.toJson(),
        "thumbnail": thumbnail.toJson(),
        "medium_large": mediumLarge.toJson(),
        "onepress-blog-small": onepressBlogSmall.toJson(),
        "onepress-small": onepressSmall.toJson(),
        "onepress-medium": onepressMedium.toJson(),
        "full": full.toJson(),
      };
}

class Full {
  Full({
    this.file,
    this.width,
    this.height,
    this.mimeType,
    this.sourceUrl,
  });

  final String file;
  final int width;
  final int height;
  final String mimeType;
  final String sourceUrl;

  factory Full.fromJson(Map<String, dynamic> json) => Full(
        file: json["file"],
        width: json["width"],
        height: json["height"],
        mimeType: json["mime_type"],
        sourceUrl: json["source_url"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "width": width,
        "height": height,
        "mime_type": mimeType,
        "source_url": sourceUrl,
      };
}

class EmbeddedWpTerm {
  EmbeddedWpTerm({
    this.id,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.links,
  });

  final int id;
  final String link;
  final String name;
  final String slug;
  final String taxonomy;
  final WpTermLinks links;

  factory EmbeddedWpTerm.fromJson(Map<String, dynamic> json) => EmbeddedWpTerm(
        id: json["id"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
        links: WpTermLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomy,
        "_links": links.toJson(),
      };
}

class WpTermLinks {
  WpTermLinks({
    this.self,
    this.collection,
    this.about,
    this.wpPostType,
    this.curies,
  });

  final List<About> self;
  final List<About> collection;
  final List<About> about;
  final List<About> wpPostType;
  final List<Cury> curies;

  factory WpTermLinks.fromJson(Map<String, dynamic> json) => WpTermLinks(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        wpPostType: List<About>.from(
            json["wp:post_type"].map((x) => About.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "wp:post_type": List<dynamic>.from(wpPostType.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  final String name;
  final String href;
  final bool templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"],
        href: json["href"],
        templated: json["templated"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
      };
}

class PostLinks {
  PostLinks({
    this.self,
    this.collection,
    this.about,
    this.author,
    this.replies,
    this.versionHistory,
    this.predecessorVersion,
    this.wpFeaturedmedia,
    this.wpAttachment,
    this.wpTerm,
    this.curies,
  });

  final List<About> self;
  final List<About> collection;
  final List<About> about;
  final List<ReplyElement> author;
  final List<ReplyElement> replies;
  final List<VersionHistory> versionHistory;
  final List<PredecessorVersion> predecessorVersion;
  final List<ReplyElement> wpFeaturedmedia;
  final List<About> wpAttachment;
  final List<LinksWpTerm> wpTerm;
  final List<Cury> curies;

  factory PostLinks.fromJson(Map<String, dynamic> json) => PostLinks(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        author: List<ReplyElement>.from(
            json["author"].map((x) => ReplyElement.fromJson(x))),
        replies: List<ReplyElement>.from(
            json["replies"].map((x) => ReplyElement.fromJson(x))),
        versionHistory: List<VersionHistory>.from(
            json["version-history"].map((x) => VersionHistory.fromJson(x))),
        predecessorVersion: List<PredecessorVersion>.from(
            json["predecessor-version"]
                .map((x) => PredecessorVersion.fromJson(x))),
        wpFeaturedmedia: List<ReplyElement>.from(
            json["wp:featuredmedia"].map((x) => ReplyElement.fromJson(x))),
        wpAttachment: List<About>.from(
            json["wp:attachment"].map((x) => About.fromJson(x))),
        wpTerm: List<LinksWpTerm>.from(
            json["wp:term"].map((x) => LinksWpTerm.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "version-history":
            List<dynamic>.from(versionHistory.map((x) => x.toJson())),
        "predecessor-version":
            List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
        "wp:featuredmedia":
            List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
        "wp:attachment":
            List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
      };
}

class PredecessorVersion {
  PredecessorVersion({
    this.id,
    this.href,
  });

  final int id;
  final String href;

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) =>
      PredecessorVersion(
        id: json["id"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "href": href,
      };
}

class VersionHistory {
  VersionHistory({
    this.count,
    this.href,
  });

  final int count;
  final String href;

  factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
        count: json["count"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "href": href,
      };
}

class LinksWpTerm {
  LinksWpTerm({
    this.taxonomy,
    this.embeddable,
    this.href,
  });

  final String taxonomy;
  final bool embeddable;
  final String href;

  factory LinksWpTerm.fromJson(Map<String, dynamic> json) => LinksWpTerm(
        taxonomy: json["taxonomy"],
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "taxonomy": taxonomy,
        "embeddable": embeddable,
        "href": href,
      };
}

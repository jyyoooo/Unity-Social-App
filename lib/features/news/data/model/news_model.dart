// ignore_for_file: public_member_api_docs, sort_constructors_first
class News {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? publishedAt;
  final String? author;
  final Map<String, dynamic> source;
  final String url;

  News({
    required this.title,
    required this.description,
    this.author,
    this.urlToImage,
    this.content,
    this.publishedAt,
    this.source = const {},
    this.url = '',
  });
}

// key = 
// GET https://api.worldnewsapi.com/search-news
/*
{
  "offset": 0,
  "number": 10,
  "available": 83,
  "news": [
    {
        "id": 206030983,
        "title": "Nearly 30 aftershocks recorded around NJ quake epicenter since Friday",
        "text": "description goes here",
        "summary": "Twenty nine areas around Whitehouse Station, NJ, which was the epicenter of the quake, have since reported rumbles.",
        "url": "https://nypost.com/2024/04/06/us-news/nearly-30-aftershocks-recorded-around-nj-quake-epicenter/",
        "image": "https://nypost.com/wp-content/uploads/sites/2/2024/04/79582612.jpg?quality=75&strip=all&w=1200",
        "video": "https://cdn.jwplayer.com/videos/70lDQJpg-RyIcpnTz.mp4",
        "publish_date": "2024-04-06 22:44:18",
        "author": "Deirdre Bardolf",
        "authors": [
            "Deirdre Bardolf"
        ],
        "category": "environment",
        "language": "en",
        "source_country": "us",
        "sentiment": -0.545
    }
  ]
}
*/

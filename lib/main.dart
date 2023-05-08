import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Tweet {
  final String tweetedBy;
  final String content;

  Tweet({
    required this.tweetedBy,
    required this.content,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Tweet> _allTweets = [
    Tweet(
        tweetedBy: 'John Doe',
        content:
        'This is a tweet about something very interesting that happened today.'),
    Tweet(
        tweetedBy: 'Jane Smith',
        content:
        'Just saw the most amazing movie ever. You all have to go see it.'),
    Tweet(
        tweetedBy: 'Bob Johnson',
        content:
        'Can\'t believe it\'s already been a year since I started working at my current job.'),
    Tweet(
        tweetedBy: 'Alice Brown',
        content:
        'The weather outside is beautiful today. Perfect day for a walk.'),
    Tweet(
        tweetedBy: 'John Doe',
        content:
        'This is another tweet about something very interesting that happened today.'),
    Tweet(
        tweetedBy: 'Jane Smith',
        content:
        'Just tried a new restaurant and it was delicious. Highly recommend.'),
    Tweet(
        tweetedBy: 'Bob Johnson',
        content:
        'I can\'t stop listening to this new album. It\'s so good.'),
    Tweet(
        tweetedBy: 'Alice Brown',
        content:
        'Just finished reading a great book. I\'m so sad it\'s over.'),
    Tweet(
        tweetedBy: 'John Doe',
        content:
        'This is yet another tweet about something very interesting that happened today.'),
    Tweet(
        tweetedBy: 'Jane Smith',
        content:
        'I love spending lazy Sundays at home with a good movie and some popcorn.'),
    Tweet(
        tweetedBy: 'Bob Johnson',
        content:
        'I can\'t wait to go on vacation next month. It\'s been too long.'),
    Tweet(
        tweetedBy: 'Alice Brown',
        content:
        'I\'m so excited for the new season of my favorite TV show to start.'),
    Tweet(
        tweetedBy: 'Bob Johnson',
        content:
        'I can\'t stop listening to this new album. It\'s so good.'),
  ];
  final List<Tweet> _displayedTweets = [];
  String _sortBy = 'latest';
  String _filterBy = '';

  @override
  void initState() {
    super.initState();
    _displayedTweets.addAll(_allTweets);
  }

  void _loadMoreTweets() {
    setState(() {
      _displayedTweets.addAll(_allTweets);
    });
  }

  void _sortTweets(String sortBy) {
    setState(() {
      _sortBy = sortBy;
      switch (sortBy) {
        case 'latest':
          _displayedTweets.sort((a, b) => b.content.compareTo(a.content));
          break;
        case 'oldest':
          _displayedTweets.sort((a, b) => a.content.compareTo(b.content));
          break;
      }
    });
  }

  void _filterTweets(String filterBy) {
    setState(() {
      _filterBy = filterBy;
      _displayedTweets.clear();
      if (filterBy.isEmpty) {
        _displayedTweets.addAll(_allTweets);
      } else {
        _displayedTweets.addAll(_allTweets
            .where((tweet) =>
        tweet.tweetedBy.toLowerCase().contains(filterBy.toLowerCase()) ||
            tweet.content.toLowerCase().contains(filterBy.toLowerCase()))
            .toList());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Twitter'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search tweets...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => _filterTweets(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _sortBy,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        _sortTweets(newValue!);
                      },
                      items: <String>['latest', 'oldest']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  TextButton(
                    onPressed: _loadMoreTweets,
                    child: Text('Load more'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _displayedTweets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayedTweets[index].tweetedBy,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          _displayedTweets[index].content,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
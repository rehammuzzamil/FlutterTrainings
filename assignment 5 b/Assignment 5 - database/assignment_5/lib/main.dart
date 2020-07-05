import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:assignment5/model/WordPairData.dart';
import 'package:assignment5/database.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class _RandomWordsState extends State<RandomWords> {
  final  List<WordPairData> _suggestions = [];
  final Set<WordPairData> _saved = Set<WordPairData>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  // #enddocregion RWS-var

  final persistentProvider = PersistentWordPairProvider();

  @override
  initState() {
    super.initState();
    persistentProvider.getAll().then((allData) {
      setState(() {

        _saved.addAll(allData.where((data) {
          return data.saved;
        }).toSet());

        _suggestions.addAll(allData);
      });
    });
  }

  // #docregion _buildSuggestions
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _suggestions.length + 1,
        itemBuilder: (context, i) {
          if (i == _suggestions.length) {
            // last item
            _addSuggestions(); // Add more items, while loading.
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return _buildRow(_suggestions[i]);
        });
  }

  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPairData data) {
    final alreadySaved = _saved.contains(data);
    return ListTile(
      title: Text(
        data.pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        if (alreadySaved) {
          _removePair(data);
        } else {
          _savePair(data);
        }
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  // #enddocregion RWS-build

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPairData data) {
              return ListTile(
                title: Text(
                  data.pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, //...to here.
      ),
    );
  }
// #docregion RWS-var

  // DB utility methods
  Future _savePair(WordPairData data) async {
    data.saved = true;
    await persistentProvider.updateSaved(data);
    setState(() {
      _saved.add(data);
    });
  }

  Future _removePair(WordPairData data) async {
    data.saved = false;
    await persistentProvider.updateSaved(data);
    setState(() {
      _saved.remove(data);
    });
  }

  Future _addSuggestions() async {
    final newData = generateWordPairs().take(10);
    print('Generated new data');
    final result = await persistentProvider.batchInsert(
      newData.map(
            (pair) {
          return WordPairData(pair, false);
        },
      ).toList(),
    );
    final newPairData = await persistentProvider.getDataWithIDs(result);
    // Getting data from db again for consistent ordering.
    setState(() {
      _suggestions.addAll(newPairData);
    });
  }
}
// #enddocregion RWS-var


class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}
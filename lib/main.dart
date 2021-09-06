import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


        return MaterialApp(
          title: 'Welcome to Flutter',
          theme: ThemeData(          // Add the 3 lines from here...
            primaryColor: Colors.red,
          ),                         // ... to here.

          home: RandomWords(),
    );


  }


}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{}; // NEW
  final _biggerFont = const TextStyle(fontSize: 18); // NEW


  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random(); // Delete these...
    //return Text(wordPair.asPascalCase); // ... two lines.
    void _pushSaved() {

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          // NEW lines from here...

        builder: (BuildContext context) {
          final tiles = _saved.map(
                  (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                  trailing: Icon(
                    Icons.favorite,
                    color:Colors.red,
                  ),
                  onTap: (){
                    setState(() {
                      _saved.remove(pair);


                    });
                  },
                );
              },
            );
            final divided = tiles.isNotEmpty
                ? ListTile.divideTiles(context: context, tiles: tiles).toList()
                : <Widget>[];

            return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestions'),
              ),

              body: ListView(children: divided),
            );
          }, // ...to here.
        ),
      );
    }
    return Scaffold (                     // Add from here...
      appBar: AppBar(
        title: Text('Startup Name Generator'),

        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),

        ],
      ),

      body: _buildSuggestions(),
    );

    // ... to here.
  }


  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {      // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            Icon( Icons.favorite ,
              color:  Colors.red,);
            _saved.add(pair);
          }
        });
      },               // ... to here.
    );
  }

}




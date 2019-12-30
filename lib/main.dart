import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: Text('Wordy'),
            actions: <Widget>[
              IconButton(icon: new Icon(Icons.more_vert), onPressed: () {})
            ],
          ),
          body: RandomSentences()),
    );
  }
}

class RandomSentences extends StatefulWidget {
  @override
  RandomSentencesState createState() => new RandomSentencesState();
}

class RandomSentencesState extends State<RandomSentences> {
  final _sentences = <String>[];
  final _funnies = new Set<String>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildSentences(),
    );
  }

  String _getSentence() {
    final noun = new WordNoun.random();
    final adjective = new WordAdjective.random();
    return 'The developer wrote a ${adjective.asLowerCase} app in flutter and'
        ' showed it to his ${noun.asLowerCase}';
  }

  Widget _buildRow(String sentence) {
    final alreadyfunny = _funnies.contains(sentence);
    return new ListTile(
      title: new Text(
        sentence,
        style: TextStyle(fontSize: 14.0),
      ),
      trailing: new Icon(
        alreadyfunny ? Icons.thumb_up : Icons.thumb_down,
        color: alreadyfunny ? Colors.green : null,
      ),
      onTap: () {
        setState(() {
          if (alreadyfunny) {
            _funnies.remove(sentence);
          } else {
            _funnies.add(sentence);
          }
        });
      },
    );
  }

  Widget _buildSentences() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
// An ItemBuilder callback is used to add sentences and dividers
// based on when the user scrolls down the view.
      itemBuilder: (context, i) {
// Adds a pixel divider before each row
        if (i.isOdd) return new Divider();
// Divides i by 2 then returns the value into index
// This counts how many sentences are in the ListView
        final index = i ~/ 2;
// Checks to see if we've hit the end of the sentence list
        if (index >= _sentences.length) {
// If we have then we generate another 10
          for (int x = 0; x < 10; x++) {
            _sentences.add(_getSentence());
          }
        }
        return _buildRow(_sentences[index]);
      },
    );
  }
}

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:command_runner/command_runner.dart';

const version = '0.0.1';
void main(List<String> arguments) async {
  var commandRunner = CommandRunner()..addCommand(HelpCommand());
  commandRunner.run(arguments);
}


void searchWikipedia(List<String> arguments) async {
    final String articleTitle;
    if (arguments.isEmpty) {
        print('Please provide an article title :');
        final userInput = stdin.readLineSync();
        if (userInput == null || userInput.isEmpty) {
          print('No inputs existed. Exiting.');
          return;
        }
        articleTitle = userInput;
    }
    else {
        articleTitle = arguments.join(' ');
    }

    print('Searching for articles about "$articleTitle"... please wait.');

    var articleContent = await getWikipediaArticle(articleTitle);
    print(articleContent);    
}

void printUsage() {
      print(
        "The following commands are valid: 'help, 'version', 'search <ARTICLE-TITLE>'"
);
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
      return response.body;
  }
  else {
    return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
  }
}

/* OLD LOGIC FROM MAIN
if (arguments.isEmpty || arguments.first == 'help') {
        printUsage();
    }
    else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
    }
    else if (arguments.first == 'wikipedia') {
        if (arguments.isEmpty == false) {
            searchWikipedia(arguments.sublist(1));
        } 
        else {
            searchWikipedia(arguments);
        }
    }
    else {
        printUsage();
  }
*/
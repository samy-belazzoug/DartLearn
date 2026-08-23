import 'dart:io';

const version = '0.0.1';
void main(List<String> arguments) {
    if (arguments.isEmpty || arguments.first == 'help') {
        printUsage();
    }
    else if (arguments.first == 'version') {
        print('Dartpedia CLI version $version');
    }
    else if (arguments.first == 'search') {
      if (arguments.length > 1) {
          searchWikipedia(arguments.sublist(1));
      } 
      else {
        searchWikipedia(arguments);
      }
        
    }
    else {
        printUsage();
    }
  }

  void printUsage() {
      print(
        "The following commands are valid: 'help, 'version', 'search <ARTICLE-TITLE>'"
      );
}

void searchWikipedia(List<String> arguments) {
    final String articleTitle;
    if (arguments.length <= 1 || arguments.isEmpty) {
        print('ItS null, Please provide an article title :');
        articleTitle = stdin.readLineSync() ?? ' ';
    }
    else {
        print('its not null');
        articleTitle = arguments.join(' ');
    }

    print('Searching for articles about "$articleTitle"... please wait.');
    print("That's it!");
    print("(Pretend this is an article about $articleTitle so I look professionnal..)");
}
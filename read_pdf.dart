import 'dart:io';

void main() async {
  final file = File('Sowlab_API_Documentation.pdf');
  final bytes = await file.readAsBytes();
  final text = String.fromCharCodes(bytes);

  final lines = text.split(RegExp(r'[\\n\\r]+'));
  final Set<String> matches = {};

  for (final line in lines) {
    if (line.toLowerCase().contains('social_id') ||
        line.toLowerCase().contains('social') ||
        line.toLowerCase().contains('register') ||
        line.toLowerCase().contains('business_name')) {
      // PDF might have scattered chars, but we can try printing raw matches
      if (line.length < 200) {
        matches.add(line.trim());
      }
    }
  }

  for (final match in matches.take(20)) {
    print('MATCH: ' + match);
  }
}

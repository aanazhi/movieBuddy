import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MovieApi {
  final String serverUrl;
  final String apiKey;

  MovieApi({required this.serverUrl, required this.apiKey});

  Future<String> uploadImage(File image) async {
    final Uri uploadUri = Uri.parse('$serverUrl/upload');
    final http.MultipartRequest uploadRequest = http.MultipartRequest('POST', uploadUri);

    uploadRequest.headers.addAll({
      'api-key': apiKey,
      'Content-Type': 'multipart/form-data',
    });

    uploadRequest.files.add(await http.MultipartFile.fromPath('file', image.path));
    final http.StreamedResponse uploadResponse = await uploadRequest.send();

    if (uploadResponse.statusCode == 200) {
      final String responseString = await uploadResponse.stream.bytesToString();
      final Map<String, dynamic> responseData = jsonDecode(responseString);
      return responseData['file_url'];
    } else {
      throw Exception('Failed to upload file: ${uploadResponse.statusCode}');
    }
  }

  Future<String> guessMovie(String fileUrl) async {
    final Uri guessMovieUri = Uri.parse('$serverUrl/guess_movie');
    final http.Response guessResponse = await http.post(
      guessMovieUri,
      headers: {
        'api-key': apiKey,
        'content-type': 'application/json',
      },
      body: jsonEncode({'image_url': '$serverUrl$fileUrl'}),
    );

    if (guessResponse.statusCode == 200) {
      final Map<String, dynamic> guessData = jsonDecode(guessResponse.body);
      return guessData['name'];
    } else {
      throw Exception('Failed to guess movie: ${guessResponse.statusCode}');
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:moviebuddy/presentation/widgets/app_bar.dart';

import '../../provider/providers.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieState = ref.watch(movieProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBurCustom(
          title: 'Screen',
        ),
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 10),
            Container(
                color: Color.fromRGBO(207, 220, 253, 1),
                height: 1,
                width: double.infinity),
            Padding(
              padding: EdgeInsets.only(top: 134, left: 22, right: 23),
              child: Text(
                'Пришлите скриншот и получите название фильма через минуту!',
                style: TextStyle(
                  fontFamily: 'Aldrich',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: const Color.fromRGBO(207, 220, 253, 1),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      File imageFile = File(pickedFile.path);
                      await ref
                          .read(movieProvider.notifier)
                          .pickAndUploadImage(imageFile);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(323, 90),
                    backgroundColor: Color.fromRGBO(34, 34, 34, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text(
                          'Открыть галерею',
                          style: TextStyle(
                            fontFamily: 'Aldrich',
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            color: const Color.fromRGBO(207, 220, 253, 1),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 300),
                        child: Image.asset('assets/icons/arrow_2.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: movieState.isLoading
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: 110,
                      ),
                      child: CircularProgressIndicator(),
                    )
                  : movieState.error != null
                      ? Text('Error: ${movieState.error}')
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (movieState.image != null)
                              if (movieState.image != null)
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.file(
                                        movieState.image!,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(34, 34, 34, 1),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(movieProvider.notifier)
                                            .resetState();
                                      },
                                    ),
                                  ],
                                ),
                            if (movieState.title != null)
                              Text(
                                '${movieState.title}',
                                style: TextStyle(
                                  fontFamily: 'Aldrich',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Color.fromRGBO(207, 220, 253, 1),
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

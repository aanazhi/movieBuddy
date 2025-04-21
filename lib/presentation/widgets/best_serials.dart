import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/provider/providers.dart';

class BestSerials extends ConsumerWidget {
  const BestSerials({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serialsData = ref.watch(serialProvider);
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return serialsData.when(
      data: (serials) {
        return SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: serials.length,
              itemBuilder: (context, index) {
                final serial = serials[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: SizedBox(
                      height: 190,
                      width: 130,
                      child: Image.network(
                        serial.poster.url,
                        fit: BoxFit.cover,
                      )),
                );
              },
            ));
      },
      loading: () => Center(
        child: CircularProgressIndicator(
          color: colorsStyle.secondary,
        ),
      ),
      error: (Object error, StackTrace stackTrace) => Center(
        child: Text(
          'Что-то пошло не так',
          style: textStyle.bodyMedium,
        ),
      ),
    );
  }
}

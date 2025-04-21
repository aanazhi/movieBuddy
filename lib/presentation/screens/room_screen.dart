import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/widgets/create_room_dialog.dart';
import 'package:moviebuddy/presentation/widgets/join_room_dialog.dart';
import '../widgets/app_bar.dart';

class RoomScreen extends ConsumerStatefulWidget {
  const RoomScreen({super.key});

  @override
  ConsumerState<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends ConsumerState<RoomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppBurCustom(title: 'Комнаты'),
      backgroundColor: colors.primary,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        _buildCreateRoomButton(colors, textStyle),
                        const SizedBox(height: 30),
                        _buildJoinRoomButton(colors, textStyle),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCreateRoomButton(ColorScheme colors, TextTheme textStyle) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => const CreateRoomDialog(),
      ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colors.outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 20,
              top: 20,
              child: Icon(
                Icons.add_circle_outline,
                size: 40,
                color: colors.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Создать комнату',
                    style: textStyle.headlineSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Начните новый сеанс с друзьями',
                    style: textStyle.bodyMedium?.copyWith(
                      color: colors.onSurface.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinRoomButton(ColorScheme colors, TextTheme textStyle) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => const JoinRoomDialog(),
      ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colors.outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 20,
              top: 20,
              child: Icon(
                Icons.group_add,
                size: 40,
                color: colors.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Присоединиться',
                    style: textStyle.headlineSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Войдите в существующую комнату',
                    style: textStyle.bodyMedium?.copyWith(
                      color: colors.onSurface.withOpacity(0.8),
                    ),
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

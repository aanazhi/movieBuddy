class SwipeState {
  final String roomCode;
  final String movieId;
  final bool isLiked;

  SwipeState({
    required this.roomCode,
    required this.movieId,
    this.isLiked = false,
  });

  SwipeState copyWith({
    String? roomCode,
    String? movieId,
    bool? isLiked,
  }) =>
      SwipeState(
          roomCode: roomCode ?? this.roomCode,
          movieId: movieId ?? this.movieId,
          isLiked: isLiked ?? this.isLiked);
}

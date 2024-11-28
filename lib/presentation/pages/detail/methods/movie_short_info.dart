import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie_detail/movie_detail.dart';
import '../../../misc/methods.dart';

List<Widget> movieShortInfo({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required BuildContext context,
}) =>
    [
      Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/duration.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width: 95,
            child: Text(
              '${asyncMovieDetail.when(
                data: (movieDetail) =>
                    movieDetail != null ? movieDetail.runtime : '-',
                error: (error, stackTrace) => '-',
                loading: () => '-',
              )} minutes',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/genre.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 48 - 95 - 14 - 14 - 5 - 5,
            child: asyncMovieDetail.when(
              data: (movieDetail) {
                String genres = movieDetail?.genres.join(',') ?? '-';
                return Text(
                  genres,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                );
              },
              error: (error, stackTrace) =>
                  const Text('-', style: TextStyle(fontSize: 12)),
              loading: () => const Text('-', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
      verticalSpace(18),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: Image.asset('assets/star.png'),
          ),
          horizontalSpace(5),
          Text(
            (asyncMovieDetail.valueOrNull?.voteAverage ?? 0).toStringAsFixed(1),
          ),
        ],
      ),
    ];

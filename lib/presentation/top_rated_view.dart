import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:fl_wework_movies/presentation/widgets/text.dart';
import 'package:fl_wework_movies/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopRatedView extends StatelessWidget {
  final MovieListModel movie;

  const TopRatedView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shadowColor: Colors.grey.withOpacity(0.2),
        elevation: 12,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: "${ApiEndpoints.tmdbPosterPath}${movie.posterPath}",
                    child: SizedBox(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, progress) => const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                            imageUrl:
                                "${ApiEndpoints.tmdbPosterPath}${movie.posterPath}",
                          ),
                        )),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 8,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          color: const Color(0xFF3b3c4b)),
                      child: Column(
                        children: [
                          const Icon(Icons.remove_red_eye_outlined,
                              color: Color(0xFF9a8493), size: 16.0),
                          CommonText(
                              title: movie.popularity?.toStringAsFixed(0) ?? "",
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        title: movie.title ?? "",
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: Colors.grey, size: 20.0),
                        const SizedBox(width: 4.0),
                        Flexible(
                          child: CommonText(
                              maxLines: 2,
                              title: movie.overview ?? "",
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      CommonText(
                          title: "${movie.voteCount} Votes",
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                      const SizedBox(width: 4.0),
                      const CommonText(
                          title: "|",
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      const SizedBox(width: 4.0),
                      CommonText(
                          title: movie.voteAverage?.toStringAsFixed(1) ?? "",
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0)
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

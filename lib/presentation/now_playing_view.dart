import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:fl_wework_movies/presentation/widgets/custom_card_clipper.dart';
import 'package:fl_wework_movies/presentation/widgets/text.dart';
import 'package:fl_wework_movies/utils/api_endpoints.dart';
import 'package:fl_wework_movies/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NowPlayingView extends StatelessWidget {
  final NowPlaying movie;
  final double scaleFactor;

  const NowPlayingView(
      {super.key, required this.movie, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: scaleFactor / 6,
          left: scaleFactor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                  title: movie.voteAverage?.toStringAsFixed(1) ?? "",
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
              const SizedBox(width: 4.0),
              const Icon(Icons.star_rounded,color: Colors.yellow)
            ],
          ),
        ),
        ClipPath(
            clipper: CustomCardClipper(scaleFactor: scaleFactor, height: 160),
            child: InkWell(
              onTap: () {},
              child: Card(
                shadowColor: Colors.grey.withOpacity(0.2),
                elevation: 12,
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                            height: scaleFactor * 6.0,
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0)),
                                child: ClipRect(
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          alignment: Alignment.center,
                                          height: 24.0,
                                          width: scaleFactor * 2.5,
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                  Icons.add_location_outlined,
                                                  color: Colors.white70,
                                                  size: 16.0),
                                              const SizedBox(width: 4.0),
                                              CommonText(
                                                  title: getLanguageText(
                                                      movie.originalLanguage ??
                                                          ""),
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12.0),
                                            ],
                                          ),
                                        )))),
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0)),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      height: scaleFactor * 2.0,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                              title: movie.title,
                                              color: Colors.white,
                                              fontSize: 12.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.grey,
                                                  size: 16.0),
                                              const SizedBox(width: 4.0),
                                              Flexible(
                                                child: CommonText(
                                                    title: "${movie.overview}",
                                                    color: Colors.white70,
                                                    fontSize: 10.0,
                                                    maxLines: 2),
                                              ),
                                            ],
                                          ),
                                          CommonText(
                                              title: "${DataUtils.formatVotes(movie.voteCount)} Votes",
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Positioned(
                          right: 16,
                          top: 8,
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: const Color(0xFF3b3c4b)
                                        .withOpacity(0.5)),
                                child: Row(
                                  children: [
                                    const Icon(Icons.remove_red_eye_outlined,
                                        color: Colors.white, size: 16.0),
                                    const SizedBox(width: 4.0),
                                    CommonText(
                                        title: movie.popularity
                                                ?.toStringAsFixed(0) ??
                                            "",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0)
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: const Color(0xFF3b3c4b)
                                          .withOpacity(0.5)),
                                  child: Icon(MdiIcons.heartOutline,
                                      color: Colors.white, size: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  String getLanguageText(String langCode) {
    switch (langCode) {
      case "en":
        return "English";
      case "fr":
        return "French";
      default:
        return langCode;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:int_jumat/bloc/detail/cubit/detail_cubit.dart';
import 'package:int_jumat/core/app_color.dart';
import 'package:int_jumat/core/app_text_style.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.movieId}) : super(key: key);
  final int movieId;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailCubit>(context).getDetail(widget.movieId);
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CircleAvatar(
              maxRadius: 1,
              backgroundColor: AppColor.black,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left_rounded)),
            )),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .30,
              child: BlocBuilder<DetailCubit, DetailState>(
                builder: (context, state) {
                  if (state is DetailLoading) {
                    return shimmer(double.infinity, double.infinity);
                  }
                  if (state is DetailSuccess) {
                    return Image.network(
                      "https://image.tmdb.org/t/p/w500/${state.detailModel.backdropPath}",
                      fit: BoxFit.cover,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: DraggableScrollableSheet(
                    initialChildSize: .3,
                    minChildSize: .3,
                    maxChildSize: .6,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: const BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            controller: scrollController,
                            children: [
                              BlocBuilder<DetailCubit, DetailState>(
                                builder: (context, state) {
                                  if (state is DetailLoading) {
                                    return shimmer(double.infinity, 45);
                                  }
                                  if (state is DetailSuccess) {
                                    return Text(
                                      state.detailModel.title,
                                      style: AppTextStyle.body34White,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          color: AppColor.black,
                                        ),
                                        Text(
                                          "Wishlish",
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: .3),
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColor.yellowBtn),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  BlocBuilder<DetailCubit, DetailState>(
                                    builder: (context, state) {
                                      if (state is DetailLoading) {
                                        return shimmer(70, 20);
                                      }
                                      if (state is DetailSuccess) {
                                        return Row(
                                          children: [
                                            Text(
                                                state
                                                    .detailModel.genres[0].name,
                                                style:
                                                    AppTextStyle.body16White),
                                            state.detailModel.genres.length > 1
                                                ? Text(
                                                    ", " +
                                                        state.detailModel
                                                            .genres[1].name,
                                                    style: AppTextStyle
                                                        .body16White)
                                                : const Text("",
                                                    style: AppTextStyle
                                                        .body16White),
                                            state.detailModel.genres.length > 2
                                                ? Text(
                                                    ", " +
                                                        state.detailModel
                                                            .genres[2].name,
                                                    style: AppTextStyle
                                                        .body16White)
                                                : const Text("",
                                                    style: AppTextStyle
                                                        .body16White),
                                          ],
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  BlocBuilder<DetailCubit, DetailState>(
                                    builder: (context, state) {
                                      if (state is DetailLoading) {
                                        return shimmer(120, 30);
                                      }
                                      if (state is DetailSuccess) {
                                        return Text(
                                            durationToString(
                                                state.detailModel.runtime),
                                            style: AppTextStyle.body16White);
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  BlocBuilder<DetailCubit, DetailState>(
                                    builder: (context, state) {
                                      if (state is DetailLoading) {
                                        return shimmer(200, 50);
                                      }
                                      if (state is DetailSuccess) {
                                        return Row(
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 30,
                                              initialRating: state
                                                      .detailModel.voteAverage /
                                                  2,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              unratedColor: Colors.white,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                state.detailModel.voteAverage
                                                    .toStringAsFixed(2),
                                                style: AppTextStyle.body16White)
                                          ],
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Overview",
                                  style: AppTextStyle.body24White),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<DetailCubit, DetailState>(
                                builder: (context, state) {
                                  if (state is DetailLoading) {
                                    return shimmer(double.infinity, 100);
                                  }
                                  if (state is DetailSuccess) {
                                    return Text(state.detailModel.overview,
                                        style: AppTextStyle.body16White);
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                          ));
                    })),
          ],
        ));
  }

  Widget shimmer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

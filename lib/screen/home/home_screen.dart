import 'package:flutter/material.dart';
import 'package:int_jumat/bloc/now_playing/cubit/now_playing_cubit.dart';
import 'package:int_jumat/bloc/populer/cubit/populer_cubit.dart';
import 'package:int_jumat/bloc/top_rated/cubit/top_rated_cubit.dart';
import 'package:int_jumat/core/app_color.dart';
import 'package:int_jumat/core/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int_jumat/screen/detail_screen/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NowPlayingCubit>(context).getNowPlaying();
    BlocProvider.of<PopulerCubit>(context).getPopuler();
    BlocProvider.of<TopRatedCubit>(context).getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            size: 30,
          ),
        ),
        title: const Text("Ditonton", style: AppTextStyle.body22),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: AppColor.black,
        child: ListView(
          children: <Widget>[
            labelText("Now Playing"),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 165,
                child: BlocBuilder<NowPlayingCubit, NowPlayingState>(
                  builder: (context, state) {
                    if (state is NowPlayingLoading) {
                      return ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          return cardImageShimmer();
                        },
                      );
                    }
                    if (state is NowPlayingSuccess) {
                      return ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          return cardImage(state.result[index].posterPath,
                              state.result[index].id);
                        },
                      );
                    }
                    return Container();
                  },
                )),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  labelText("Popular"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "See more",
                      style: TextStyle(color: AppColor.yellow),
                    ),
                  )
                ]),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: 165,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return BlocBuilder<PopulerCubit, PopulerState>(
                        builder: (context, state) {
                      if (state is PopulerLoading) {
                        return cardImageShimmer();
                      }
                      if (state is PopulerSuccess) {
                        return cardImage(state.result[index].posterPath,
                            state.result[index].id);
                      }
                      return Container();
                    });
                  }),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  labelText("Top Rated"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "See more",
                      style: TextStyle(color: AppColor.yellow),
                    ),
                  )
                ]),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: 165,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return BlocBuilder<TopRatedCubit, TopRatedState>(
                        builder: (context, state) {
                      if (state is TopRatedLoading) {
                        return cardImageShimmer();
                      }
                      if (state is TopRatedSuccess) {
                        return cardImage(state.result[index].posterPath!,
                            state.result[index].id);
                      }
                      return Container();
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: AppTextStyle.body18White,
      ),
    );
  }

  Widget cardImage(String imageLink, int movieId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(movieId: movieId),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 110,
        height: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: (imageLink.isEmpty)
                    ? const NetworkImage(
                        "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg",
                      )
                    : NetworkImage(
                        "https://image.tmdb.org/t/p/w500/$imageLink",
                      ),
                fit: BoxFit.cover),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget cardImageShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 110,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

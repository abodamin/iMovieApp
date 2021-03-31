import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/App/colors.dart';
import 'package:i_movie_app/UI/Widgets/Responsive.dart';
import 'package:i_movie_app/UI/Widgets/Utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  var _list = [1, 2, 3, 4, 5];
  TabController _tabController;
  final int tabs = 2;

  @override
  void initState() {
    _tabController = new TabController(
      length: tabs,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iMovieApp"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: getMediaWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Trending Movies Image.
              Container(
                height: get200Size(context) + get50Size(context),
                width: getMediaWidth(context),
                child: Carousel(
                  dotSize: 6.0,
                  boxFit: BoxFit.fill,
                  autoplay: false,
                  // dotColor: Colors.yellow,
                  dotIncreasedColor: Colors.yellow,
                  dotBgColor: Colors.purple.withOpacity(0.0),
                  images: [
                    for (var item in _list)
                      GestureDetector(
                        onTap: () {},
                        child: MoviePosterImage(item),
                      )
                  ],
                ),
              ),
              //TabBars
              mHeight(get30Size(context)),
              TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: primeryColor,
                indicatorColor: primeryColor,
                tabs: List.generate(
                  tabs,
                  (index) {
                    return Tab(
                      child: Text("Tab${index + 1}"),
                    );
                  },
                ).toList(),
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Container(
                height: get200Size(context) + get100Size(context),
                child: TabBarView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Movies
                        Container(
                          height: get200Size(context) + get100Size(context),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                // margin: const EdgeInsets.all(8),
                                height: get100Size(context),
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        height: get200Size(context),
                                        // width: ,
                                        child: Image.network(
                                          "https://picsum.photos/150/200?random=$index",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Movie Name",
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        // width: get120Size(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("1"),
                                            Container(
                                              child: RatingBar.builder(
                                                initialRating: 3,
                                                itemSize: 15,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(horizontal: 0.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // ----SECOND TAB------ //
                    // ----SECOND TAB------ //
                    // ----SECOND TAB------ //
                    Text('Person'),
                  ],
                  controller: _tabController,
                ),
              ),

              // --- Authors --- //
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Trending Persons This Week"),
              ),
              Container(
                height: get160Size(context),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    trendingMovie(),
                    trendingMovie(),
                  ],
                ),
              ),
              mHeight(get30Size(context)),
              // ---- Top Rated Movies ---- //
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Trending Movies This Week"),
              ),
              Container(
                height: get160Size(context),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    trendingMovie(),
                    trendingMovie(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trendingMovie() {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: containerColorRadiusBorder(
              Colors.transparent,
              300,
              Colors.transparent,
            ),
            width: get80Size(context),
            height: get80Size(context),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              "https://picsum.photos/800/500?random=1",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ActorName",
              style: getTextTheme(context).button,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Trending for Acting",
              style: getTextTheme(context).caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget MoviePosterImage(item) {
    return Container(
      height: get200Size(context) + get50Size(context),
      width: getMediaWidth(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GredientImage(
            imageName: item.toString(),
          ),
          // Image.network(
          //   "https://picsum.photos/800/500?random=$item",
          //   fit: BoxFit.fitWidth,
          //   width: getMediaWidth(context),
          // ),
          Image.asset(
            getImageAsset("ic_play2.png"),
            height: 50,
          ),
        ],
      ),
    );
  }
}

class GredientImage extends StatelessWidget {
  final String imageName;

  const GredientImage({
    Key key,
    @required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "https://picsum.photos/800/500?random=$imageName",
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF2A1C40),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
class TopSide extends StatefulWidget {
  const TopSide({super.key});

  @override
  State<TopSide> createState() => Topside();
}
class Topside extends State<TopSide> {
  List<Photos> items = List.of(PhotoData.photos);

  @override
  Widget build(BuildContext context) {
    double height = 500;
    double width = MediaQuery.of(context).size.width;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 1,
              // height: height*0.004,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_outlined, color: Colors.white,size: 35.0),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.settings, color: Colors.white,size: 30.0),
                      onPressed: () {}),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150, top: 20, bottom: 20, left: 10),
            child: Text("Sizin için hazırladığımız rotaları keşfedin.",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
            horizontal: 12,
            ),
            child: SizedBox(
              height: height*0.50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: 3,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final number = items[index];
                  return getphotos(number);
                },
              ),
            ),
          )
        ]);
  }

  Widget getphotos(Photos number) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:3               ),
              child: Container(
                width: width*0.4,
                height: height*0.28,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(number.imgUrl),
                    fit: BoxFit.cover,
                      ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(number.routeName, style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold ),),
                      Text(number.points, style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold ),),
                    ],
                  ),
                )
              ),
            ),
          ],
        )
    );
  }
}
class Photos{
  final String imgUrl;
  final String routeName;
  final String points;

  const Photos(
      {
        required this.imgUrl,
        required this.routeName,
        required this.points,
      }
      );
}
class PhotoData {
  static const photos = <Photos>[
    Photos(
        imgUrl: 'https://media.istockphoto.com/photos/long-exposure-nature-landscape-sea-photo-cesme-ozmir-turkey-picture-id1180686282?s=612x612',
        routeName: 'Mavi Gezi Rotası',
        points: '14 gezi noktası'
    ),
    Photos(
        imgUrl: 'https://media.tacdn.com/media/attractions-splice-spp-674x446/06/75/b5/d9.jpg',
        routeName: 'Yeşil Gezi rotası',
        points: '7 gezi noktası '
    ),
    Photos(
        imgUrl: 'https://i1.wp.com/bakikaracay.com/wp-content/uploads/2019/11/Sonbahar-Antalya-Duden-Selalesi.jpg?resize=810%2C535&ssl=1',
        routeName: 'Sarı Gezi Rotası',
        points: '11 gezi noktası'
    ),
  ];
}
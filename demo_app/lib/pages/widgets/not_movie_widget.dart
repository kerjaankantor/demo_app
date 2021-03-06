import 'package:demo_app/pages/movie_detail/movie_detail_page.dart';
import 'package:flutter/material.dart';

class NotMovieWidget extends StatelessWidget {
  final String notMovieTitle;
  final String notMovieYear;
  final String notMoviePosterUrl;
  final String id;

  NotMovieWidget(
      {@required this.notMovieTitle,
      @required this.notMovieYear,
      @required this.id,
      this.notMoviePosterUrl});

  final upperContentCornerRadius = Radius.circular(8);

  @override
  Widget build(BuildContext context) {
    final bool isPosterNull = notMoviePosterUrl == null ? true : false;
    final Widget posterWidget =
        isPosterNull ? _posterPlaceholder() : _posterImage();

    return _materialStyleWidget(context, id,posterWidget: posterWidget);
  }

  Widget _softUIStyleWidget(BuildContext context, {Widget posterWidget}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[500],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: Column(children: <Widget>[
          Expanded(flex: 3, child: posterWidget),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    notMovieTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notMovieYear.toString(),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _materialStyleWidget(BuildContext context, String id,
      {@required Widget posterWidget}) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(SystemConstants.MOVIE_DETAIL, arguments: <String, String>{'id':id});
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailPage(id)));
      },
      child: Card( 
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: upperContentCornerRadius,
                topRight: upperContentCornerRadius),
            child: Column(children: <Widget>[
              Expanded(flex: 3, child: posterWidget),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        notMovieTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.title,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notMovieYear.toString(),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );

    // Card(
    //   child: Container(
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.only(
    //           topLeft: upperContentCornerRadius,
    //           topRight: upperContentCornerRadius),
    //       child: Column(children: <Widget>[
    //         Expanded(flex: 3, child: posterWidget),
    //         Expanded(
    //           flex: 1,
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: <Widget>[
    //                 Text(
    //                   notMovieTitle,
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: Theme.of(context).textTheme.title,
    //                 ),
    //                 const SizedBox(height: 8),
    //                 Text(
    //                   notMovieYear.toString(),
    //                   textAlign: TextAlign.start,
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ]),
    //     ),
    //   ),
    // );
  }

  Widget _posterPlaceholder() {
    return Icon(Icons.image, size: 10, color: Colors.grey);
  }

  Widget _posterImage() {
    return Image.network(notMoviePosterUrl, fit: BoxFit.cover);
  }
}

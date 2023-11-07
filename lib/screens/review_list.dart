import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/presenter/review_list_presenter.dart';

class ReviewsListView {
  void refreshReviewListView(
      List<ReviewModel> reviewsList) {}

  void refreshRaiting(String raiting) {}
}

class ReviewList extends StatefulWidget {
  const ReviewList(
      {super.key, required this.houseId});

  
  final String houseId;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> implements ReviewsListView{

  late ReviewListPresenter reviewListPresenter;

  String? _raiting = '0';

  final TextEditingController _commentController = TextEditingController();

  List<ReviewModel>? _reviewsList;

  @override
  void refreshReviewListView(
      List<ReviewModel> reviewsList) {
    setState(() {
      _reviewsList = reviewsList;
    });
  }

  @override
  void refreshRaiting(String raiting) {
    setState(() {
      _raiting = raiting;
    });
  }

  @override
  void initState() {
    super.initState();
    reviewListPresenter = ReviewListPresenter(widget.houseId);
    reviewListPresenter.backView = this;
    reviewListPresenter.putReview(widget.houseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Rating: $_raiting'),
          ),
          Expanded(
            child: _reviewsList == null
                ? const Center(child: CircularProgressIndicator())
                : _reviewsList!.isEmpty
                    ? const Center(child: Text('No comments'))
                    : ListView.builder(
                        itemCount: _reviewsList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: Text(index.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Raiting: ${_reviewsList![index].rating}'),
                                  Text('Comment: ${_reviewsList![index].comment}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

}
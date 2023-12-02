import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/presenter/review_list_presenter.dart';

class ReviewsListView {
  void refreshReviewListView(List<ReviewModel> reviewsList) {}

  void refreshRaiting(String raiting) {}

  void refreshNumber(int number) {}
}

class ReviewList extends StatefulWidget {
  const ReviewList({
    Key? key,
    required this.houseId,
    required this.userId,
  }) : super(key: key);

  final String houseId;
  final String userId;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> implements ReviewsListView {
  late ReviewListPresenter reviewListPresenter;

  String? _raiting = '0';
  String? _manualRating = '0';
  int _number = 0;

  final TextEditingController _commentController = TextEditingController();

  List<ReviewModel>? _reviewsList;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void refreshReviewListView(List<ReviewModel> reviewsList) {
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
  void refreshNumber(int number) {
    setState(() {
      _number = number;
    });
  }

  @override
  void initState() {
    super.initState();
    reviewListPresenter = ReviewListPresenter(widget.houseId);
    reviewListPresenter.backView = this;
    reviewListPresenter.putReview(widget.houseId);
  }

  void _submitReview() {
    if (_formKey.currentState?.validate() ?? false) {
      double rating = double.parse(_manualRating!);
      String comment = _commentController.text;
      reviewListPresenter.postReview(
          widget.houseId, widget.userId, comment, rating);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          'Reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Rating: $_raiting'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Rating (0-5)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}$')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a rating';
                        }
                        double rating = double.tryParse(value) ?? -1;
                        if (rating < 0 || rating > 5) {
                          return 'Please enter a valid rating between 0 and 5';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _manualRating = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Comment (max 2000 characters)',
                      ),
                      controller: _commentController,
                      maxLines: 5,
                      maxLength: 2000,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a comment';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitReview,
                      child: const Text('Submit Review'),
                    )
                  ],
                ),
              ),
            ),
            _reviewsList == null
                ? const Center(child: CircularProgressIndicator())
                : _reviewsList!.isEmpty
                    ? const Center(child: Text('No comments'))
                    : ListView.builder(
                        shrinkWrap: true, // Use shrinkWrap to avoid the error
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _reviewsList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: Text(index.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Rating: ${_reviewsList![index].rating}'),
                                      
                                  Text(
                                      'Comment: ${_reviewsList![index].comment}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: SizedBox(
                            width: screenSize.width,
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _number,
                              itemBuilder: (BuildContext context, int index) {
                                // Agrega un GestureDetector para permitir clics en cada elemento
                                return GestureDetector(
                                  onTap: () {
                                    reviewListPresenter.getAllReviews(widget.houseId, skip: index * 5, limit: 5);
                                  },
                                  child: Container(
                                    width: 50, // Ajusta el ancho del contenedor según tus necesidades
                                    margin: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue, // Color del borde del contenedor
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(), // Números del 1 al _number
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ),
                      const SizedBox(height: 75),
          ],
        ),
      ),
    );
  }
}
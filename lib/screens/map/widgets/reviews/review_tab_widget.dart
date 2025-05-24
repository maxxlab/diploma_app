// lib/screens/map/widgets/reviews/reviews_tab_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/extensions/context_extension.dart';
import 'package:tourist_app/models/review.dart';
import 'package:tourist_app/screens/map/widgets/reviews/bloc/reviews_bloc.dart';
import 'package:tourist_app/screens/map/widgets/reviews/review_form_widget.dart';
import 'package:tourist_app/screens/map/widgets/reviews/review_item_widget.dart';
import 'package:tourist_app/widgets/error_view.dart';
import 'package:tourist_app/widgets/laoding_view.dart';

class ReviewsTab extends StatefulWidget {
  final String poiId;

  const ReviewsTab({
    Key? key,
    required this.poiId,
  }) : super(key: key);

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  final ScrollController _scrollController = ScrollController();
  bool _showForm = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ReviewsBloc>().add(LoadMoreReviews(poiId: widget.poiId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsBloc, ReviewsState>(
      listener: (context, state) {
        if (state is ReviewsLoaded && state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ReviewsLoading) {
          return const LoadingView(message: 'Loading reviews...');
        }

        if (state is ReviewsError) {
          return ErrorView(
            message: state.message,
            onRetry: () => context.read<ReviewsBloc>().add(LoadReviews(poiId: widget.poiId)),
          );
        }

        if (state is ReviewsLoaded) {
          return Column(
            children: [
              Expanded(
                child: state.reviews.isEmpty
                    ? _buildEmptyState()
                    : _buildReviewsList(state),
              ),
              if (state.reviews.isNotEmpty) ...[
                if (_showForm)
                  ReviewFormWidget(
                    poiId: widget.poiId,
                    onSubmitted: () {
                      setState(() {
                        _showForm = false;
                      });
                    },
                  )
                else
                  _buildAddReviewButton(),
              ],
            ],
          );
        }

        return _buildEmptyState();
      },
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Reviews Yet',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Be the first to share your experience!',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showForm)
          ReviewFormWidget(
            poiId: widget.poiId,
            onSubmitted: () {
              setState(() {
                _showForm = false;
              });
            },
          )
        else
          _buildAddReviewButton(),
      ],
    );
  }

  Widget _buildReviewsList(ReviewsLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ReviewsBloc>().add(RefreshReviews(poiId: widget.poiId));
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: state.reviews.length + (state.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= state.reviews.length) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: state.isLoadingMore
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            );
          }

          final review = state.reviews[index];
          return ReviewItemWidget(
            review: review,
            onEdit: () => _editReview(review),
            onDelete: () => _deleteReview(review),
          );
        },
      ),
    );
  }

  Widget _buildAddReviewButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _showForm = true;
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Write a Review'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  void _editReview(Review review) {
    final reviewsBloc = context.read<ReviewsBloc>();

    showDialog(
      context: context,
      builder: (context) => EditReviewDialog(
        review: review,
        onSave: (updatedReview) {
          reviewsBloc.add(UpdateReview(review: updatedReview));
        },
      ),
    );
  }

  void _deleteReview(Review review) {
    final reviewsBloc = context.read<ReviewsBloc>();
    reviewsBloc.add(
      DeleteReview(poiId: review.poiId, reviewId: review.id),
    );
  }
}

class EditReviewDialog extends StatefulWidget {
  final Review review;
  final Function(Review) onSave;

  const EditReviewDialog({
    Key? key,
    required this.review,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditReviewDialog> createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<EditReviewDialog> {
  late TextEditingController _commentController;
  late double _rating;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.review.comment ?? '');
    _rating = widget.review.rating;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Rating: '),
              Expanded(
                child: Slider(
                  value: _rating,
                  min: 1.0,
                  max: 5.0,
                  divisions: 4,
                  label: _rating.toStringAsFixed(0),
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _rating.toStringAsFixed(0),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Update your comment...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedReview = widget.review.copyWith(
              rating: _rating,
              comment: _commentController.text.trim(),
            );
            Navigator.of(context).pop();
            widget.onSave(updatedReview);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
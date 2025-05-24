// lib/screens/map/widgets/poi_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/screens/map/widgets/events/events_tab_widget.dart';
import 'package:tourist_app/screens/map/widgets/events/poi_details_tab.dart';
import 'package:tourist_app/screens/map/widgets/reviews/review_tab_widget.dart';
import '../../../models/poi.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../services/injector/injector.dart';
import 'events/bloc/events_bloc.dart';
import 'reviews/bloc/reviews_bloc.dart';

class POIDetailsSheet extends StatelessWidget {
  final POI poi;

  const POIDetailsSheet({
    Key? key,
    required this.poi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EventsBloc>()..add(LoadEvents(poiId: poi.id)),
        ),
        BlocProvider(
          create: (context) => getIt<ReviewsBloc>()..add(LoadReviews(poiId: poi.id)),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  labelColor: _getCategoryColor(poi.category),
                  unselectedLabelColor: Colors.grey.shade600,
                  indicatorColor: _getCategoryColor(poi.category),
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.info_outline),
                      text: 'Details',
                    ),
                    Tab(
                      icon: Icon(Icons.event),
                      text: 'Events',
                    ),
                    Tab(
                      icon: Icon(Icons.rate_review),
                      text: 'Reviews',
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    POIDetailsTab(poi: poi),
                    EventsTab(poiId: poi.id),
                    ReviewsTab(poiId: poi.id),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getCategoryColor(poi.category),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'CLOSE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return const Color(0xFF964B00);
      case 'museum':
        return const Color(0xFF9370DB);
      case 'restaurant':
        return const Color(0xFFFF4500);
      case 'cafe':
        return const Color(0xFF8B4513);
      case 'viewpoint':
        return const Color(0xFF1E90FF);
      default:
        return Colors.teal;
    }
  }
}
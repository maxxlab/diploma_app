// lib/screens/map/widgets/events_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/index.dart';
import 'package:tourist_app/models/event.dart';
import 'package:tourist_app/screens/map/widgets/events/bloc/events_bloc.dart';
import 'package:tourist_app/widgets/error_view.dart';
import 'package:tourist_app/widgets/laoding_view.dart';

class EventsTab extends StatelessWidget {
  final String poiId;

  const EventsTab({
    Key? key,
    required this.poiId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading) {
          return const LoadingView(message: 'Loading events...');
        }

        if (state is EventsError) {
          return ErrorView(
            message: state.message,
            onRetry: () => context.read<EventsBloc>().add(LoadEvents(poiId: poiId)),
          );
        }

        if (state is EventsLoaded) {
          if (state.events.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildEventsList(context, state.events);
        }

        return _buildEmptyState(context);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Events Available',
              style: context.textTheme.titleLarge?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'There are currently no events scheduled for this location.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<EventsBloc>().add(AddMockEvents(poiId: poiId));
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Sample Events'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsList(BuildContext context, List<Event> events) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Events',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  context.read<EventsBloc>().add(AddMockEvents(poiId: poiId));
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add More'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: events.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final event = events[index];
                return _buildEventCard(context, event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    final isUpcoming = event.startTime.isAfter(DateTime.now());
    final isPast = event.endTime.isBefore(DateTime.now());

    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPast
              ? Colors.grey.shade300
              : _getCategoryColor(event.category).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showEventDetails(context, event),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(event.category).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(event.category),
                        size: 20,
                        color: _getCategoryColor(event.category),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isPast ? Colors.grey.shade600 : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            event.description,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: isPast ? Colors.grey.shade500 : Colors.grey.shade600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isPast)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'PAST',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    else if (isUpcoming)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'UPCOMING',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatEventTime(event),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                if (event.organizer != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        event.organizer!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (event.priceInfo != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.priceInfo!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(event.description),
              const SizedBox(height: 16),
              if (event.organizer != null) ...[
                Text('Organizer: ${event.organizer}',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
              ],
              Text('Time: ${_formatEventTime(event)}',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              if (event.priceInfo != null) ...[
                const SizedBox(height: 8),
                Text('Price: ${event.priceInfo}',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatEventTime(Event event) {
    final startDate = event.startTime;
    final endDate = event.endTime;

    if (startDate.day == endDate.day &&
        startDate.month == endDate.month &&
        startDate.year == endDate.year) {
      return '${_formatDate(startDate)} • ${_formatTime(startDate)} - ${_formatTime(endDate)}';
    } else {
      return '${_formatDate(startDate)} ${_formatTime(startDate)} - ${_formatDate(endDate)} ${_formatTime(endDate)}';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';

    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${date.day} ${months[date.month - 1]}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'concert':
        return Icons.music_note;
      case 'exhibition':
        return Icons.palette;
      case 'festival':
        return Icons.celebration;
      case 'theater':
        return Icons.theater_comedy;
      case 'sport':
        return Icons.sports;
      case 'conference':
        return Icons.business;
      default:
        return Icons.event;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'concert':
        return const Color(0xFF9C27B0);
      case 'exhibition':
        return const Color(0xFF673AB7);
      case 'festival':
        return const Color(0xFFFF9800);
      case 'theater':
        return const Color(0xFFE91E63);
      case 'sport':
        return const Color(0xFF4CAF50);
      case 'conference':
        return const Color(0xFF607D8B);
      default:
        return const Color(0xFF2196F3);
    }
  }
}
import 'package:flutter/material.dart';
import '../../../widgets/custom_image_widget.dart';

class PostedTicketsSectionWidget extends StatelessWidget {
  const PostedTicketsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Posted Tickets',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            TextButton(
                onPressed: () {
                  // TODO: Navigate to all posted tickets
                },
                child: Text('View All',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: theme.colorScheme.primary))),
          ]),
          const SizedBox(height: 16),
          SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _buildTicketCard(context, index);
                  })),
        ]));
  }

  Widget _buildTicketCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final ticketData = _getTicketData(index);

    return Container(
        width: 160,
        margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
        child: GestureDetector(
            onTap: () {
              // TODO: Navigate to ticket detail
            },
            onLongPress: () {
              _showTicketActions(context, ticketData);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.1),
                        width: 1)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Image
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: Stack(children: [
                            CustomImageWidget(
                                imageUrl: ticketData['image'],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover),
                            Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: _getStatusColor(
                                            theme, ticketData['status']),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(ticketData['status'],
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)))),
                          ])),

                      // Ticket Details
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ticketData['title'],
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    const Spacer(),
                                    Text('\$${ticketData['price']}',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                color:
                                                    theme.colorScheme.primary,
                                                fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text('Posted ${ticketData['date']}',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant)),
                                  ]))),
                    ]))));
  }

  void _showTicketActions(
      BuildContext context, Map<String, dynamic> ticketData) {
    final theme = Theme.of(context);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2))),
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      Text(ticketData['title'],
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      _buildActionOption(
                          context: context,
                          icon: Icons.edit_outlined,
                          title: 'Edit Ticket',
                          onTap: () {
                            Navigator.pop(context);
                            // TODO: Navigate to edit ticket
                          }),
                      const SizedBox(height: 16),
                      _buildActionOption(
                          context: context,
                          icon: Icons.check_circle_outline,
                          title: 'Mark as Sold',
                          onTap: () {
                            Navigator.pop(context);
                            // TODO: Mark ticket as sold
                          }),
                      const SizedBox(height: 16),
                      _buildActionOption(
                          context: context,
                          icon: Icons.delete_outline,
                          title: 'Delete Ticket',
                          isDestructive: true,
                          onTap: () {
                            Navigator.pop(context);
                            // TODO: Delete ticket
                          }),
                    ])),
              ]));
        });
  }

  Widget _buildActionOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);

    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    width: 1)),
            child: Row(children: [
              Icon(icon,
                  color: isDestructive
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface,
                  size: 24),
              const SizedBox(width: 16),
              Text(title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDestructive
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500)),
            ])));
  }

  Color _getStatusColor(ThemeData theme, String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return theme.colorScheme.secondary;
      case 'pending':
        return const Color(0xFFF2C94C); // Warning yellow
      case 'sold':
        return theme.colorScheme.outline;
      default:
        return theme.colorScheme.primary;
    }
  }

  Map<String, dynamic> _getTicketData(int index) {
    final tickets = [
      {
        'title': 'Taylor Swift Concert',
        'price': '250',
        'date': '2 days ago',
        'status': 'Active',
        'image':
            'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=400&h=300&fit=crop',
      },
      {
        'title': 'NBA Finals Game 7',
        'price': '450',
        'date': '1 week ago',
        'status': 'Sold',
        'image':
            'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=400&h=300&fit=crop',
      },
      {
        'title': 'Music Festival Pass',
        'price': '180',
        'date': '3 days ago',
        'status': 'Pending',
        'image':
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=300&fit=crop',
      },
      {
        'title': 'Broadway Show',
        'price': '120',
        'date': '1 day ago',
        'status': 'Active',
        'image':
            'https://images.unsplash.com/photo-1507924538820-ede94a04019d?w=400&h=300&fit=crop',
      },
      {
        'title': 'Comedy Show',
        'price': '60',
        'date': '5 days ago',
        'status': 'Active',
        'image':
            'https://images.unsplash.com/photo-1585699292787-86d5d8f6f4ba?w=400&h=300&fit=crop',
      },
    ];
    return tickets[index % tickets.length];
  }
}
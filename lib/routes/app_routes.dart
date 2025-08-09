import 'package:flutter/material.dart';
import '../presentation/post_ticket_screen/post_ticket_screen.dart';
import '../presentation/search_screen/search_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/ticket_detail_screen/ticket_detail_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String postTicket = '/post-ticket-screen';
  static const String search = '/search-screen';
  static const String home = '/home-screen';
  static const String ticketDetailScreen = '/ticket-detail-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const PostTicketScreen(),
    postTicket: (context) => const PostTicketScreen(),
    search: (context) => const SearchScreen(),
    home: (context) => const HomeScreen(),
    ticketDetailScreen: (context) => const TicketDetailScreen(),
    // TODO: Add your other routes here
  };
}

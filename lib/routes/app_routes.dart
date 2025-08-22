import 'package:flutter/material.dart';
import '../presentation/post_ticket_screen/post_ticket_screen.dart';
import '../presentation/search_screen/search_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/ticket_detail_screen/ticket_detail_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/chat_screen/chat_screen.dart';
import '../presentation/chats_list_screen/chats_list_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/splash-screen';
  static const String splashScreen = '/splash-screen';
  static const String chatScreen = '/chat-screen';
  static const String chatsListScreen = '/chats-list-screen';
  static const String postTicket = '/post-ticket-screen';
  static const String search = '/search-screen';
  static const String home = '/home-screen';
  static const String ticketDetailScreen = '/ticket-detail-screen';
  static const String profileScreen = '/profile-screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    chatScreen: (context) => const ChatScreen(),
    chatsListScreen: (context) => const ChatsListScreen(),
    postTicket: (context) => const PostTicketScreen(),
    search: (context) => const SearchScreen(),
    home: (context) => const HomeScreen(),
    ticketDetailScreen: (context) => const TicketDetailScreen(),
    profileScreen: (context) => const ProfileScreen(),
    // TODO: Add your other routes here
  };
}

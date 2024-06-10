import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/screens/documents/document_screen.dart';
import 'package:serti0x_blog_editor/screens/landing_page/landing_page.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: LandingPage(),
        ),
    RouteNames.instance.document: (route) =>
        const MaterialPage(child: LandingPage()),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    //!
    RouteNames.instance.document: (route) =>
        const MaterialPage(child: DocumentScreen())
  },
);

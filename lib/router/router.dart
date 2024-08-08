import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/screens/articles/article_screen.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_editor.dart';
import 'package:serti0x_blog_editor/screens/landing_page/landing_page.dart';

final loggedOutRoute = RouteMap(
  routes: {
    RouteNames.instance.landingPage: (route) => const MaterialPage(
          child: LandingPage(),
        ),
    RouteNames.instance.articles: (route) =>
        const MaterialPage(child: LandingPage()),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    RouteNames.instance.landingPage: (route) => const MaterialPage(
          child: LandingPage(),
        ),
    //!
    RouteNames.instance.articles: (route) =>
        const MaterialPage(child: ArticleScreen()),

    //! EDIT ARTICLES
    RouteNames.instance.editArticle: (route) {
      final articleID = route.queryParameters["articleID"] ?? "";

      return MaterialPage(
        child: ArticleEditor(
          articleID: articleID,
        ),
      );
    }
  },
);

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/router/app_router.gr.dart';
import 'package:graduate_app/router/root_navigation_bar.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/my_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        HomeRouterRoute(),
        SearchRouterRoute(),
        GroupRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) => child,
        );
      },
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return Stack(
          children: [
            Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: AppBar(
                  forceMaterialTransparency: true,
                  title: Text(
                    context.topRoute.title(context),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  leading: AutoLeadingButton(
                    showIfChildCanPop: false,
                  ),
                  backgroundColor: Colors.black,
                ),
              ),
              drawer: Drawer(child: MyDrawer(
                toSettings: () {
                  Navigator.of(context).pop();
                  context.navigateTo(SettingsRouterRoute());
                },
              )),
              body: child,
              bottomNavigationBar: RootNavigationBar(tabsRouter: tabsRouter),
            ),
            if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
          ],
        );
      },
    );
  }
}

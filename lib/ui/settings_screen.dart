import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/router/app_router.dart';

@RoutePage()
class SettingsRouterPage extends AutoRouter {
  SettingsRouterPage({super.key});
}

@RoutePage()
class SettingsScreenPage extends StatelessWidget {
  const SettingsScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  fixedSize: Size(250, 60),
                ),
                child: Text(
                  "メッセージ設定",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => context.router.push(EditMessageRoute()),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  fixedSize: Size(250, 60),
                ),
                child: Text(
                  "連絡先",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => context.router.push(AddressRoute()),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  fixedSize: Size(250, 60),
                ),
                child: Text(
                  "防災グッズ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => context.router.push(SurvivalKitRoute()),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  fixedSize: Size(250, 60),
                ),
                child: Text(
                  "個人設定",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => context.router.push(MyRoute()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:graduate_app/utils/connectivity.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension WidgetRefEx on WidgetRef {
  /// インターネットの接続状況を監視し、接続が切れた場合にスナックバーを表示する。
  void handleConnectivity() =>
      listen<AsyncValue<ConnectivityResult>>(connectivityProvider, (_, next) {
        if (next.isLoading) {
          // ローディングを表示する
          watch(overlayLoadingProvider.notifier).update((state) => false);
          return;
        }

        next.when(
          data: (data) async {
            // ローディングを非表示にする
            watch(overlayLoadingProvider.notifier).update((state) => false);
            // インターネット接続が切れた際に
            if (data == ConnectivityResult.none) {
              watch(scaffoldMessengerServiceProvider)
                  .showSnackBar('インターネットに接続してください');
            }
          },
          error: (e, s) async {
            // ローディングを非表示にする
            watch(overlayLoadingProvider.notifier).update((state) => false);
            // エラーが発生したらエラーダイアログを表示する
            watch(scaffoldMessengerServiceProvider)
                .showSnackBar('インターネットに接続してください');
          },
          loading: () {
            // ローディングを表示する
            watch(overlayLoadingProvider.notifier).update((state) => false);
          },
        );
      });
}

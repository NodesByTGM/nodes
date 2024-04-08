import 'package:nodes/utilities/constants/exported_packages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomPaystackWebview extends StatelessWidget {
  const CustomPaystackWebview({
    super.key,
    required this.authUrl,
    required this.ref,
  });

  final String authUrl;
  final String ref;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        // appBar: AppBar(
        //     // leading: SizedBox.shrink(),
        //     ),
        body: Padding(
          padding: const EdgeInsets.only(top: 55),
          child: WebView(
            initialUrl: authUrl,
            javascriptMode: JavascriptMode.unrestricted,
            userAgent: 'Flutter;Webview',
            navigationDelegate: (navigation) {
              //Listen for callback URL
              // Callback from using Card
              if (navigation.url == paystackCardCallbackUrl) {
                Navigator.of(context).pop(true); //close webview
                // Means nothing will be returned...
              }

              // Call back from a success transaction
              if (navigation.url == paystackCallbackUrl(ref)) {
                // if (navigation.url.contains(tGMWebsite)) {
                // Navigator.of(context).pop(ref);
                Navigator.of(context).pop(true);
              }

              // Call back when user cancels payment procedure
              if (navigation.url == paystackCancelActionUrl) {
                Navigator.of(context).pop(false);
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.url});

  final String url;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  String url = '';

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        webViewController?.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget webview = InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
      initialOptions: options,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (InAppWebViewController controller) {
        webViewController = controller;
      },
      onLoadStart: (InAppWebViewController controller, Uri? url) {
        setState(() {
          this.url = url.toString();
        });
      },
      androidOnPermissionRequest: (
        InAppWebViewController controller,
        String origin,
        List<String> resources,
      ) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      shouldOverrideUrlLoading: (
        InAppWebViewController controller,
        NavigationAction navigationAction,
      ) async {
        final Uri uri = navigationAction.request.url!;

        if (!['http', 'https', 'file', 'chrome', 'data', 'javascript', 'about']
            .contains(uri.scheme)) {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
            return NavigationActionPolicy.CANCEL;
          }
        }

        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (InAppWebViewController controller, Uri? url) async {
        pullToRefreshController.endRefreshing();
        setState(() {
          this.url = url.toString();
        });
      },
      onLoadError: (
        InAppWebViewController controller,
        Uri? url,
        int code,
        String message,
      ) {
        pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        if (progress == 100) {
          pullToRefreshController.endRefreshing();
        }
      },
      onUpdateVisitedHistory: (
        InAppWebViewController controller,
        Uri? url,
        bool? androidIsReload,
      ) {
        setState(() {
          this.url = url.toString();
        });
      },
    );

    return WillPopScope(
      onWillPop: () async {
        webViewController?.goBack();
        return false;
      },
      child: SafeArea(child: webview),
    );
  }
}

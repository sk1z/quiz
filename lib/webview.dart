import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({super.key, required this.url});

  final String url;

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
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
  final urlController = TextEditingController();

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
          urlController.text = this.url;
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
          urlController.text = this.url;
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
        setState(() {
          urlController.text = url;
        });
      },
      onUpdateVisitedHistory: (
        InAppWebViewController controller,
        Uri? url,
        bool? androidIsReload,
      ) {
        setState(() {
          this.url = url.toString();
          urlController.text = this.url;
        });
      },
    );

    return WillPopScope(
      onWillPop: () async {
        webViewController?.goBack();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // TextField(
              //   decoration:
              //       const InputDecoration(prefixIcon: Icon(Icons.search)),
              //   controller: urlController,
              //   keyboardType: TextInputType.url,
              //   onSubmitted: (String value) {
              //     Uri url = Uri.parse(value);
              //     if (url.scheme.isEmpty) {
              //       url = Uri.parse('https://www.google.com/search?q=$value');
              //     }
              //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
              //   },
              // ),
              Expanded(child: webview),
            ],
          ),
        ),
      ),
    );
  }
}

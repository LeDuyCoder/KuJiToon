// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

// ignore: undefined_prefixed_name
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

// ignore: undefined_prefixed_name
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';

class ChapterImageWeb extends StatefulWidget {
  final String imageUrl;

  const ChapterImageWeb({super.key, required this.imageUrl});

  @override
  State<ChapterImageWeb> createState() => _ChapterImageWebState();
}

class _ChapterImageWebState extends State<ChapterImageWeb> {
  double? _aspectRatio;
  late final String _viewType;

  @override
  void initState() {
    super.initState();

    _viewType = 'html-img-${widget.imageUrl.hashCode}';

    // preload để lấy kích thước thật
    final probe = html.ImageElement(src: widget.imageUrl);

    probe.onLoad.listen((_) {
      if (!mounted) return;
      setState(() {
        _aspectRatio = probe.naturalHeight / probe.naturalWidth;
      });
    });

    probe.onError.listen((_) {
      if (!mounted) return;
      setState(() {
        _aspectRatio = 1; // fallback
      });
    });

    ui.platformViewRegistry.registerViewFactory(
      _viewType,
          (int viewId) {
        final img = html.ImageElement()
          ..src = widget.imageUrl
          ..style.width = '100%'
          ..style.height = 'auto'
          ..style.display = 'block';

        img.setAttribute('loading', 'lazy');
        return img;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_aspectRatio == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: LoadingWidget(imageAsset: "assets/img/mascot/pic2.png"),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width * _aspectRatio!;

        return SizedBox(
          width: width,
          height: height, // 🔥 CỰC KỲ QUAN TRỌNG
          child: HtmlElementView(viewType: _viewType),
        );
      },
    );
  }
}
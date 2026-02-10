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
  html.ImageElement? _img;

  @override
  void initState() {
    super.initState();

    _img = html.ImageElement(src: widget.imageUrl);

    _img!.onLoad.listen((_) {
      if (!mounted) return;
      setState(() {
        _aspectRatio =
            _img!.naturalHeight / _img!.naturalWidth;
      });
    });

    _img!.onError.listen((_) {
      if (!mounted) return;
      setState(() {
        _aspectRatio = 1;
      });
    });
  }

  @override
  void dispose() {
    _img?.src = '';
    _img = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_aspectRatio == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: LoadingWidget(imageAsset: "assets/img/mascot/pic2.png")),
      );
    }

    final viewType = 'html-img-${widget.imageUrl.hashCode}';

    ui.platformViewRegistry.registerViewFactory(
      viewType,
          (int viewId) {
        final wrapper = html.DivElement()
          ..style.margin = '0'
          ..style.padding = '0'
          ..style.border = '0'
          ..style.lineHeight = '0'
          ..style.display = 'block';

        final img = html.ImageElement()
          ..src = widget.imageUrl
          ..style.display = 'block'
          ..style.width = '100%'
          ..style.height = 'auto'
          ..style.margin = '0'
          ..style.padding = '0'
          ..style.border = '0';

        wrapper.append(img);
        return wrapper;
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width * _aspectRatio!;

        return SizedBox(
          width: width,
          height: height,
          child: HtmlElementView(viewType: viewType),
        );
      },
    );
  }
}

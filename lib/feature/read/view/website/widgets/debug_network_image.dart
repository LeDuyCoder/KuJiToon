import 'package:flutter/material.dart';

class DebugNetworkImage extends StatefulWidget {
  final String url;

  const DebugNetworkImage(this.url, {super.key});

  @override
  State<DebugNetworkImage> createState() => _DebugNetworkImageState();
}

class _DebugNetworkImageState extends State<DebugNetworkImage> {
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    final image = NetworkImage(widget.url);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (info, _) {},
        onError: (error, stackTrace) {
          debugPrint('❌ IMAGE LOAD ERROR: ${widget.url}');
          debugPrint(error.toString());
          setState(() => _hasError = true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Icon(Icons.broken_image, size: 48),
      );
    }

    return Image.network(widget.url, fit: BoxFit.contain);
  }
}

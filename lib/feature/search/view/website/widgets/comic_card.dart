import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kujitoon/core/utils/query_crypto_util.dart';
import 'package:kujitoon/feature/details/public/detail_route_input.dart';
import 'package:kujitoon/feature/details/public/detail_user_route_params.dart';
import 'package:kujitoon/feature/search/domain/entities/prominent_commic.dart';
import 'package:kujitoon/feature/search/view/website/widgets/category_chip.dart';
import 'package:kujitoon/feature/search/view/website/widgets/status_badge.dart';

class ComicCard extends StatefulWidget {
  final ProminentCommic comic;
  final String userParagram;
  const ComicCard({super.key, required this.comic, required this.userParagram});

  @override
  State<ComicCard> createState() => _ComicCardState();
}

class _ComicCardState extends State<ComicCard> {
  bool _hovering = false;
  final String domainImage = "https://img.otruyenapi.com/uploads/comics/";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          final Map<String, dynamic> raw = jsonDecode(widget.userParagram);

          final Map<String, String> userData =
          raw.map((key, value) => MapEntry(key, value.toString()));

          final input = DetailRouteInput(
            slug: widget.comic.slug,
            userParams: DetailUserRouteParams.fromQueryParams({"u": QueryCryptoUtil.encode(userData)}),
          );

          Navigator.pushNamed(
            context,
            input.toUri().toString(),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildThumbnail(), // 👈 chỉ ảnh hover
              _buildInfo(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= IMAGE =================
  Widget _buildThumbnail() {
    return SizedBox(
      height: 220, // 🔒 khóa chiều cao
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: _hovering ? 1.08 : 1.0, // ✅ scale ảnh
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: Image.network(
                domainImage + widget.comic.thumbUrl,
                fit: BoxFit.cover,
              ),
            ),

            // gradient
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: StatusBadge(status: widget.comic.ongoing),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INFO =================
  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.comic.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),

          if (widget.comic.originName.isNotEmpty)
            Text(
              widget.comic.originName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),

          const SizedBox(height: 8),

          SizedBox(
            height: 22,
            child: Wrap(
              spacing: 6,
              children: widget.comic.categories
                  .take(2)
                  .map((c) => CategoryChip(label: c.name))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
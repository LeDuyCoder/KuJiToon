import 'package:flutter/material.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: isMobile
                      ? _buildMobileFooter()
                      : _buildDesktopFooter(),
                ),
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.grey.shade300),

              const SizedBox(height: 10),

              Text(
                "© 2025 KujiToom. Tất cả các quyền được bảo lưu.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  /// ===== DESKTOP =====
  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _aboutSection(crossAxis: CrossAxisAlignment.start)),
        Expanded(child: _socialSection(crossAxis: CrossAxisAlignment.start)),
      ],
    );
  }

  /// ===== MOBILE =====
  Widget _buildMobileFooter() {
    return Column(
      children: [
        _aboutSection(
          crossAxis: CrossAxisAlignment.center,
          centerText: true,
        ),
        const SizedBox(height: 24),
        _socialSection(
          crossAxis: CrossAxisAlignment.center,
          centerText: true,
        ),
      ],
    );
  }

  /// ===== ABOUT =====
  Widget _aboutSection({
    required CrossAxisAlignment crossAxis,
    bool centerText = false,
  }) {
    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Text(
          "Về chúng tôi",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: centerText ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 10),
        HoverableWidget(
          onTap: () {},
          child: Text(
            "Giới thiệu",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        HoverableWidget(
          onTap: () {},
          child: Text(
            "Liên hệ với chúng tôi",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  /// ===== SOCIAL =====
  Widget _socialSection({
    required CrossAxisAlignment crossAxis,
    bool centerText = false,
  }) {
    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Text(
          "Theo dõi chúng tôi",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: centerText ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 10),
        HoverableWidget(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.facebook, size: 18),
              SizedBox(width: 8),
              Text("Facebook", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        HoverableWidget(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.close, size: 18),
              SizedBox(width: 8),
              Text("Twitter", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}

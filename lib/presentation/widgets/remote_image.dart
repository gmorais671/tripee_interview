import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Widget genérico para carregar uma imagem remota com fallback.
/// Pode ser usado como avatar circular (driver) ou logo retangular (provider).
class RemoteImage extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final double borderRadius;
  final String? nameForInitials; // usado quando não há imagem
  final String? assetPlaceholder; // caminho para asset local
  final BoxFit fit;
  final bool circular;

  const RemoteImage({
    super.key,
    required this.url,
    this.width = 56,
    this.height = 56,
    this.borderRadius = 8,
    this.nameForInitials,
    this.assetPlaceholder,
    this.fit = BoxFit.cover,
    this.circular = false,
  });

  bool _isValidRemoteUrl(String? u) {
    if (u == null || u.trim().isEmpty) return false;
    final uri = Uri.tryParse(u);
    if (uri == null || !uri.hasAbsolutePath) return false;
    // tratar urls de exemplo (ex.: example.com) como inválidas para evitar 404 previsíveis
    final host = uri.host.toLowerCase();
    if (host.contains('example.com') || host.contains('localhost')) return false;
    return true;
  }

  String _initials(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) return '';
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Widget _buildFallback(BuildContext context) {
    if (assetPlaceholder != null && assetPlaceholder!.isNotEmpty) {
      final widget = Image.asset(
        assetPlaceholder!,
        width: width,
        height: height,
        fit: fit,
      );
      return circular
          ? ClipOval(child: widget)
          : ClipRRect(borderRadius: BorderRadius.circular(borderRadius), child: widget);
    }

    final initials = _initials(nameForInitials);
    final bgColor = Theme.of(context).colorScheme.primary.withOpacity(0.1);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: circular ? null : BorderRadius.circular(borderRadius),
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: (width / 2.5).clamp(12, 20),
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasUrl = _isValidRemoteUrl(url);

    if (!hasUrl) {
      return _buildFallback(context);
    }

    // CachedNetworkImage cuida do cache automaticamente.
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: url!,
        imageBuilder: (context, imageProvider) {
          return circular
              ? CircleAvatar(radius: width / 2, backgroundImage: imageProvider)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image(
                    image: imageProvider,
                    width: width,
                    height: height,
                    fit: fit,
                  ),
                );
        },
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: SizedBox(
            width: width / 2.2,
            height: width / 2.2,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => _buildFallback(context),
      ),
    );
  }
}
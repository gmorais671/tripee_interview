import 'package:flutter/material.dart';
import 'remote_image.dart'; // Importando o widget anterior

class DriverAvatar extends StatelessWidget {
  final String? driverPhotoUrl;
  final String? providerLogoUrl;
  final String? driverName;
  final double radius;

  const DriverAvatar({
    super.key,
    required this.driverPhotoUrl,
    required this.providerLogoUrl,
    this.driverName,
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = radius * 2;
    // Cálculo proporcional para a logo (ajustado conforme o raio do avatar)
    final double badgeSize = radius * 0.8; 

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none, // Permite que a logo "sangre" um pouco para fora se necessário
      children: [
        // Foto do Motorista
        RemoteImage(
          url: driverPhotoUrl,
          width: avatarSize,
          height: avatarSize,
          circular: true,
          nameForInitials: driverName,
        ),
        
        // Logo do Provider sobreposta
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            padding: const EdgeInsets.all(2), // Borda branca interna
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: RemoteImage(
              url: providerLogoUrl,
              width: badgeSize,
              height: badgeSize,
              circular: true,
              borderRadius: badgeSize / 2,
              fit: BoxFit.contain,
              // Não passamos iniciais para a logo, se falhar, mostramos um ícone genérico
              nameForInitials: "", 
            ),
          ),
        ),
      ],
    );
  }
}
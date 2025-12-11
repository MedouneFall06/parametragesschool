import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/models/etudiant_model.dart';

class EtudiantCard extends StatelessWidget {
  final Etudiant etudiant;
  final String? nomClasse;
  final VoidCallback? onTap;
  
  const EtudiantCard({
    super.key,
    required this.etudiant,
    this.nomClasse,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${etudiant.prenom} ${etudiant.nom}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(
                      icon: Icons.badge,
                      text: etudiant.matricule,
                    ),
                    if (nomClasse != null && nomClasse!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        icon: Icons.school,
                        text: nomClasse!,
                      ),
                    ],
                    const SizedBox(height: 4),
                    _buildParentStatus(),
                  ],
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: AppTheme.primaryColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final initiales = _getInitiales(etudiant.prenom, etudiant.nom);
    
    return CircleAvatar(
      radius: 24,
      backgroundColor: _getAvatarColor(etudiant.id),
      child: Text(
        initiales,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  String _getInitiales(String prenom, String nom) {
    String initiales = "";
    if (prenom.isNotEmpty) initiales += prenom[0];
    if (nom.isNotEmpty) initiales += nom[0];
    return initiales.isNotEmpty ? initiales : "?";
  }

  Color _getAvatarColor(String id) {
    final hash = id.hashCode;
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
      AppTheme.warningColor,
      AppTheme.successColor,
    ];
    return colors[hash.abs() % colors.length];
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: AppTheme.textSecondary,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildParentStatus() {
    if (etudiant.parentId != null && etudiant.parentId!.isNotEmpty) {
      return Row(
        children: [
          Icon(
            Icons.family_restroom,
            size: 14,
            color: AppTheme.successColor,
          ),
          const SizedBox(width: 6),
          Text(
            "Lié à un parent",
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.successColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            Icons.person_off,
            size: 14,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            "Non lié",
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }
  }
}
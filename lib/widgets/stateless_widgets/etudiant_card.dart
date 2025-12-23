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
    // FORCER l'adaptation radicale pour petits écrans
    final width = MediaQuery.of(context).size.width;
    final bool isVerySmallScreen = width < 400; // iPhone SE, petits Android
    final bool isSmallScreen = width < 600;     // Mobiles standards
    
    return Card(
      margin: EdgeInsets.zero, // CRITIQUE : ResponsiveGrid gère l'espace
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 0, // Permet de rétrécir
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.all(isVerySmallScreen ? 8 : isSmallScreen ? 10 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AVATAR - TAILLE DYNAMIQUE RADICALE
              Container(
                width: isVerySmallScreen ? 32 : isSmallScreen ? 36 : 40,
                height: isVerySmallScreen ? 32 : isSmallScreen ? 36 : 40,
                decoration: BoxDecoration(
                  color: _getAvatarColor(etudiant.id),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _getInitiales(etudiant.prenom, etudiant.nom),
                    style: TextStyle(
                      fontSize: isVerySmallScreen ? 12 : isSmallScreen ? 13 : 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: isVerySmallScreen ? 8 : isSmallScreen ? 10 : 12),
              
              // CONTENU PRINCIPAL - AVEC CONTRAINTES STRICTES
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // NOM PRÉNOM - TAILLE DYNAMIQUE
                    Text(
                      "${etudiant.prenom} ${etudiant.nom}",
                      style: TextStyle(
                        fontSize: isVerySmallScreen ? 13 : isSmallScreen ? 14 : 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: isVerySmallScreen ? 2 : 3),
                    
                    // MATRICULE
                    _buildCompactInfoRow(
                      icon: Icons.badge,
                      text: etudiant.matricule,
                      isVerySmallScreen: isVerySmallScreen,
                      isSmallScreen: isSmallScreen,
                    ),
                    
                    // CLASSE (seulement si place)
                    if (nomClasse != null && nomClasse!.isNotEmpty) 
                      _buildCompactInfoRow(
                        icon: Icons.school,
                        text: nomClasse!,
                        isVerySmallScreen: isVerySmallScreen,
                        isSmallScreen: isSmallScreen,
                      ),
                    
                    // STATUT PARENT (seulement sur écrans assez larges)
                    if (!isVerySmallScreen && width > 350)
                      _buildParentStatusCompact(
                        etudiant: etudiant,
                        isVerySmallScreen: isVerySmallScreen,
                        isSmallScreen: isSmallScreen,
                      ),
                  ],
                ),
              ),
              
              // FLÈCHE (seulement si assez de place)
              if (onTap != null && width > 300) ...[
                SizedBox(width: isVerySmallScreen ? 4 : 6),
                Icon(
                  Icons.chevron_right,
                  color: AppTheme.primaryColor,
                  size: isVerySmallScreen ? 16 : isSmallScreen ? 18 : 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactInfoRow({
    required IconData icon,
    required String text,
    required bool isVerySmallScreen,
    required bool isSmallScreen,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isVerySmallScreen ? 1 : 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isVerySmallScreen ? 10 : isSmallScreen ? 11 : 12,
            color: AppTheme.textSecondary,
          ),
          SizedBox(width: isVerySmallScreen ? 3 : 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isVerySmallScreen ? 11 : isSmallScreen ? 12 : 13,
                color: AppTheme.textSecondary,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentStatusCompact({
    required Etudiant etudiant,
    required bool isVerySmallScreen,
    required bool isSmallScreen,
  }) {
    final hasParent = etudiant.parentId != null && etudiant.parentId!.isNotEmpty;
    
    return Padding(
      padding: EdgeInsets.only(top: isVerySmallScreen ? 1 : 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            hasParent ? Icons.family_restroom : Icons.person_off,
            size: isVerySmallScreen ? 10 : isSmallScreen ? 11 : 12,
            color: hasParent ? AppTheme.successColor : AppTheme.textSecondary,
          ),
          SizedBox(width: isVerySmallScreen ? 3 : 4),
          Expanded(
            child: Text(
              hasParent ? "Parent lié" : "Non lié",
              style: TextStyle(
                fontSize: isVerySmallScreen ? 10 : isSmallScreen ? 11 : 12,
                color: hasParent ? AppTheme.successColor : AppTheme.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
}
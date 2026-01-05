import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:parametragesschool/core/constant/constants.dart';

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
    final width = MediaQuery.of(context).size.width;
    
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 0,
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AVATAR - TAILLE DYNAMIQUE
              Container(
                width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                decoration: BoxDecoration(
                  color: _getAvatarColor(etudiant.id),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _getInitiales(etudiant.prenom, etudiant.nom),
                    style: TextStyle(
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.statTitleFontSize),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: AppConstants.widthPercentage(context, AppConstants.paddingBetweenCards)),
              
              // CONTENU PRINCIPAL
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // NOM PRÉNOM
                    Text(
                      "${etudiant.prenom} ${etudiant.nom}",
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.labelFontSize),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                        height: AppConstants.textHeight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingTiny)),
                    
                    // MATRICULE
                    _buildCompactInfoRow(
                      icon: Icons.badge,
                      text: etudiant.matricule,
                      context: context,
                    ),
                    
                    // CLASSE
                    if (nomClasse != null && nomClasse!.isNotEmpty) 
                      _buildCompactInfoRow(
                        icon: Icons.school,
                        text: nomClasse!,
                        context: context,
                      ),
                    
                    // STATUT PARENT
                    if (width > 350)
                      _buildParentStatusCompact(
                        etudiant: etudiant,
                        context: context,
                      ),
                  ],
                ),
              ),
              
              // FLÈCHE
              if (onTap != null && width > 300) ...[
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Icon(
                  Icons.chevron_right,
                  color: AppTheme.primaryColor,
                  size: AppConstants.widthPercentage(context, AppConstants.iconSize),
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
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingTiny)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
            color: AppTheme.textSecondary,
          ),
          SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                color: AppTheme.textSecondary,
                height: AppConstants.textHeight,
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
    required BuildContext context,
  }) {
    final hasParent = etudiant.parentId != null && etudiant.parentId!.isNotEmpty;
    
    return Padding(
      padding: EdgeInsets.only(top: AppConstants.heightPercentage(context, AppConstants.spacingTiny)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            hasParent ? Icons.family_restroom : Icons.person_off,
            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
            color: hasParent ? AppTheme.successColor : AppTheme.textSecondary,
          ),
          SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
          Expanded(
            child: Text(
              hasParent ? "Parent lié" : "Non lié",
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                color: hasParent ? AppTheme.successColor : AppTheme.textSecondary,
                fontStyle: FontStyle.italic,
                height: AppConstants.textHeight,
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

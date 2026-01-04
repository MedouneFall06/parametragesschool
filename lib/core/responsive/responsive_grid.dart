import 'package:flutter/material.dart';
import '../constant/constants.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? customSpacing;
  final int? customMaxColumns;
  final double? customAspectRatio;
  final EdgeInsets? customPadding;
  final bool useConstants;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.customSpacing,
    this.customMaxColumns,
    this.customAspectRatio,
    this.customPadding,
    this.useConstants = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    // Utiliser les constantes ou les valeurs personnalisées
    final spacing = customSpacing ?? (useConstants 
        ? AppConstants.widthPercentage(context, AppConstants.spacingMedium)
        : 16.0);
    
    final padding = customPadding ?? EdgeInsets.symmetric(
      horizontal: AppConstants.widthPercentage(context, AppConstants.paddingHorizontal),
      vertical: AppConstants.heightPercentage(context, AppConstants.paddingVertical),
    );

    // Déterminer le nombre de colonnes selon la largeur
    int crossAxisCount;
    final maxColumns = customMaxColumns ?? AppConstants.maxGridColumns;
    
    if (width < 400) {
      crossAxisCount = 1; // Très petit mobile
    } else if (width < 600) {
      crossAxisCount = 2; // Mobile standard
    } else if (width < 900) {
      crossAxisCount = 3; // Tablet
    } else if (width < 1200) {
      crossAxisCount = 4; // Desktop moyen
    } else {
      crossAxisCount = maxColumns; // Grand écran
    }

    // Calculer le ratio d'aspect
    double childAspectRatio = customAspectRatio ?? _calculateAspectRatio(context, crossAxisCount);

    return Container(
      padding: padding,
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
        children: children,
      ),
    );
  }

  /// Calcule le ratio d'aspect optimal selon le nombre de colonnes
  double _calculateAspectRatio(BuildContext context, int columns) {
    switch (columns) {
      case 1:
        return AppConstants.rectangularAspectRatio * 1.5; // 3.0
      case 2:
        return AppConstants.rectangularAspectRatio; // 2.0
      case 3:
        return AppConstants.defaultAspectRatio; // 1.5
      case 4:
        return AppConstants.squareAspectRatio; // 1.0
      default:
        return AppConstants.squareAspectRatio * 0.8; // 0.8
    }
  }

  /// Méthode utilitaire pour créer une grille responsive avec des cartes
  static Widget createResponsiveCard({
    required BuildContext context,
    required Widget content,
    VoidCallback? onTap,
    Color? backgroundColor,
    EdgeInsets? margin,
  }) {
    return Card(
      margin: margin ?? EdgeInsets.all(
        AppConstants.widthPercentage(context, AppConstants.paddingBetweenCards)
      ),
      elevation: AppConstants.lightShadowBlur,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: EdgeInsets.all(
            AppConstants.widthPercentage(context, AppConstants.cardPadding)
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: content,
        ),
      ),
    );
  }

  /// Méthode utilitaire pour créer un élément de liste responsive
  static Widget createResponsiveListItem({
    required BuildContext context,
    required Widget leading,
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppConstants.widthPercentage(context, AppConstants.paddingHorizontal),
        vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
      ),
      leading: SizedBox(
        width: AppConstants.widthPercentage(context, AppConstants.iconSize),
        height: AppConstants.widthPercentage(context, AppConstants.iconSize),
        child: leading,
      ),
      title: DefaultTextStyle(
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.labelFontSize),
          fontWeight: FontWeight.w500,
        ),
        child: title,
      ),
      subtitle: subtitle != null ? DefaultTextStyle(
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
        ),
        child: subtitle,
      ) : null,
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
    );
  }
}

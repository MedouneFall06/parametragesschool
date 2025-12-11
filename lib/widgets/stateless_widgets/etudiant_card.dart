// ============================================================================
// FICHIER : lib/widgets/etudiant_card.dart
// ============================================================================
//
// Ce fichier définit un widget réutilisable : EtudiantCard.
// Il encapsule toute la logique d'affichage d'un étudiant sous forme de carte.
// Objectifs pédagogiques :
//   - apprendre à utiliser Card, CircleAvatar, Row, Column, Padding,
//   - comprendre la composition de widgets,
//   - illustrer le principe de réutilisation dans Flutter.
//
// ============================================================================

import 'package:flutter/material.dart';

// Importation du modèle Etudiant :
import '../../models/etudiant_model.dart';

/// ===========================================================================
/// 1. DÉFINITION DU WIDGET EtudiantCard
/// ===========================================================================
///
/// Ce widget stateless reçoit un objet Etudiant et construit une représentation
/// visuelle cohérente. Le choix d'un StatelessWidget est logique car cette carte
/// n'a pas d'état interne : elle ne change pas après son affichage.
///
class EtudiantCard extends StatelessWidget {

  // --------------------------------------------------------------------------
  // PROPRIÉTÉ : Instance d'un étudiant
  // --------------------------------------------------------------------------
  //
  // Le widget a besoin de connaître les détails de l'étudiant qu'il doit afficher.
  // L'objet Etudiant donne accès à :
  //   - id,
  //   - nom,
  //   - prenom,
  //   - matricule,
  //   - classeId,
  //   - parentId.
  //
  final Etudiant etudiant;

  // --------------------------------------------------------------------------
  // PROPRIÉTÉ : Nom de la classe (optionnel)
  // --------------------------------------------------------------------------
  //
  // Comme le modèle Etudiant ne contient que l'ID de la classe,
  // nous pouvons passer le nom de la classe en paramètre.
  // Ceci peut être récupéré via un Future ou depuis une Map.
  final String? nomClasse;

  // --------------------------------------------------------------------------
  // PROPRIÉTÉ : Callback pour les actions
  // --------------------------------------------------------------------------
  //
  // Fonction optionnelle appelée lors du tap sur la carte.
  // Permet de naviguer vers l'écran de détail ou d'effectuer une action.
  final VoidCallback? onTap;

  // Constructeur
  const EtudiantCard({
    super.key,
    required this.etudiant,
    this.nomClasse,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    // ------------------------------------------------------------------------
    // STRUCTURE GLOBALE : UTILISATION DU WIDGET Card
    // ------------------------------------------------------------------------
    //
    // Card est un widget Material Design qui :
    //   - affiche une surface avec ombre (élévation),
    //   - possède des coins arrondis,
    //   - est idéal pour afficher des blocs d'information indépendants.
    //
    return Card(
      // Espace extérieur autour de la carte
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      // Hauteur de l'ombre
      elevation: 2,

      // Arrondi des coins de la carte
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),

      // Permet à la carte d'être cliquable
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),

        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Row(
            children: [
              // ===================================================================
              // 1. AVATAR DE L'ÉTUDIANT
              // ===================================================================
              //
              // CircleAvatar affiche un avatar circulaire avec les initiales
              //
              _buildAvatar(context),

              const SizedBox(width: 16),

              // ===================================================================
              // 2. INFORMATIONS DE L'ÉTUDIANT
              // ===================================================================
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --------------------------------------------------------------
                    // NOM COMPLET (PRENOM + NOM)
                    // --------------------------------------------------------------
                    Text(
                      "${etudiant.prenom} ${etudiant.nom}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // --------------------------------------------------------------
                    // MATRICULE
                    // --------------------------------------------------------------
                    Row(
                      children: [
                        const Icon(
                          Icons.badge_outlined,
                          size: 14,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          etudiant.matricule,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // --------------------------------------------------------------
                    // CLASSE (si le nom est fourni)
                    // --------------------------------------------------------------
                    if (nomClasse != null && nomClasse!.isNotEmpty) ...[
                      Row(
                        children: [
                          const Icon(
                            Icons.school_outlined,
                            size: 14,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            nomClasse!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],

                    // --------------------------------------------------------------
                    // STATUT PARENT (si lié à un parent)
                    // --------------------------------------------------------------
                    _buildParentStatus(context),
                  ],
                ),
              ),

              // ===================================================================
              // 3. ICÔNE DE NAVIGATION (SI ONTAP EST DÉFINI)
              // ===================================================================
              //
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// ===========================================================================
  /// MÉTHODE PRIVÉE : Construction de l'avatar
  /// ===========================================================================
  ///
  /// Crée un CircleAvatar avec les initiales de l'étudiant.
  ///
  Widget _buildAvatar(BuildContext context) {
    final initiales = _getInitiales(etudiant.prenom, etudiant.nom);

    return CircleAvatar(
      radius: 25,
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

  /// ===========================================================================
  /// MÉTHODE PRIVÉE : Récupération des initiales
  /// ===========================================================================
  ///
  /// Extrait la première lettre du prénom et du nom.
  ///
  String _getInitiales(String prenom, String nom) {
    String initiales = "";
    if (prenom.isNotEmpty) initiales += prenom[0];
    if (nom.isNotEmpty) initiales += nom[0];
    return initiales.isNotEmpty ? initiales : "?";
  }

  /// ===========================================================================
  /// MÉTHODE PRIVÉE : Génération de couleur basée sur l'ID
  /// ===========================================================================
  ///
  /// Génère une couleur cohérente basée sur l'ID de l'étudiant.
  /// Cela permet d'avoir une couleur stable pour chaque étudiant.
  ///
  Color _getAvatarColor(String id) {
    // Utilise le hash de l'ID pour générer une couleur
    final hash = id.hashCode;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];
    return colors[hash.abs() % colors.length];
  }

  /// ===========================================================================
  /// MÉTHODE PRIVÉE : Affichage du statut parent
  /// ===========================================================================
  ///
  /// Affiche un indicateur si l'étudiant est lié à un parent.
  ///
  Widget _buildParentStatus(BuildContext context) {
    if (etudiant.parentId != null && etudiant.parentId!.isNotEmpty) {
      return Row(
        children: [
          const Icon(
            Icons.family_restroom_outlined,
            size: 14,
            color: Colors.green,
          ),

          const SizedBox(width: 6),

          Text(
            "Lié à un parent",
            style: TextStyle(
              fontSize: 12,
              color: Colors.green[700],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          const Icon(
            Icons.person_off_outlined,
            size: 14,
            color: Colors.grey,
          ),

          const SizedBox(width: 6),

          Text(
            "Non lié",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }
  }
}
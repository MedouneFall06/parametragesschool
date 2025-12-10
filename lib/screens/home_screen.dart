// ============================================================================
// FICHIER : lib/screens/home_screen.dart
// ============================================================================
//
// Cet écran affiche la liste des étudiants récents sous forme de cartes
// personnalisées. L'approche démontre :
//  - la manipulation d'un modèle de données (Etudiant),
//  - la génération dynamique d'une liste (ListView.builder),
//  - l'usage d'un widget personnalisé (EtudiantCard),
//  - les bonnes pratiques Flutter pour la performance.
//
// ============================================================================

import 'package:flutter/material.dart';

// 1. Import du modèle Etudiant : permet de typifier et structurer les données
//    de chaque étudiant.
import '../models/etudiant_model.dart';

// 2. Import du widget personnalisé utilisé pour afficher chaque étudiant.
//    Ce widget encapsule la mise en forme d'une "carte visuelle" (avatar + informations).
import '../widgets/etudiant_card.dart';

// ============================================================================
// 1. HomeScreen : ÉCRAN D'ACCUEIL DE L'APPLICATION
// ============================================================================
//
// Widget sans état (StatelessWidget) pour l'affichage de la liste d'étudiants.
// Plus tard, lorsqu'on intégrera une API ou une base de données,
// il pourra devenir Stateful ou alimenté par un Provider.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // ------------------------------------------------------------------------
    // 3. LISTE FACTICE (DUMMY DATA) D'ÉTUDIANTS
    // ------------------------------------------------------------------------
    //
    // Ici, nous créons des étudiants en "dur" (hard-coded).
    // Objectif pédagogique :
    //   - comprendre la structure des données,
    //   - tester l'affichage sans backend,
    //   - vérifier la cohérence du widget EtudiantCard.
    //
    // Plus tard, ces données seront récupérées depuis Firebase,
    // une API REST, une base locale, etc.
    final List<Etudiant> etudiants = [
      Etudiant(
        id: "1",
        nom: "Fall",
        prenom: "Medoune",
        matricule: "ETU2024001",
        classeId: "CLS001",
        parentId: "PAR001", // Lié à un parent
      ),
      Etudiant(
        id: "2",
        nom: "Diop",
        prenom: "Awa",
        matricule: "ETU2024002",
        classeId: "CLS001",
        parentId: null, // Non lié à un parent
      ),
      Etudiant(
        id: "3",
        nom: "Ndoye",
        prenom: "Moussa",
        matricule: "ETU2024003",
        classeId: "CLS002",
        parentId: "PAR002", // Lié à un parent
      ),
      Etudiant(
        id: "4",
        nom: "Sarr",
        prenom: "Fatou",
        matricule: "ETU2024004",
        classeId: "CLS001",
        parentId: "PAR003",
      ),
      Etudiant(
        id: "5",
        nom: "Gueye",
        prenom: "Ibrahima",
        matricule: "ETU2024005",
        classeId: "CLS003",
        parentId: null,
      ),
      Etudiant(
        id: "6",
        nom: "Diallo",
        prenom: "Aminata",
        matricule: "ETU2024006",
        classeId: "CLS002",
        parentId: "PAR004",
      ),
      Etudiant(
        id: "7",
        nom: "Ba",
        prenom: "Ousmane",
        matricule: "ETU2024007",
        classeId: "CLS003",
        parentId: "PAR005",
      ),
      Etudiant(
        id: "8",
        nom: "Camara",
        prenom: "Khadija",
        matricule: "ETU2024008",
        classeId: "CLS001",
        parentId: null,
      ),
    ];

    // ------------------------------------------------------------------------
    // 4. MAP DES CLASSES (pour afficher les noms)
    // ------------------------------------------------------------------------
    //
    // Dans un cas réel, on récupérerait ces données depuis une API.
    // Pour l'instant, nous utilisons une Map pour convertir les IDs en noms.
    final Map<String, String> classes = {
      "CLS001": "Terminale S",
      "CLS002": "Première L",
      "CLS003": "Seconde G",
    };

    // ------------------------------------------------------------------------
    // STRUCTURE PRINCIPALE DE LA PAGE (Scaffold)
    // ------------------------------------------------------------------------
    return Scaffold(
      // ----------------------------------------------------------------------
      // 5. APP BAR (BARRE SUPÉRIEURE)
      // ----------------------------------------------------------------------
      //
      // Affiche le titre de l'application et peut inclure des actions
      // (recherche, filtres, notifications, etc.)
      appBar: AppBar(
        title: const Text(
          'Gestion Éducative',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        // --------------------------------------------------------------------
        // ACTIONS SUPPLEMENTAIRES (OPTIONNELLES)
        // --------------------------------------------------------------------
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {
        //       // Ouvrir une barre de recherche
        //     },
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.filter_list),
        //     onPressed: () {
        //       // Ouvrir un menu de filtres
        //     },
        //   ),
        // ],
      ),

      // ----------------------------------------------------------------------
      // 6. CORPS DE LA PAGE (BODY)
      // ----------------------------------------------------------------------
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ------------------------------------------------------------------
          // EN-TÊTE DE LA PAGE
          // ------------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre de la section
                Text(
                  'Liste des Étudiants',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 4),

                // Statistiques (nombre d'étudiants)
                Text(
                  '${etudiants.length} étudiants inscrits',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                // Filtres rapides (optionnel)
                // const SizedBox(height: 12),
                // Wrap(
                //   spacing: 8.0,
                //   children: [
                //     FilterChip(
                //       label: const Text('Tous'),
                //       selected: true,
                //       onSelected: (selected) {},
                //     ),
                //     FilterChip(
                //       label: const Text('Avec parent'),
                //       onSelected: (selected) {},
                //     ),
                //     FilterChip(
                //       label: const Text('Terminale'),
                //       onSelected: (selected) {},
                //     ),
                //   ],
                // ),
              ],
            ),
          ),

          // ------------------------------------------------------------------
          // 7. LISTE DES ÉTUDIANTS AVEC ListView.builder
          // ------------------------------------------------------------------
          //
          // ListView.builder est LA méthode recommandée pour afficher beaucoup
          // d'éléments. Il construit uniquement les éléments visibles à l'écran :
          //
          //   - Meilleure performance
          //   - Pas besoin de construire toute la liste d'un coup
          //   - Idéal pour des flux dynamiques (API, Firebase, BDD, scroll infini)
          //
          Expanded(
            child: ListView.builder(
              // Nombre total d'éléments dans la liste
              itemCount: etudiants.length,

              // Padding et espacement entre les éléments
              padding: const EdgeInsets.only(bottom: 80.0),

              // Fonction appelée pour construire chaque élément de la liste.
              // Elle reçoit :
              //   - context : l'état actuel du widget
              //   - index : position de l'élément dans la liste (0, 1, 2...)
              itemBuilder: (context, index) {
                // On récupère l'étudiant à afficher pour cet index.
                final etudiant = etudiants[index];

                // ------------------------------------------------------------------
                // 8. UTILISATION DE NOTRE WIDGET PERSONNALISÉ : EtudiantCard
                // ------------------------------------------------------------------
                //
                // On lui passe l'objet 'etudiant' pour qu'il puisse afficher :
                //   - avatar avec initiales
                //   - nom et prénom
                //   - matricule
                //   - classe
                //   - statut de lien parent
                //
                // Cela met en pratique un principe fondamental :
                //   "Séparer la logique de données et la logique d'affichage"
                //
                return EtudiantCard(
                  etudiant: etudiant,
                  nomClasse: classes[etudiant.classeId], // Conversion ID -> nom
                  onTap: () {
                    // ------------------------------------------------------------------
                    // 9. NAVIGATION VERS L'ÉCRAN DE DÉTAIL (À IMPLÉMENTER)
                    // ------------------------------------------------------------------
                    //
                    // Lorsqu'on clique sur une carte, on peut naviguer vers
                    // l'écran de détail de l'étudiant.
                    //
                    // print("Navigation vers le détail de ${etudiant.prenom} ${etudiant.nom}");
                    //
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EtudiantDetailScreen(
                    //       etudiant: etudiant,
                    //       nomClasse: classes[etudiant.classeId],
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ----------------------------------------------------------------------
      // 10. BOUTON D'ACTION FLOTTANT (FLOATING ACTION BUTTON)
      // ----------------------------------------------------------------------
      //
      // Permet d'ajouter rapidement un nouvel étudiant.
      // Positionné en bas à droite avec un effet d'élévation.
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ------------------------------------------------------------------
          // 11. ACTION D'AJOUT D'ÉTUDIANT (À IMPLÉMENTER)
          // ------------------------------------------------------------------
          //
          // Ouvre un formulaire pour ajouter un nouvel étudiant.
          //
          print("Bouton d'ajout d'étudiant cliqué");
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddEtudiantScreen(),
          //   ),
          // );
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add),
        // Effet d'élévation pour un look Material Design
        elevation: 4.0,
        // Ombre lorsque le bouton est pressé
        highlightElevation: 8.0,
      ),

      // ----------------------------------------------------------------------
      // 12. ESPACE AUTOUR DU BOUTON FLOTTANT
      // ----------------------------------------------------------------------
      //
      // Permet d'éviter que le bouton ne chevauche le dernier élément de la liste.
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ============================================================================
// NOTES POUR LES ÉTAPES SUIVANTES :
// ============================================================================
//
// 1. INTÉGRATION DES DONNÉES RÉELLES :
//    - Remplacer la liste dummy par un appel API
//    - Utiliser FutureBuilder ou Provider pour gérer l'état
//
// 2. AJOUT DE FONCTIONNALITÉS :
//    - Barre de recherche pour filtrer les étudiants
//    - Filtres par classe, statut parent, etc.
//    - Pull-to-refresh pour rafraîchir la liste
//
// 3. AMÉLIORATIONS UI/UX :
//    - Animation lors de l'apparition des cartes
//    - Indicateur de chargement pendant le fetch
//    - Message d'erreur si pas de données
//
// 4. NAVIGATION :
//    - Implémenter les écrans de détail (EtudiantDetailScreen)
//    - Implémenter l'écran d'ajout (AddEtudiantScreen)
//    - Implémenter l'écran d'édition (EditEtudiantScreen)
//
// ============================================================================
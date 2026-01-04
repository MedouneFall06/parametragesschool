import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/parent_model.dart';
import 'package:parametragesschool/models/user_model.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
import 'package:parametragesschool/core/constant/constants.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer ParentViewModel
// TODO: Récupérer parents depuis l'API/BDD
// TODO: Implémenter CRUD des parents
// TODO: Gérer états loading/error
// TODO: Ajouter notifications aux parents

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  // Données fictives pour l'affichage statique
  final List<User> _parents = [
    User(
      id: "PAR001",
      nom: "Fall",
      prenom: "Abdoulaye",
      email: "a.fall@email.com",
      role: "parent",
    ),
    User(
      id: "PAR002",
      nom: "Diop",
      prenom: "Mariama",
      email: "m.diop@email.com",
      role: "parent",
    ),
    User(
      id: "PAR003",
      nom: "Ndoye",
      prenom: "Papa",
      email: "p.ndoye@email.com",
      role: "parent",
    ),
    User(
      id: "PAR004",
      nom: "Sarr",
      prenom: "Khadija",
      email: "k.sarr@email.com",
      role: "parent",
    ),
    User(
      id: "PAR005",
      nom: "Gueye",
      prenom: "Moussa",
      email: "m.gueye@email.com",
      role: "parent",
    ),
  ];

  // ignore: unused_field
  final Map<String, Parent> _parentsDetails = {
    "PAR001": Parent(userId: "PAR001"),
    "PAR002": Parent(userId: "PAR002"),
    "PAR003": Parent(userId: "PAR003"),
    "PAR004": Parent(userId: "PAR004"),
    "PAR005": Parent(userId: "PAR005"),
  };

  final Map<String, List<String>> _enfantsParents = {
    "PAR001": ["ETU2024001", "ETU2024008"],
    "PAR002": ["ETU2024003"],
    "PAR003": ["ETU2024004"],
    "PAR004": ["ETU2024006"],
    "PAR005": ["ETU2024007"],
  };

  final Map<String, String> _etudiants = {
    "ETU2024001": "Medoune Fall - Terminale S1",
    "ETU2024003": "Moussa Ndoye - Première L1",
    "ETU2024004": "Fatou Sarr - Terminale S1",
    "ETU2024006": "Aminata Diallo - Première L1",
    "ETU2024007": "Ousmane Ba - Terminale S2",
    "ETU2024008": "Khadija Camara - Terminale S1",
  };

  String _searchQuery = '';
  String? _selectedStatut;

  @override
  Widget build(BuildContext context) {
    // Filtrage local (à déplacer dans ViewModel)
    List<User> filteredParents = _parents.where((parent) {
      bool matchesSearch = '${parent.prenom} ${parent.nom} ${parent.email}'
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      
      bool matchesStatut = _selectedStatut == null ||
          (_selectedStatut == 'with_children' && _enfantsParents.containsKey(parent.id)) ||
          (_selectedStatut == 'without_children' && !_enfantsParents.containsKey(parent.id));
      
      return matchesSearch && matchesStatut;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final int parentsAvecEnfants = _parents
        .where((p) => _enfantsParents.containsKey(p.id))
        .length;
    
    final int totalEnfants = _enfantsParents.values
        .expand((list) => list)
        .toSet()
        .length;
    
    final double enfantsMoyenne = parentsAvecEnfants > 0
        ? totalEnfants / parentsAvecEnfants
        : 0.0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des parents',
              subtitle: 'Relation famille-école',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  children: [
                    // Statistics
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Parents',
                          value: _parents.length.toString(),
                          icon: Icons.family_restroom,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Avec enfants',
                          value: parentsAvecEnfants.toString(),
                          icon: Icons.people,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Enfants total',
                          value: totalEnfants.toString(),
                          icon: Icons.child_care,
                          color: AppTheme.secondaryColor,
                        ),
                        StatCard(
                          title: 'Moyenne/enfant',
                          value: enfantsMoyenne.toStringAsFixed(1),
                          icon: Icons.calculate,
                          color: AppTheme.infoColor,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Search and Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recherche et filtres',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          // Search Bar
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher un parent...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          _searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Statut',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  DropdownButtonFormField<String?>(
                                    value: _selectedStatut,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    items: [
                                      const DropdownMenuItem(
                                        value: null,
                                        child: Text('Tous les parents'),
                                      ),
                                      const DropdownMenuItem(
                                        value: 'with_children',
                                        child: Text('Avec enfants'),
                                      ),
                                      const DropdownMenuItem(
                                        value: 'without_children',
                                        child: Text('Sans enfants'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedStatut = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Actions',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  SecondaryButton(
                                    text: 'Réinitialiser',
                                    onPressed: () {
                                      setState(() {
                                        _searchQuery = '';
                                        _selectedStatut = null;
                                      });
                                    },
                                    icon: Icons.filter_alt_off,
                                    fullWidth: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Parents List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Parents (${filteredParents.length})',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Nouveau parent',
                                onPressed: () {
                                  // TODO: Ajouter parent
                                },
                                icon: Icons.person_add,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (filteredParents.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'Aucun parent ne correspond aux critères',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            )
                          else
                            ...filteredParents.map((parent) {
                              final enfants = _enfantsParents[parent.id] ?? [];
                              final enfantsDetails = enfants
                                  .map((id) => _etudiants[id] ?? 'Étudiant inconnu')
                                  .toList();
                              
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: Container(
                                    width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                                    height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                                    decoration: BoxDecoration(
                                      color: _getParentColor(parent.id),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getInitials(parent.prenom, parent.nom),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${parent.prenom} ${parent.nom}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      Text(
                                        parent.email,
                                        style: TextStyle(
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                        ),
                                      ),
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      if (enfants.isNotEmpty)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${enfants.length} enfant(s)',
                                              style: TextStyle(
                                                color: AppTheme.textSecondary,
                                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                              ),
                                            ),
                                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                            ...enfantsDetails.take(2).map((enfant) {
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                                child: Text(
                                                  '• $enfant',
                                                  style: TextStyle(
                                                    color: AppTheme.textSecondary,
                                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              );
                                            }).toList(),
                                            if (enfants.length > 2)
                                              Text(
                                                '• +${enfants.length - 2} autre(s)',
                                                style: TextStyle(
                                                  color: AppTheme.textSecondary,
                                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                          ],
                                        )
                                      else
                                        Text(
                                          'Aucun enfant lié',
                                          style: TextStyle(
                                            color: AppTheme.textSecondary.withOpacity(0.7),
                                            fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.message,
                                            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                        onPressed: () {
                                          // TODO: Contacter parent
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                        onPressed: () {
                                          // TODO: Éditer parent
                                        },
                                        color: AppTheme.accentColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // TODO: Voir détails parent
                                  },
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Children Distribution
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Répartition des enfants',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '$parentsAvecEnfants',
                                    style: TextStyle(
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.statValueFontSize),
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  Text(
                                    'Parents avec enfants',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${_parents.length - parentsAvecEnfants}',
                                    style: TextStyle(
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.statValueFontSize),
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  Text(
                                    'Parents sans enfants',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          LinearProgressIndicator(
                            value: parentsAvecEnfants / _parents.length,
                            backgroundColor: AppTheme.backgroundColor,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Communication Tools
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Outils de communication',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              _buildCommunicationTool(
                                icon: Icons.notifications,
                                title: 'Notifications',
                                description: 'Envoyer des alertes',
                                onTap: () {
                                  // TODO: Envoyer notifications
                                },
                              ),
                              _buildCommunicationTool(
                                icon: Icons.email,
                                title: 'Email groupé',
                                description: 'Contacter plusieurs parents',
                                onTap: () {
                                  // TODO: Envoyer email groupé
                                },
                              ),
                              _buildCommunicationTool(
                                icon: Icons.message,
                                title: 'SMS',
                                description: 'Messages texte',
                                onTap: () {
                                  // TODO: Envoyer SMS
                                },
                              ),
                              _buildCommunicationTool(
                                icon: Icons.download,
                                title: 'Liste contacts',
                                description: 'Exporter les contacts',
                                onTap: () {
                                  // TODO: Exporter contacts
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Management Buttons
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        SecondaryButton(
                          text: 'Lier des enfants',
                          onPressed: () {
                            // TODO: Lier enfants
                          },
                          icon: Icons.link,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Envoyer bulletins',
                          onPressed: () {
                            // TODO: Envoyer bulletins
                          },
                          icon: Icons.send,
                          fullWidth: true,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    SecondaryButton(
                      text: 'Générer rapport parental',
                      onPressed: () {
                        // TODO: Générer rapport
                      },
                      icon: Icons.description,
                      fullWidth: true,
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String prenom, String nom) {
    String initials = "";
    if (prenom.isNotEmpty) initials += prenom[0];
    if (nom.isNotEmpty) initials += nom[0];
    return initials;
  }

  Color _getParentColor(String id) {
    final hash = id.hashCode;
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
      Colors.purple,
    ];
    return colors[hash.abs() % colors.length];
  }

  Widget _buildCommunicationTool({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
          child: Row(
            children: [
              Container(
                width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
                height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
              ),
              SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

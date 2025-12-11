import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/etudiant_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import '../models/etudiant_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Etudiant> etudiants = [
      Etudiant(
        id: "1",
        nom: "Fall",
        prenom: "Medoune",
        matricule: "ETU2024001",
        classeId: "CLS001",
        parentId: "PAR001",
      ),
      Etudiant(
        id: "2",
        nom: "Diop",
        prenom: "Awa",
        matricule: "ETU2024002",
        classeId: "CLS001",
        parentId: null,
      ),
      Etudiant(
        id: "3",
        nom: "Ndoye",
        prenom: "Moussa",
        matricule: "ETU2024003",
        classeId: "CLS002",
        parentId: "PAR002",
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

    final Map<String, String> classes = {
      "CLS001": "Terminale S",
      "CLS002": "Première L",
      "CLS003": "Seconde G",
    };

    // Calcul des statistiques
    final int totalEtudiants = etudiants.length;
    final int etudiantsAvecParent = etudiants.where((e) => e.parentId != null).length;
    final int classesDifferentes = classes.length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Tableau de bord',
              subtitle: 'Gestion scolaire en un clic',
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statistiques
                    Text(
                      'Aperçu général',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Étudiants',
                            value: totalEtudiants.toString(),
                            icon: Icons.group,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Avec parent',
                            value: etudiantsAvecParent.toString(),
                            icon: Icons.family_restroom,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Classes',
                      value: classesDifferentes.toString(),
                      icon: Icons.class_,
                      color: AppTheme.secondaryColor,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Header de la liste
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Étudiants récents',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        PrimaryButton(
                          text: 'Ajouter',
                          onPressed: () {
                            print("Bouton d'ajout d'étudiant cliqué");
                          },
                          icon: Icons.person_add,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      '$totalEtudiants étudiants inscrits',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Liste des étudiants
                    ...etudiants.map((etudiant) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EtudiantCard(
                          etudiant: etudiant,
                          nomClasse: classes[etudiant.classeId],
                          onTap: () {
                            print("Navigation vers le détail de ${etudiant.prenom} ${etudiant.nom}");
                            // Navigator.pushNamed(context, '/etudiant-detail', arguments: etudiant);
                          },
                        ),
                      );
                    }).toList(),
                    
                    const SizedBox(height: 32),
                    
                    // Section d'actions rapides
                    Text(
                      'Actions rapides',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildActionCard(
                          context,
                          icon: Icons.assignment,
                          title: 'Notes',
                          color: AppTheme.primaryColor,
                          onTap: () {
                            print('Ouvrir les notes');
                          },
                        ),
                        _buildActionCard(
                          context,
                          icon: Icons.calendar_today,
                          title: 'Emploi du temps',
                          color: AppTheme.accentColor,
                          onTap: () {
                            print('Ouvrir emploi du temps');
                          },
                        ),
                        _buildActionCard(
                          context,
                          icon: Icons.assessment,
                          title: 'Bulletins',
                          color: AppTheme.secondaryColor,
                          onTap: () {
                            print('Ouvrir les bulletins');
                          },
                        ),
                        _buildActionCard(
                          context,
                          icon: Icons.notifications,
                          title: 'Notifications',
                          color: AppTheme.warningColor,
                          onTap: () {
                            print('Ouvrir les notifications');
                          },
                        ),
                      ],
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

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
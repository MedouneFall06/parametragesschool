import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  String _selectedPeriod = 'month'; // 'week', 'month', 'quarter', 'year'
  String _selectedView = 'overview'; // 'overview', 'income', 'expenses', 'invoices'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Finances',
              subtitle: 'Gestion financière de l\'établissement',
              trailing: PrimaryButton(
                text: 'Nouvelle transaction',
                onPressed: () {
                  // TODO: Ajouter transaction
                },
                fullWidth: false,
                icon: Icons.add,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter FinanceViewModel
                    // TODO: Connecter à l'API finances
                    
                    // Period Selection
                    InfoCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildPeriodButton('Semaine', 'week'),
                              const SizedBox(width: 8),
                              _buildPeriodButton('Mois', 'month'),
                              const SizedBox(width: 8),
                              _buildPeriodButton('Trimestre', 'quarter'),
                              const SizedBox(width: 8),
                              _buildPeriodButton('Année', 'year'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildViewButton('Vue d\'ensemble', 'overview'),
                              const SizedBox(width: 8),
                              _buildViewButton('Revenus', 'income'),
                              const SizedBox(width: 8),
                              _buildViewButton('Dépenses', 'expenses'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Financial Summary
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Résumé financier',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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
                            childAspectRatio: 1.2,
                            children: [
                              _buildFinancialCard(
                                label: 'Revenus totaux',
                                value: '€12,450',
                                change: '+8% vs période précédente',
                                color: AppTheme.successColor,
                                icon: Icons.trending_up,
                              ),
                              _buildFinancialCard(
                                label: 'Dépenses totales',
                                value: '€8,230',
                                change: '+5% vs période précédente',
                                color: AppTheme.errorColor,
                                icon: Icons.trending_down,
                              ),
                              _buildFinancialCard(
                                label: 'Bénéfice net',
                                value: '€4,220',
                                change: '+12% vs période précédente',
                                color: AppTheme.accentColor,
                                icon: Icons.attach_money,
                              ),
                              _buildFinancialCard(
                                label: 'Trésorerie',
                                value: '€25,800',
                                change: 'Solde actuel',
                                color: AppTheme.primaryColor,
                                icon: Icons.account_balance,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Income vs Expenses Chart
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Revenus vs Dépenses',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bar_chart, size: 50, color: Colors.grey),
                                  SizedBox(height: 12),
                                  Text(
                                    'Graphique financier',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Les données s\'afficheront ici',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Recent Transactions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Transactions récentes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SecondaryButton(
                                text: 'Voir tout',
                                onPressed: () {
                                  // TODO: Voir toutes les transactions
                                },
                                fullWidth: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildTransactionItem(
                            description: 'Frais de scolarité - Martin Lucas',
                            amount: '€450',
                            date: '15 Janv 2024',
                            type: 'income',
                            category: 'Scolarité',
                          ),
                          const Divider(),
                          _buildTransactionItem(
                            description: 'Achat matériel pédagogique',
                            amount: '€1,200',
                            date: '14 Janv 2024',
                            type: 'expense',
                            category: 'Matériel',
                          ),
                          const Divider(),
                          _buildTransactionItem(
                            description: 'Cantine - École élémentaire',
                            amount: '€850',
                            date: '12 Janv 2024',
                            type: 'income',
                            category: 'Cantine',
                          ),
                          const Divider(),
                          _buildTransactionItem(
                            description: 'Salaires enseignants',
                            amount: '€3,500',
                            date: '10 Janv 2024',
                            type: 'expense',
                            category: 'Salaires',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Invoices
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Factures en attente',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.warningColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '3 en retard',
                                  style: TextStyle(
                                    color: AppTheme.warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInvoiceItem(
                            number: 'FAC-2024-001',
                            client: 'Famille Martin',
                            amount: '€450',
                            dueDate: '15 Janv 2024',
                            status: 'overdue',
                          ),
                          const Divider(),
                          _buildInvoiceItem(
                            number: 'FAC-2024-002',
                            client: 'Famille Bernard',
                            amount: '€450',
                            dueDate: '20 Janv 2024',
                            status: 'pending',
                          ),
                          const Divider(),
                          _buildInvoiceItem(
                            number: 'FAC-2024-003',
                            client: 'Famille Leroy',
                            amount: '€380',
                            dueDate: '25 Janv 2024',
                            status: 'pending',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Expense Categories
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Catégories de dépenses',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildExpenseCategory(
                            label: 'Salaires',
                            amount: '€3,500',
                            percentage: 42,
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(height: 12),
                          _buildExpenseCategory(
                            label: 'Matériel',
                            amount: '€1,200',
                            percentage: 15,
                            color: AppTheme.accentColor,
                          ),
                          const SizedBox(height: 12),
                          _buildExpenseCategory(
                            label: 'Maintenance',
                            amount: '€800',
                            percentage: 10,
                            color: AppTheme.secondaryColor,
                          ),
                          const SizedBox(height: 12),
                          _buildExpenseCategory(
                            label: 'Autres',
                            amount: '€2,730',
                            percentage: 33,
                            color: AppTheme.warningColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Financial Reports
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Exporter rapport',
                            onPressed: () {
                              // TODO: Exporter rapport
                            },
                            icon: Icons.download,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Générer bilan',
                            onPressed: () {
                              // TODO: Générer bilan
                            },
                            icon: Icons.assessment,
                          ),
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

  Widget _buildPeriodButton(String label, String period) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedPeriod == period,
      onSelected: (selected) {
        setState(() {
          _selectedPeriod = period;
        });
      },
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: _selectedPeriod == period ? Colors.white : AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildViewButton(String label, String view) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedView == view,
      onSelected: (selected) {
        setState(() {
          _selectedView = view;
        });
      },
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: _selectedView == view ? Colors.white : AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildFinancialCard({
    required String label,
    required String value,
    required String change,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String description,
    required String amount,
    required String date,
    required String type,
    required String category,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: type == 'income' 
              ? AppTheme.successColor.withOpacity(0.1)
              : AppTheme.errorColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          type == 'income' ? Icons.arrow_upward : Icons.arrow_downward,
          color: type == 'income' ? AppTheme.successColor : AppTheme.errorColor,
        ),
      ),
      title: Text(description),
      subtitle: Text('$date • $category'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: type == 'income' ? AppTheme.successColor : AppTheme.errorColor,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: type == 'income' 
                  ? AppTheme.successColor.withOpacity(0.1)
                  : AppTheme.errorColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type == 'income' ? 'Revenu' : 'Dépense',
              style: TextStyle(
                fontSize: 10,
                color: type == 'income' ? AppTheme.successColor : AppTheme.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem({
    required String number,
    required String client,
    required String amount,
    required String dueDate,
    required String status,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getInvoiceStatusColor(status).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.receipt,
          color: _getInvoiceStatusColor(status),
        ),
      ),
      title: Text(number),
      subtitle: Text('$client • Échéance: $dueDate'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getInvoiceStatusColor(status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _getInvoiceStatusLabel(status),
              style: TextStyle(
                fontSize: 12,
                color: _getInvoiceStatusColor(status),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCategory({
    required String label,
    required String amount,
    required int percentage,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 8,
              width: MediaQuery.of(context).size.width * (percentage / 100) * 0.8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage% du total',
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getInvoiceStatusColor(String status) {
    switch (status) {
      case 'paid':
        return AppTheme.successColor;
      case 'pending':
        return AppTheme.warningColor;
      case 'overdue':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getInvoiceStatusLabel(String status) {
    switch (status) {
      case 'paid':
        return 'Payée';
      case 'pending':
        return 'En attente';
      case 'overdue':
        return 'En retard';
      default:
        return status;
    }
  }
}
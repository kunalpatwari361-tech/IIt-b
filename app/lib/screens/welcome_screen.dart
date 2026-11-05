import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../policy.dart';
import '../state.dart';
import '../widgets/common.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final text = Theme.of(context).textTheme;
    Widget product(Product p, IconData icon, String title, String sub) {
      final selected = state.product == p;
      return Card(
        elevation: 0,
        color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor),
        ),
        child: ListTile(
          key: Key('product-${p.name}'),
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(sub),
          trailing: selected ? const Icon(Icons.check_circle) : null,
          onTap: () => state.setProduct(p),
        ),
      );
    }

    Widget persona(String phone, String label, Product p) => ListTile(
          key: Key('persona-$phone'),
          dense: true,
          leading: const Icon(Icons.person_outline),
          title: Text(label),
          subtitle: Text(phone),
          onTap: () {
            state.setProduct(p);
            state.update(() => state.phone = phone);
            Navigator.pushNamed(context, '/sign-in');
          },
        );

    return StepScaffold(
      title: t.appTitle,
      buttonLabel: t.startApplication,
      onPressed: () => Navigator.pushNamed(context, '/sign-in'),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8),
        Text(t.welcomeHeadline, style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(t.welcomeBody, style: text.bodyLarge),
        const SizedBox(height: 24),
        Text(t.chooseProduct, style: text.titleMedium),
        const SizedBox(height: 8),
        product(Product.homeLoan, Icons.home_outlined, t.productHomeLoan, t.productHomeLoanSub),
        product(Product.lap, Icons.account_balance_outlined, t.productLap, t.productLapSub),
        const SizedBox(height: 24),
        Text(t.demoCustomers, style: text.titleMedium),
        Text(t.demoCustomersBody, style: text.bodySmall),
        persona('9876500001', t.personaRavi, Product.homeLoan),
        persona('9876500002', t.personaMeena, Product.lap),
        persona('9876500003', t.personaArjun, Product.homeLoan),
      ]),
    );
  }
}

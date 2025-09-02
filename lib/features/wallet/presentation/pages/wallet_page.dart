import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/error_widget.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../providers/wallet_providers.dart';
import '../state/wallet_state.dart';
import '../widgets/create_wallet_dialog.dart';
import '../widgets/wallet_card.dart';

/// Main wallet page
class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(walletNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: _buildBody(context, ref, walletState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateWalletDialog(context, ref),
        tooltip: 'Create Wallet',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, WalletState state) {
    return switch (state) {
      WalletInitial() ||
      WalletLoading() => const AppLoadingWidget(message: 'Loading wallets...'),
      WalletCreating() => const AppLoadingWidget(message: 'Creating wallet...'),
      WalletError(:final message) => AppErrorWidget(
        message: message,
        onRetry: () => ref.read(walletNotifierProvider.notifier).refresh(),
      ),
      WalletLoaded(:final wallets) => _buildWalletsList(context, ref, wallets),
      WalletCreated() => const AppLoadingWidget(
        message: 'Wallet created successfully!',
      ),
      WalletDeleting() => const AppLoadingWidget(message: 'Deleting wallet...'),
      WalletDeleted() => const AppLoadingWidget(
        message: 'Wallet deleted successfully!',
      ),
      _ => AppErrorWidget(
        message: 'Unknown state',
        onRetry: () => ref.read(walletNotifierProvider.notifier).refresh(),
      ),
    };
  }

  Widget _buildWalletsList(BuildContext context, WidgetRef ref, List wallets) {
    if (wallets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No wallets yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first wallet to get started',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showCreateWalletDialog(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Create Wallet'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(walletNotifierProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          final wallet = wallets[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: WalletCard(
              wallet: wallet,
              onDelete: () => _showDeleteConfirmation(context, ref, wallet),
            ),
          );
        },
      ),
    );
  }

  void _showCreateWalletDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => CreateWalletDialog(
        onCreateWallet: (name, initialBalance) {
          ref
              .read(walletNotifierProvider.notifier)
              .createNewWallet(name: name, initialBalance: initialBalance);
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, wallet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Wallet'),
        content: Text(
          'Are you sure you want to delete "${wallet.name.value}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(walletNotifierProvider.notifier).removeWallet(wallet.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

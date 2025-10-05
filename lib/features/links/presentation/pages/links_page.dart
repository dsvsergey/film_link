import 'package:film_link/core/router/app_router.dart';
import 'package:film_link/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:film_link/features/links/presentation/providers/links_state_provider.dart';
import 'package:film_link/features/links/presentation/widgets/link_item.dart';
import 'package:film_link/features/links/presentation/widgets/add_link_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LinksPage extends ConsumerStatefulWidget {
  const LinksPage({super.key});

  @override
  ConsumerState<LinksPage> createState() => _LinksPageState();
}

class _LinksPageState extends ConsumerState<LinksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Load links on init
    Future.microtask(() {
      ref.read(linksStateProvider.notifier).loadLinks();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showAddLinkDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddLinkDialog(),
    );
  }

  void _handleSignOut() async {
    await ref.read(authStateProvider.notifier).signOut();
    if (mounted) {
      context.go(AppRoutes.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final linksState = ref.watch(linksStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FilmLink'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
            tooltip: 'Sign Out',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  onChanged: (value) {
                    // TODO: Implement search
                  },
                ),
              ),
              
              // Tabs
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Links'),
                  Tab(text: 'Archive'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Links tab
          _buildLinksView(linksState),
          
          // Archive tab
          _buildArchiveView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLinkDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLinksView(LinksState state) {
    return state.when(
      initial: () => const Center(child: Text('Loading...')),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (links) {
        if (links.isEmpty) {
          return const Center(
            child: Text('No links yet. Add your first link!'),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(linksStateProvider.notifier).loadLinks();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: links.length,
            itemBuilder: (context, index) {
              return LinkItem(link: links[index]);
            },
          ),
        );
      },
      error: (message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $message'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(linksStateProvider.notifier).loadLinks();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArchiveView() {
    return const Center(
      child: Text('Archive - Coming soon'),
    );
  }
}

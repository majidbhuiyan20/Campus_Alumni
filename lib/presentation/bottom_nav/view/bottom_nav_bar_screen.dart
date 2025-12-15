import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/view/home_screen.dart';
import '../../notes/view/note_screen.dart';
import '../../routine/view/routine_screen.dart';
import '../../tools/view/tools_screen.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';

class BottomNavBarScreen extends ConsumerStatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  ConsumerState<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends ConsumerState<BottomNavBarScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  int _lastIndex = 0;

  // Screen list with separate screen widgets
  final List<Widget> _screenList = [
    HomeScreen(),
    RoutineScreen(),
    NoteScreen(),
    ToolsScreen(),
  ];

  // Navigation items with colors
  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
      color: Colors.blue.shade800,
    ),
    NavItem(
      icon: Icons.schedule_outlined,
      activeIcon: Icons.schedule,
      label: 'Routine',
      color: Colors.blue.shade800,
    ),
    NavItem(
      icon: Icons.note_outlined,
      activeIcon: Icons.note,
      label: 'Note',
      color: Colors.blue.shade800,
    ),
    NavItem(
      icon: Icons.build_outlined,
      activeIcon: Icons.build,
      label: 'Tools',
      color: Colors.blue.shade800,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    // Don't animate if tapping the same item
    if (index != ref.watch(bottomNavBarProvider)) {
      setState(() {
        _lastIndex = ref.watch(bottomNavBarProvider);
      });

      // Start animation
      _scaleController.reset();
      _scaleController.forward();

      // Change screen
      ref.read(bottomNavBarProvider.notifier).onItemTapped(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavBarProvider);

    return Scaffold(
      body: ScaleTransition(
        scale: _scaleAnimation,
        child: _screenList[currentIndex],
      ),
      bottomNavigationBar: _buildAnimatedNavBar(currentIndex),
    );
  }

  Widget _buildAnimatedNavBar(int currentIndex) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isActive = currentIndex == index;

              return _buildNavItem(
                item: item,
                index: index,
                isActive: isActive,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required NavItem item,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isActive
              ? LinearGradient(
            colors: [
              item.color.withOpacity(0.2),
              item.color.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with animation
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Icon(
                isActive ? item.activeIcon : item.icon,
                key: ValueKey<bool>(isActive),
                color: isActive ? item.color : Colors.grey.shade600,
                size: isActive ? 24 : 22,
              ),
            ),
            const SizedBox(height: 4),

            // Label with animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isActive ? 20 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isActive ? 1 : 0,
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: item.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation item data class
class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Color color;

  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.color,
  });
}

// Version 2: Floating Navigation Bar with Bubble Effect
class FloatingNavBarScreen extends ConsumerStatefulWidget {
  const FloatingNavBarScreen({super.key});

  @override
  ConsumerState<FloatingNavBarScreen> createState() => _FloatingNavBarScreenState();
}

class _FloatingNavBarScreenState extends ConsumerState<FloatingNavBarScreen> {
  final List<Widget> _screenList = [
    HomeScreen(),
    RoutineScreen(),
    NoteScreen(),
    ToolsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavBarProvider);

    return Scaffold(
      extendBody: true, // Important for floating nav bar
      body: _screenList[currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 25,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(bottomNavBarProvider.notifier).onItemTapped(index);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: [
            BottomNavigationBarItem(
              icon: _AnimatedNavIcon(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                isActive: currentIndex == 0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _AnimatedNavIcon(
                icon: Icons.schedule_outlined,
                activeIcon: Icons.schedule,
                isActive: currentIndex == 1,
              ),
              label: 'Routine',
            ),
            BottomNavigationBarItem(
              icon: _AnimatedNavIcon(
                icon: Icons.note_outlined,
                activeIcon: Icons.note,
                isActive: currentIndex == 2,
              ),
              label: 'Note',
            ),
            BottomNavigationBarItem(
              icon: _AnimatedNavIcon(
                icon: Icons.build_outlined,
                activeIcon: Icons.build,
                isActive: currentIndex == 3,
              ),
              label: 'Tools',
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedNavIcon extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;

  const _AnimatedNavIcon({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Icon(
          isActive ? activeIcon : icon,
          key: ValueKey<bool>(isActive),
          size: 24,
          color: isActive ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

// Version 3: Minimal Navigation Bar with Indicator
class MinimalNavBarScreen extends ConsumerWidget {
  const MinimalNavBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavBarProvider);
    final screens = [
      HomeScreen(),
      RoutineScreen(),
      NoteScreen(),
      ToolsScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: Row(
          children: [
            _buildNavItem(
              context: context,
              index: 0,
              icon: Icons.home,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () => ref.read(bottomNavBarProvider.notifier).onItemTapped(0),
            ),
            _buildNavItem(
              context: context,
              index: 1,
              icon: Icons.schedule,
              label: 'Routine',
              isActive: currentIndex == 1,
              onTap: () => ref.read(bottomNavBarProvider.notifier).onItemTapped(1),
            ),
            _buildNavItem(
              context: context,
              index: 2,
              icon: Icons.note,
              label: 'Note',
              isActive: currentIndex == 2,
              onTap: () => ref.read(bottomNavBarProvider.notifier).onItemTapped(2),
            ),
            _buildNavItem(
              context: context,
              index: 3,
              icon: Icons.build,
              label: 'Tools',
              isActive: currentIndex == 3,
              onTap: () => ref.read(bottomNavBarProvider.notifier).onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 24 : 22,
                height: isActive ? 24 : 22,
                child: Icon(
                  icon,
                  color: isActive ? Colors.blue : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isActive ? 3 : 0,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
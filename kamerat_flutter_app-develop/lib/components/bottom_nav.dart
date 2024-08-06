import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function onTabChanged;

  const BottomNavBar({super.key, required this.onTabChanged});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  Widget _buildTabItem({
    required String asset,
    required String text,
    required bool isSelected,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        final newIndex = widget.onTabChanged(index);
        setState(() {
          currentIndex = newIndex;
        });
      },
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)
            : const EdgeInsets.all(0),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color.fromRGBO(231, 245, 236, 1),
                borderRadius: BorderRadius.circular(100.0),
              )
            : null,
        child: Row(
          children: [
            Image.asset(asset),
            const SizedBox(width: 8.0),
            if (isSelected)
              Text(text,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        height: 64.0,
        clipBehavior: Clip.none,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabItem(
              asset: currentIndex == 0
                  ? "assets/icons/home_fill.png"
                  : "assets/icons/home.png",
              text: "Heim",
              isSelected: currentIndex == 0,
              index: 0,
            ),
            _buildTabItem(
              asset: currentIndex == 1
                  ? "assets/icons/search_fill.png"
                  : "assets/icons/search.png",
              text: "Erkunden",
              isSelected: currentIndex == 1,
              index: 1,
            ),
            _buildTabItem(
              asset: currentIndex == 2
                  ? "assets/icons/learning_fill.png"
                  : "assets/icons/learning.png",
              text: "Lernen",
              isSelected: currentIndex == 2,
              index: 2,
            ),
            _buildTabItem(
              asset: currentIndex == 3
                  ? "assets/icons/heart_fill.png"
                  : "assets/icons/heart.png",
              text: "Likes",
              isSelected: currentIndex == 3,
              index: 3,
            ),
            _buildTabItem(
              asset: currentIndex == 4
                  ? "assets/icons/profile_fill.png"
                  : "assets/icons/profile.png",
              text: "Profil",
              isSelected: currentIndex == 4,
              index: 4,
            ),
          ],
        ));
  }
}

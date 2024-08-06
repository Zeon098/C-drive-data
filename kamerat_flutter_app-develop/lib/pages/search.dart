import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/search_overlay.controller.dart';
import 'package:kamerat_flutter_app/controllers/search.controller.dart';
import 'package:kamerat_flutter_app/components/courses.dart';

class Search extends GetView<MySearchController> {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    MySearchController controller = Get.put(MySearchController());
    return FutureBuilder(
        future: controller.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Error fetching courses. Try again later."));
          }
          return Stack(
            children: [
              Positioned(
                top: 80.0,
                right: 0,
                left: 0,
                bottom: 0,
                child: RefreshIndicator(
                  onRefresh: controller.onRefresh,
                  child: ListView.builder(
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              category.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Obx(
                              () => Courses(
                                refreshCount: controller.refreshCount.value,
                                categoryId: category.id,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Obx(
                () => controller.searchOverlayController.isFocused.value
                    ? Container()
                    : SearchBar(controller: controller),
              ),
            ],
          );
        });
  }
}

class SearchBar extends StatelessWidget {
  final MySearchController controller;
  const SearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.searchOverlayController.isFocused.value = true;
            Overlay.of(context)
                .insert(controller.searchOverlayController.overlayEntry);
            controller.searchOverlayController.searchNode.requestFocus();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 25,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Row(children: [
              Image.asset(
                "assets/icons/search.png",
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Suchen Sie hier nach Kursen...",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class SearchBarPopUp extends StatelessWidget {
  final SearchOverlayController controller;
  const SearchBarPopUp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: controller.reset,
            child: Container(
              color: Colors.black45,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          top: 80,
          right: 0,
          left: 0,
          bottom: 100,
          child: GestureDetector(
            onTap: controller.reset,
            child: Card(
              color: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Column(
                children: [
                  TextField(
                    focusNode: controller.searchNode,
                    autofocus: true,
                    controller: controller.searchFieldController,
                    onChanged: (query) {
                      controller.searchQuery.value = query;
                      debounce(
                        controller.searchQuery,
                        controller.search,
                        time: const Duration(milliseconds: 300),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Suchen Sie hier nach Kursen...",
                      prefixIcon: Image.asset(
                        "assets/icons/search.png",
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: controller.reset,
                        icon: const Icon(Icons.close,
                            color: Color.fromRGBO(106, 110, 106, 1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.hasResults
                        ? const SizedBox(height: 8.0)
                        : const SizedBox.shrink(),
                  ),
                  Obx(() {
                    if (controller.hasResults &&
                        !controller.isSearching.value) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ListView(children: controller.results),
                        ),
                      );
                    } else if (controller.isSearching.value) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/course_catalogue.controller.dart';
import 'package:kamerat_flutter_app/components/course_tile.dart';
import 'package:kamerat_flutter_app/models/category.model.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';

class CourseCatalogue extends GetView<CourseCatalogueController> {
  const CourseCatalogue({super.key});

  String get title =>
      Get.arguments['type'] == 'free' ? 'Freier Bereich' : 'Bezahlt';

  @override
  Widget build(BuildContext context) {
    CourseCatalogueController controller =
        Get.find<CourseCatalogueController>();
    return Scaffold(
      appBar: MyAppBar(title: title),
      body: Column(
        children: [
          Container(
            height: 36.0,
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: PagedListView(
                scrollDirection: Axis.horizontal,
                pagingController: controller.categoriesPagingController,
                builderDelegate: PagedChildBuilderDelegate<CategoryModel>(
                  itemBuilder: (context, category, index) {
                    return CategoryToggleButton(
                      category: category,
                      onSelectedToggle: (bool isSelected, String categoryId) {
                        isSelected
                            ? controller.selectedCategoryIds.add(categoryId)
                            : controller.selectedCategoryIds.remove(categoryId);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PagedListView(
                pagingController: controller.coursesPagingController,
                builderDelegate: PagedChildBuilderDelegate<CourseModel>(
                  itemBuilder: (context, course, index) {
                    return CourseTile(course: course);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryToggleButton extends StatefulWidget {
  final CategoryModel category;
  final Function onSelectedToggle;

  const CategoryToggleButton({
    super.key,
    required this.category,
    required this.onSelectedToggle,
  });

  @override
  State<CategoryToggleButton> createState() => _CategoryToggleButtonState();
}

class _CategoryToggleButtonState extends State<CategoryToggleButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
          });
          widget.onSelectedToggle(_isSelected, widget.category.id);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: _isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            border: _isSelected
                ? null
                : Border.all(
                    width: 1.0,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Text(
            widget.category.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: _isSelected
                      ? Colors.white
                      : const Color.fromRGBO(178, 196, 185, 1),
                ),
          ),
        ),
      ),
    );
  }
}

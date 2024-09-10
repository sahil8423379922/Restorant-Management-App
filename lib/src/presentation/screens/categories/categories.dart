import 'package:flutter/material.dart';
import 'package:resturant_side/src/extensions/heighextension.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/paadings.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/screens/categories/categoreiwidgets/categorietile.dart';
import 'package:resturant_side/src/presentation/screens/categories/categoriesmodel.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CategoriesModel model = CategoriesModel();
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: MasterButton(
            onTap: () {
              Navigator.pop(context);
            },
            tittle: 'Save'),
      ),
      appBar: buildAppBar(context, tittle: 'Categories'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: KPadding.kp24),
        child: ListView(
          children: [
            SpaceUtils.ks24.height(),
            MasterTextField(
              controller: _controller,
              onSubmitted: (String name) {
                if (name.length > 3) {
                  model.value.add(name);
                  _controller.text = '';
                  setState(() {});
                }
              },
              tittle: 'Add New Category',
              hint: 'Lunch',
            ),
            SpaceUtils.ks24.height(),
            Text(
              'Saved Categories',
              style:
                  FontStyleUtilities.h6(context: context, fontWeight: FWT.bold),
            ),
            SpaceUtils.ks16.height(),
            ValueListenableBuilder(
              valueListenable: model.notifier,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.length,
                    itemBuilder: (context, i) => CategoriesTile(
                          nameOfCategory: value[i],
                          onTap: () {
                            value.removeAt(i);
                            setState(() {});
                          },
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

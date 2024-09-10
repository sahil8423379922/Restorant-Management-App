import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/paadings.dart';
import 'package:resturant_side/src/presentation/screens/categories/categories.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/dropdownbox.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/presentation/widgets/mastertextfield.dart';
import 'package:resturant_side/src/presentation/widgets/timetoggle.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

import 'additemcompo/imagepicker.dart';
import 'additemcompo/vegnonveg.dart';
import 'expandabletoggle.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  Set<String> categories = {'Select', 'Lunch', 'Dinner', 'BreakFast'};
  String selctted = 'Select';
  File image = File('');

  Future dialogBox(BuildContext context) async {
    var size2 = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return image.path != ''
              ? Hero(
                  tag: image.path,
                  child: Container(
                    width: size2.width / 1.3,
                    height: size2.height / 1.4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        )),
                    alignment: Alignment.center,
                  ),
                )
              : const SizedBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
        child: MasterButton(
            onTap: () {
              Navigator.pop(context);
            },
            tittle: 'Save'),
      ),
      appBar: buildAppBar(context, tittle: 'Upload an Item'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: KPadding.kp24),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SpaceUtils.ks24.height(),
            const MasterTextField(tittle: 'Item Name'),
            SpaceUtils.ks24.height(),
            Row(
              children: [
                const Expanded(
                  child: MasterTextField(tittle: 'Item Code'),
                ),
                SpaceUtils.ks18.width(),
                const Expanded(
                  child: MasterTextField(tittle: 'Item No.'),
                ),
              ],
            ),
            SpaceUtils.ks24.height(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose Category',
                    style: FontStyleUtilities.h6(
                        context: context, fontWeight: FWT.semiBold)),
                SpaceUtils.ks10.height(),
                Row(
                  children: [
                    Expanded(
                      child: DropDownBox(
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorUtils.kcBlueButton, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          width: double.infinity,
                          item: const ['Lunch', 'BreakFast', 'Dinner'],
                          value: (va) {}),
                    ),
                    SpaceUtils.ks10.width(),
                    GestureDetector(
                      onTap: () {
                        navigateToPage(context, page: const Categories());
                      },
                      child: const CircleAvatar(
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                )
              ],
            ),
            SpaceUtils.ks24.height(),
            const MasterTextField(
              tittle: 'Item Description',
              height: 48 * 3,
              maxLines: 5,
            ),
            SpaceUtils.ks18.height(),
            Text(
              'Upload Image',
              style: FontStyleUtilities.h6(
                  context: context, fontWeight: FWT.semiBold),
            ),
            image.path != ''
                ? GestureDetector(
                    onTap: () async {
                      await dialogBox(context);
                    },
                    child: Hero(
                      tag: image.path,
                      child: Container(
                        width: size2.width,
                        height: size2.height * 0.150,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.cover,
                            )),
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                : const SizedBox(),
            Text(
              'Upload landscape image with 1 mb size.',
              style: FontStyleUtilities.p2(
                  context: context, fontWeight: FWT.semiBold),
            ),
            SpaceUtils.ks16.height(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceUtils.ks10.width(),
                MyImagePicker(
                  onImageSelected: (value) {
                    image = value;
                    setState(() {});
                  },
                  uploadType: ImageSource.gallery,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.image,
                        color: ColorUtils.kcPrimary,
                        size: 35,
                      ),
                      Text(
                        'Gallery',
                        style: FontStyleUtilities.t3(
                          context: context,
                          fontWeight: FWT.semiBold,
                        ),
                      )
                    ],
                  ),
                ),
                SpaceUtils.ks10.width(),
                MyImagePicker(
                  onImageSelected: (value) {
                    image = value;
                    setState(() {});
                  },
                  uploadType: ImageSource.camera,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.camera_enhance_outlined,
                        color: ColorUtils.kcPrimary,
                        size: 35,
                      ),
                      Text(
                        'Camera',
                        style: FontStyleUtilities.t3(
                          context: context,
                          fontWeight: FWT.semiBold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // SpaceUtils.ks30.height(),
            ExpandableToggleTile(
                initialValue: false,
                onChanged: () {},
                name: 'Size Customization',
                child: const TheExpandableWidget(
                  name: 'Set the size customization count',
                )),
            ExpandableToggleTile(
                initialValue: false,
                name: 'Choice Options',
                child: const TheExpandableWidget(
                  name: 'Choice Limit UpTO',
                ),
                onChanged: () {}),
            ExpandableToggleTile(
                initialValue: false,
                name: 'Add Ons',
                child: const TheExpandableWidget(
                  name: 'Number of Add Ons',
                ),
                onChanged: () {}),
            ExpandableToggleTile(
                initialValue: false,
                name: 'Assign Label',
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                            child: DropDownBox(
                                width: double.infinity,
                                item: const [
                                  'Must Try',
                                  'Something New',
                                  'Some Spicy',
                                  'Amazing'
                                ],
                                value: (v) {})),
                        SpaceUtils.ks30.width(),
                        GestureDetector(
                          onTap: () {
                            navigateToPage(context, page: const AddItem());
                          },
                          child: const CircleAvatar(
                              radius: 18,
                              child: Icon(Icons.add),
                              foregroundColor: ColorUtils.kcWhite),
                        )
                      ],
                    ),
                  ],
                ),
                onChanged: () {}),
            TimeToggle(name: 'Set Automatic Time', from: (v) {}, to: (v) {}),
            SpaceUtils.ks18.height(),
            const VegNonVeg(),
            SpaceUtils.ks60.height(),
            Text(
              'Available',
              textAlign: TextAlign.center,
              style: FontStyleUtilities.h4(
                  context: context, fontWeight: FWT.semiBold),
            ),
            SpaceUtils.ks18.height(),
            BigToggleSwitch(onChange: (value) {}),
            SpaceUtils.ks24.height()
          ],
        ),
      ),
    );
  }
}

class TheExpandableWidget extends StatefulWidget {
  const TheExpandableWidget({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  State<TheExpandableWidget> createState() => _TheExpandableWidgetState();
}

class _TheExpandableWidgetState extends State<TheExpandableWidget> {
  void tap(int? index) {
    numbersToAdd = index ?? 1;
    setState(() {});
  }

  int numbersToAdd = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: FontStyleUtilities.t4(context: context, fontWeight: FWT.bold),
        ),
        const SizedBox(height: 6),
        Builder(builder: (context) {
          return DropDownBox(
              width: 80,
              item: const ["1", "2", "3", "4", "5"],
              value: (v) {
                var x = int.parse(v ?? "1");
                tap(x);
              });
        }),
        ...List.generate(
            numbersToAdd, (index) => OptionValueField(index: index)).toList(),
        SpaceUtils.ks7.height(),
        Row(
          children: [
            Text(
              'Add More',
              style:
                  FontStyleUtilities.t4(context: context, fontWeight: FWT.bold),
            ),
            SpaceUtils.ks10.width(),
            GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                  radius: 10,
                  child: Center(
                      child: Icon(
                    Icons.add,
                    size: 18,
                  )),
                  foregroundColor: ColorUtils.kcWhite),
            )
          ],
        ),
        SpaceUtils.ks20.height()
      ],
    );
  }
}

class OptionValueField extends StatelessWidget {
  const OptionValueField({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintStyle: FontStyleUtilities.t1(
                      context: context,
                    ),
                    hintText: 'Option ${index + 1}',
                    border: const UnderlineInputBorder()),
              ),
            )),
            SpaceUtils.ks40.width(),
            Expanded(
                child: SizedBox(
              height: 40,
              child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintStyle: FontStyleUtilities.t1(
                        context: context,
                      ),
                      hintText: '+\$${(index + 1) * 50} USD',
                      border: const UnderlineInputBorder())),
            ))
          ],
        ),
        SpaceUtils.ks16.height()
      ],
    );
  }
}

class AddItemToggleTile extends StatefulWidget {
  const AddItemToggleTile(
      {Key? key, required this.name, required this.onChange})
      : super(key: key);
  final String name;
  final ValueChanged<bool> onChange;

  @override
  State<AddItemToggleTile> createState() => _AddItemToggleTileState();
}

class _AddItemToggleTileState extends State<AddItemToggleTile> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          Text(
            widget.name,
            style:
                FontStyleUtilities.h6(context: context, fontWeight: FWT.bold),
          ),
          const Spacer(),
          SizedBox(
            height: 35,
            width: 30,
            child: Switch(
                activeColor: ColorUtils.kcPrimary,
                value: isSelect,
                onChanged: (val) {
                  isSelect = val;
                  widget.onChange(val);
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }
}

class BigToggleSwitch extends StatefulWidget {
  const BigToggleSwitch(
      {Key? key, required this.onChange, this.initialvalue = false})
      : super(key: key);
  final bool? initialvalue;
  final ValueChanged<bool> onChange;

  @override
  State<BigToggleSwitch> createState() => _BigToggleSwitchState();
}

class _BigToggleSwitchState extends State<BigToggleSwitch> {
  @override
  void initState() {
    isSelect = widget.initialvalue!;
    super.initState();
  }

  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        value: isSelect,
        onChanged: (val) {
          isSelect = val;
          widget.onChange(val);
          setState(() {});
        });
  }
}

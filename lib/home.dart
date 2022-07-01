import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorder/provider/editor_provider.dart';
import 'package:reorder/widget/material/reorderable_list.dart' as custom;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateTime.now().toIso8601String()),
        leading: Consumer<EditorProvider>(builder: (_, value, child) {
          bool isEditor = value.isEditor();
          return IconButton(
            onPressed: () => value.setEditor(false),
            icon: Icon(isEditor ? Icons.arrow_back_sharp : Icons.menu),
          );
        }),
      ),
      body: RefreshIndicator(
        child: custom.ReorderableListView.builder(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(index.toString()),
              subtitle: Text(DateTime.now().toIso8601String()),
              leading: Consumer<EditorProvider>(builder: (_, value, child) {
                OutlinedBorder border;
                if (value.isEditor()) {
                  border = const CircleBorder();
                } else {
                  border = const RoundedRectangleBorder();
                }
                return Checkbox(
                  value: false,
                  onChanged: (value) {},
                  shape: border,
                );
              }),
              key: ValueKey(index),
            );
          },
          itemCount: 10000,
          onDragStart: () {
            Provider.of<EditorProvider>(context, listen: false).setEditor(true);
            debugPrint('onDragStart');
          },
          onReorder: (int oldIndex, int newIndex) {
            debugPrint('oldIndex = $oldIndex, newIndex = $newIndex');
          },
          physics: const AlwaysScrollableScrollPhysics(),
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    );
  }
}

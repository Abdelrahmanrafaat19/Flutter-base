import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/typedefs.dart';

class PaginatedListView<T> extends StatelessWidget {
  final List<T> dataList;
  final bool paginated;
  final ItemBuilder<T> builder;
  final VoidCallback? onBottomReached;
  final Function(T item)? onItemSelected;
  final ScrollController _paginatedListController = ScrollController();
  final bool? reversed;
  final EdgeInsets? padding;
  final pageLoading;
  final Widget? loadingWidget;
  final bool? withDivider;
  final ScrollPhysics? scrollPhysics;
  final OnRefreshScreen? onRefreshScreen;
  final bool? enableSwipe;
  final Axis? scrollDirection;
  PaginatedListView(
      {Key? key,
        required this.dataList,
        required this.paginated,
        required this.builder,
        this.onBottomReached,
        this.onItemSelected,
        this.padding,
        this.pageLoading,
        this.scrollPhysics,
        this.reversed,
        this.loadingWidget,
        this.withDivider,
        this.onRefreshScreen,
        this.enableSwipe, this.scrollDirection})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      child: dataList.isNotEmpty
          ? (withDivider == true
          ? ListView.separated(
        physics: scrollPhysics ?? const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection:scrollDirection??Axis.vertical ,
        padding: padding ??
            const EdgeInsets.only(left: 0, right: 0, bottom: 50),
        itemCount: paginated ? dataList.length + 1 : dataList.length,
        controller: _paginatedListController,
        reverse: reversed ?? false,
        separatorBuilder: (context, index) => Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.black.withOpacity(0.4),
        ),
        itemBuilder: (context, index) =>
        (paginated && index == dataList.length)
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Visibility(
              visible: paginated,
              child: pageLoading == true
                  ? (loadingWidget ??
                  const CircularProgressIndicator())
                  : const SizedBox(),
            ),
          ),
        )
            : builder(
          dataList[index],
        ),
      )
          : enableSwipe == true
          ? RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () {
          onRefreshScreen?.call();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          scrollDirection:scrollDirection??Axis.vertical ,
          physics: scrollPhysics ?? const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: padding ??
              const EdgeInsets.only(
                  left: 0, right: 0, bottom: 50),
          itemCount:
          paginated ? dataList.length + 1 : dataList.length,
          controller: _paginatedListController,
          reverse: reversed ?? false,
          itemBuilder: (context, index) =>
          (paginated && index == dataList.length)
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Visibility(
                visible: paginated,
                child: pageLoading == true
                    ? (loadingWidget ??
                    const CircularProgressIndicator())
                    : const SizedBox(),
              ),
            ),
          )
              : builder(
            dataList[index],
          ),
        ),
      )
          : ListView.builder(
        physics: scrollPhysics ?? const BouncingScrollPhysics(),
        scrollDirection:scrollDirection??Axis.vertical ,
        shrinkWrap: true,
        padding: padding ??
            const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        itemCount:
        paginated ? dataList.length + 1 : dataList.length,
        controller: _paginatedListController,
        reverse: reversed ?? false,
        itemBuilder: (context, index) =>
        (paginated && index == dataList.length)
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Visibility(
              visible: paginated,
              child: pageLoading == true
                  ? (loadingWidget ??
                  const CircularProgressIndicator())
                  : const SizedBox(),
            ),
          ),
        )
            : builder(
          dataList[index],
        ),
      ))
          : Center(
          child: SingleChildScrollView(
            controller: _paginatedListController,
            scrollDirection:scrollDirection??Axis.vertical ,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Text(
              "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )),
      onNotification: (scrollEnded) {
        if (_paginatedListController!.position.pixels >= 0 &&
            _paginatedListController!.position.pixels ==
                _paginatedListController!.position.maxScrollExtent) {
          onBottomReached != null
              ? onBottomReached!()
              : print("Reached bottom");
        }
        return true;
      },
    );
  }
}

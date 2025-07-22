import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:cholai_sdk/src/widgets/app_loader.dart';
import 'package:cholai_sdk/src/widgets/page_nation_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginatedListView extends StatefulWidget {
  final Future<void> Function()? onRefresh; // Refresh event
  final Function? onPagination; // Pagination triggered
  final bool isPaginationLoading; // To display loading indicator
  final bool paginationOver; // Flag to disable further pagination
  final int itemCount; // Total items in list
  final Widget Function(BuildContext, int)
  itemBuilder; // Item builder for the list
  final Widget separator; // Separator between items
  final String?
  paginationErrorMessage; // Error message in case of pagination failure
  final Function? onPaginationRetry; // Retry function for pagination
  final String emptyMessage; // Message to show when the list is empty
  final Color? backgroundColor;
  final Widget? listEmptyWidget;
  final bool isLoading; // Flag to show loading widget
  final Widget loadingWidget; // Widget to display when loading
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;
  final bool reverse; // Reverse the list view
  const PaginatedListView({
    super.key,
    this.onRefresh,
    this.onPagination,
    this.isPaginationLoading = false,
    this.paginationOver = true,
    required this.itemCount,
    required this.itemBuilder,
    required this.separator,
    this.paginationErrorMessage,
    this.onPaginationRetry,
    this.emptyMessage = "No Data Found", // Add the empty message here
    this.backgroundColor,
    this.listEmptyWidget,
    this.padding,
    this.isLoading = false, // Default value is false
    Widget? loadingWidget, // Loading widget
    this.reverse = false, // Default value is false
    this.scrollController,
  }) : loadingWidget = loadingWidget ?? const Center(child: AppLoader());
  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  // Default loading widget
  bool paginationLock = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        // Check if we reached the bottom of the list
        if (!widget.isPaginationLoading &&
            !widget.paginationOver &&
            !paginationLock) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            paginationLock = true; // Lock pagination to avoid multiple triggers

            LoggerUtil.debug("Pagination triggered: Loading more items...");

            if (widget.onPagination != null) {
              widget.onPagination!();
              // Unlock after a delay or when loading finishes
              Future.delayed(const Duration(seconds: 1), () {
                paginationLock = false;
              });
            }
          }
        }
        return false; // Don't consume the event
      },
      child: Container(
        color: widget.backgroundColor,
        child:
            widget
                    .isLoading // Check if isLoading is true
                ? widget
                    .loadingWidget // Display loading widget
                : widget.itemCount == 0
                ? widget.listEmptyWidget ??
                    Center(
                      child: Text(
                        widget
                            .emptyMessage, // Display the provided empty message
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                : widget.onRefresh != null
                ? RefreshIndicator(
                  color: ColorConfig.primaryColor,
                  backgroundColor: ColorConfig.backgroundColor,
                  onRefresh: () async {
                    await Future.delayed(
                      const Duration(milliseconds: 500),
                    ); // Delay of 0.5 seconds
                    await widget
                        .onRefresh!(); // Call the onRefresh function after delay
                  },
                  child: listViewBuilder(),
                )
                : listViewBuilder(),
      ),
    );
  }

  Widget listViewBuilder() {
    return ListView.separated(
      reverse: widget.reverse,
      controller: widget.scrollController,
      shrinkWrap: true,
      itemCount: widget.itemCount,
      padding:
          widget.padding ??
          EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            widget.itemBuilder(
              context,
              index,
            ), // Build item with the provided function
            if (index == widget.itemCount - 1 && widget.isPaginationLoading)
              PaginationLoader(
                isLoading: widget.isPaginationLoading,
                showMessage: true,
                errorMessage: widget.paginationErrorMessage,
                onRetry:
                    widget.onPaginationRetry != null
                        ? () {
                          widget.onPaginationRetry!();
                        }
                        : null, // Retry pagination
              ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return widget.separator; // Use provided separator
      },
    );
  }
}

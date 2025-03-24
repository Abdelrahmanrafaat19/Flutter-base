// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base/core/widgets/custom_app_bar.dart';
// import 'package:flutter_base/features/notification/domain/entities/notification_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// import '../widgets/notification_item_view.dart';
//
// class NotificationScreen extends ConsumerStatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends ConsumerState<NotificationScreen> {
//   List<NotificationEntity> notifications = [
//     NotificationEntity(
//       createdAt: '2025-03-15',
//       id: 1,
//       imagePath: 'path/to/image1.png',
//       isRead: 0,
//       notification: 'You have a new notification.',
//       title: 'New Notification 1',
//       updatedAt: '2025-03-16',
//     ),
//     NotificationEntity(
//       createdAt: '2025-03-16',
//       id: 2,
//       imagePath: 'path/to/image2.png',
//       isRead: 1,
//       notification: 'Your order has been shipped.',
//       title: 'Order Shipped',
//       updatedAt: '2025-03-17',
//     ),
//     NotificationEntity(
//       createdAt: '2025-03-17',
//       id: 3,
//       imagePath: 'path/to/image3.png',
//       isRead: 0,
//       notification: 'Don’t forget to check your messages.',
//       title: 'Message Reminder',
//       updatedAt: '2025-03-18',
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     // final notificationState = ref.watch(showNotificationStateNotifiers);
//     // handleState(makeNotificationReadStateNotifiers, showLoading: true,
//     //     onSuccess: (res) {
//     //       if (res.data?.data?.type == "order") {
//     //         ref.read(showNotificationStateNotifiers.notifier).getNotification();
//     //         navigateToOrderDetails(res.data?.data?.orderId.toString() ?? "");
//     //       }
//     //     });
//
//     return Scaffold(
//         appBar: CustomAppBar(
//           appContext: context,
//           title: "Notifications",
//           isCenter: false,
//           navigated: true,
//         ),
//         body: SafeArea(
//             child: false
//                 ? Expanded(
//                 child: Center(child: Text("there is any notification yet")))
//                 : ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   /* if (notificationState.state == DataState.LOADING) {
//                     return Skeletonizer(
//                       enabled: false,
//                       child: NotificationItemView(
//                         notification:
//                         NotificationEntity(
//                             isRead: 1),
//                         onNotificationItemClick: (notificationItem) {},
//                       ),
//                     );
//                   } else*/ if (ref
//                       .watch(showNotificationStateNotifiers.notifier)
//                       .notificationDates[index] is String) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 20.0),
//                       child: NotificationDateView(
//                           date: ref
//                               .watch(
//                               showNotificationStateNotifiers.notifier)
//                               .notificationDates[index]),
//                     );
//                   } else if (ref
//                       .watch(showNotificationStateNotifiers.notifier)
//                       .notificationDates[index]
//                   is ClientNotification) {
//                     return NotificationItemView(
//                       notification:
//                       (ref
//                           .watch(showNotificationStateNotifiers
//                           .notifier)
//                           .notificationDates[index]!
//                       as ClientNotification),
//                       onNotificationItemClick: (notificationItem) {
//                         if (notificationItem?.type == "order") {
//                           if (notificationItem?.isRead == 0) {
//                             ref
//                                 .read(makeNotificationReadStateNotifiers
//                                 .notifier)
//                                 .readANotification(
//                                 notificationItem?.id.toString() ?? "0");
//                           } else {
//                             navigateToOrderDetails(
//                                 notificationItem?.orderId.toString() ??
//                                     "0");
//                           }
//                         }
//                       },
//                     );
//                   }
//                 })));
//   }
//
//   void navigateToOrderDetails(String orderId) {
//     // context.push(R_OrderDetails, extra: {orderIdKey: orderId});
//   }
//
//   void spiltNotificationsDates() {
//     notificationDates.clear();
//     List<String> dates = [];
//     notificationList.forEach((notificationModel) {
//       notificationList.asMap().forEach((index, notifyModel) {
//         if (notificationModel.createdAt?.stringToDate() ==
//             notifyModel.createdAt?.stringToDate()) {
//           if (dates.contains(notificationModel.createdAt?.stringToDate())) {
//             if (!notificationDates.contains(notifyModel))
//               notificationDates.add(notifyModel);
//           } else {
//             dates.add(notificationModel.createdAt!.stringToDate());
//             notificationDates.add(
//                 checkTodayOrYesterday(notificationModel.createdAt!.stringToDate()));
//             if (!notificationDates.contains(notifyModel))
//               notificationDates.add(notifyModel);
//           }
//         }
//       });
//     });
//   }
//
//   String checkTodayOrYesterday(String date) {
//     DateTime today = DateTime.now();
//     DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
//     print("dafsdfasdf $date ${today.ddMmYyyy()}");
//     return date == today.ddMmYyyy()
//         ? "Today"
//         : date == yesterday.ddMmYyyy()
//         ? "Yesterday"
//         : date;
//   }
//
// }

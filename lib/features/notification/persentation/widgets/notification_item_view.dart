import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/date_utils.dart';
import 'package:flutter_base/core/utils/typedefs.dart';
import 'package:flutter_base/features/notification/domain/entities/notification_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';

class NotificationItemView extends StatefulWidget {
  final NotificationEntity notification;
  final OnNotificationClick onNotificationClick;
  const NotificationItemView(this.notification,
      {super.key, required this.onNotificationClick});

  @override
  State<NotificationItemView> createState() => _NotificationItemViewState();
}

class _NotificationItemViewState extends State<NotificationItemView> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          widget.onNotificationClick.call(widget.notification);
        },
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal,vertical: 1),
          color: widget.notification.isRead == 1
              ? Colors.white
              : AppTheme.filterOptionBackground,
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.replace(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                          fit: BoxFit.cover,
                          widget.notification?.imagePath ?? "",
                          width: 42,
                          height: 42, errorBuilder: (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return SizedBox();
                      }),
                    ),
                    replacement: Icon(
                      Icons.abc,
                      size: 42,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      (widget.notification.notification ??
                          "lskdjflksadjflk sdf sdjf kjd fkjsa dlkfj sldfsl dfjjsdf lajs dfljsdflkj "),
                      style: AppTheme
                          .styleWithTextBlackAdelleSansExtendedFonts16w400,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    (widget.notification.createdAt?.hhMm() ?? "sklj"),
                    style: AppTheme
                        .styleWithTextGray13AdelleSansExtendedFonts11w400,
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Divider(
                height: 1,
                color: AppTheme.appGrey11,
              )
            ],
          ),
        ),
      ),
    );
  }
}

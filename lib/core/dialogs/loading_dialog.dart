import 'package:animations/animations.dart';
import '../../../../core/Utils/Extintions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/flat_app_button.dart';
import '../../../core/Theme/app_theme.dart';

Future<dynamic> showAppDialog(BuildContext context, Widget dialog,{bool? dismissible}) async {
  var result = await showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(
          barrierDismissible: dismissible??true,
          transitionDuration: Duration(milliseconds: 500)),
      builder: (context) => dialog);
  return result;
}

extension Dialogs on BuildContext {

  closeDialog({Object? data}){
    Navigator.of(this).pop(data);
  }

  showLoadingDialog(){
    showAppDialog(this, LoadingWidget());
  }

  hideLoadingDialog(){
    if(isThereCurrentDialogShowing == true){
      pop();
    }
  }

  showSuccessDialog({String? message,required String description,VoidCallback? onCancel,VoidCallback? onConfirm,Color? headerColor}) async {
    showAppDialog(this , Dialog(


      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10,),
            Align(alignment:Alignment.centerLeft,child: Text(message ?? "Success!" "✅",style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: AppTheme.successColor),textAlign: TextAlign.center,)),
            const SizedBox(height: 8,),
            Text(textAlign: TextAlign.start , description,style: Theme.of(this).textTheme.titleLarge?.copyWith(fontSize: 16),),
            const SizedBox(height: 10,),
            Align(alignment:Alignment.centerRight,child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(onCancel != null) AppButton(onPress: (){
                  pop();
                  onCancel.call();
                },text: this.tr("cancel"),backColor: AppTheme.mainAppColorLight,outlined: true,width: 80,height: 40,),
                const SizedBox(width: 14,),
                AppButton(onPress: (){
                  pop();
                  onConfirm?.call();
                },text: this.tr("ok"),width: 80,height: 40,)
              ],))
          ],
        ),
      ),
    ),);
  }

  showFailDialog({ required String message,String? description,VoidCallback? onClose}) async {
    showAppDialog(this , Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error,color: AppTheme.failureColor,size: 100,),
            const SizedBox(height: 20,),
            Text(message,style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: AppTheme.failureColor),textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
            if(description != null) Text(description,style: Theme.of(this).textTheme.bodyMedium,textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            FlatAppButton(onPress: (){
              Navigator.pop(this);
              onClose?.call();
            },text: 'close',txtColor: AppTheme.appSwatch,)
          ],
        ),
      ),
    ),);
  }

  showAlertDialog({required String description,String? header,String? action,VoidCallback? onClose,VoidCallback? onCancel}) async {
    showAppDialog(this , Dialog(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10,),
            Align(alignment:Alignment.centerLeft,child: Text(header??tr("attention"),style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: AppTheme.lightAlert),textAlign: TextAlign.center,)),
            const SizedBox(height: 8,),
            Text(textAlign: TextAlign.start , description,style: Theme.of(this).textTheme.titleLarge?.copyWith(fontSize: 16),),
            const SizedBox(height: 10,),
            Align(alignment:Alignment.centerRight,child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(onCancel != null) AppButton(onPress: (){
                  pop();
                  onCancel.call();
                },text: this.tr("cancel"),backColor: AppTheme.mainAppColorLight,outlined: true,width: 80,height: 40,),
                const SizedBox(width: 14,),
                AppButton(onPress: (){
                  pop();
                  onClose?.call();
                },text: action??this.tr("ok"),width: 80,height: 40,)
              ],))
          ],
        ),
      ),
    ),);
  }


  showTermsAndConditionsDialog(WidgetRef ref , String terms){
    showAppDialog(this, Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 25,),
          Center(child: Text("")),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(15),child: Text(terms,style: Theme.of(this).textTheme.bodyMedium))),
          const SizedBox(height: 10,),
          FlatAppButton(onPress: ()=> Navigator.pop(this),text: 'close',txtColor: AppTheme.appSwatch,)
        ],
      ),
    ));
  }

  void showSelectionActionSheet(List<String> items,Function(int) onSelection,{String? header}) {
    showCupertinoModalPopup<void>(
      context: this,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: header != null ? Text(header??"") : null,
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('cancel').tr(),
        ),
        actions: List.generate(items.length, (index) => CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onSelection.call(index);
          },
          child: Text(items[index]),
        ),),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final Color? backgroundColor;
  const LoadingWidget({super.key, this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator(),),
            //Text(AppLocalizations.of(context)!.translate("loading"),style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppTheme.appSwatch),)
          ],
        ),),
    );
  }
}

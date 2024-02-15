import 'package:flutter/material.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_colors.dart';

getPrimaryAppButton(BuildContext context, String label, {required Future<Null> Function() onPressed, Color? buttonColor}) {

  return GestureDetector(
    onTap: onPressed,
    child: Container(
      // margin: const EdgeInsets.symmetric(horizontal: 2),
      width: screenSize!.width,
      height: 50,
      decoration: BoxDecoration(
          color: buttonColor ??AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      )),
    ),
  );
}

showLanguageBottomSheet(BuildContext context, Function(String languageCode) onLanguageChange) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: screenSize!.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Select Language",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: localization.supportedLanguageCodes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        onLanguageChange(localization.supportedLanguageCodes[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${localization.getLanguageName(languageCode: localization.supportedLanguageCodes[index].toString())} - ${localization.supportedLanguageCodes[index]} ",
                                style: const TextStyle(fontSize: 18),
                              ),
                              localization.supportedLanguageCodes[index] ==
                                      localization.currentLocale!.languageCode
                                  ? const Icon(
                                      Icons.check,
                                      color: AppColors.primaryColor,
                                    )
                                  : const SizedBox.shrink()
                            ],
                          )),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  }),
            ],
          ),
        );
      });
}

void showImageSourceDialog(BuildContext context, {required Future<Null> Function(dynamic value) onOptionSelected}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text("Choose Image Source"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () async {
              onOptionSelected('Camera');
              Navigator.pop(context);
            },
            child: const ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              onOptionSelected('Gallery');
              Navigator.pop(context);
              },
            child: const ListTile(
              leading: Icon(Icons.image),
              title: Text("Gallery"),
            ),
          ),
        ],
      );
    },
  );
}

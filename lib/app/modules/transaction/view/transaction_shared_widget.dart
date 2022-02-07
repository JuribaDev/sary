import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sary/app/common/colors/light_theme_color.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/util/date_time_format.dart';
import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/modules/transaction/controller/transaction_controller.dart';

class TransactionSharedWidget {
  static Widget customTextForm(
      {TextEditingController? controller,
      required ValueChanged<String> onChanged,
      String? initialValue,
      FormFieldValidator<String>? validator,
      required VoidCallback onIconButtonPressed}) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      initialValue: initialValue,
      style: transactionDetailTitleTextStyle,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: onIconButtonPressed,
          icon: SvgPicture.asset(
            "assets/icons/search_icon.svg",
            width: 15.w,
            height: 15.h,
            color: const Color(0xff5f5f5f),
          ),
        ),
        hintText: 'Search',
        hintStyle: transactionSearchTextStyle,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
      ),
    );
  }

  static Widget circlerFilterButton({required VoidCallback onPressed}) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.05),
            color: const Color(0xffe7e7e7)),
        child: CircleAvatar(
          radius: 40.r,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(
              "assets/icons/filter_icon.svg",
              width: 15.w,
              height: 15.h,
              color: const Color(0xff5f5f5f),
            ),
          ),
        ));
  }

  static Future<DateTime?> pickDate(
      BuildContext context, DateTime? dateTime) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return null;
    return newDate;
  }

  static Future<TimeOfDay?> pickTime(
      BuildContext context, DateTime? dateTime) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );
    if (newTime == null) return null;
    return newTime;
  }
}

class FilterWidget extends StatefulWidget {
  FilterWidget({
    Key? key,
    required this.context,
    required this.item,
  }) : super(key: key);
  BuildContext context;
  Map<String, dynamic> item;
  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var startDateController;
  late DateTime start;
  late DateTime end;
  var endDateController;
  RangeValues _rangeSliderDiscreteValues = const RangeValues(1, 10000);
  @override
  void initState() {
    start = DateTime.now();
    end = DateTime(DateTime.now().month - 1);
    startDateController = TextEditingController();

    endDateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TransactionController>(context, listen: false);
    return Form(
      key: formKey,
      child: Container(
        height: 700.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          border: Border.all(color: lightColorScheme.primary, width: 0.3.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 35.sp,
                color: lightColorScheme.primary,
              ),
              SharedWidget.box(0, 10.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Filter By Quantity',
                  style: transactionDetailDatetimeTextStyle,
                ),
              ),
              SharedWidget.box(0, 10.h),
              RangeSlider(
                values: _rangeSliderDiscreteValues,
                min: 0,
                max: 10000,
                divisions: 5000,
                labels: RangeLabels(
                  _rangeSliderDiscreteValues.start.round().toString(),
                  _rangeSliderDiscreteValues.end.round().toString(),
                ),
                onChanged: (values) {
                  setState(() {
                    _rangeSliderDiscreteValues = values;
                  });
                },
              ),
              SharedWidget.box(0, 10.h),
              SharedWidget.buttonWithOutIcon(
                  onPressed: () {
                    controller.searchOrFilter(
                        operationType: OperationType.filterByQuantity,
                        itemId: widget.item['id'],
                        from: _rangeSliderDiscreteValues.start.toString(),
                        to: _rangeSliderDiscreteValues.end.toString());

                    Navigator.pop(context);
                  },
                  buttonLabel: 'Quantity Filter'),
              SharedWidget.box(0, 10.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Filter By Date created',
                  style: transactionDetailDatetimeTextStyle,
                ),
              ),
              SharedWidget.box(0, 10.h),
              Container(
                child: SharedWidget.textForm(
                  onTap: () async {
                    var val = await pickDateRange(context);
                    start = val.start;
                    end = val.end;
                    startDateController.text =
                        DateTimeFormat.getFullDateTime(val.start)
                            .substring(0, 8);
                    endDateController.text =
                        DateTimeFormat.getFullDateTime(val.end).substring(0, 8);
                  },
                  readOnly: true,
                  controller: startDateController,
                  labelText: 'Start Date At',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter The Start Date";
                    }
                  },
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                ),
              ),
              SharedWidget.box(0, 10.h),
              Container(
                child: SharedWidget.textForm(
                  onTap: () async {
                    var val = await pickDateRange(context);
                    start = val.start;
                    end = val.end;
                    startDateController.text =
                        DateTimeFormat.getFullDateTime(val.start)
                            .substring(0, 8);
                    endDateController.text =
                        DateTimeFormat.getFullDateTime(val.end).substring(0, 8);
                  },
                  readOnly: true,
                  controller: endDateController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter The End Date";
                    }
                  },
                  labelText: 'End Date At',
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                ),
              ),
              SharedWidget.box(0, 10.h),
              SharedWidget.buttonWithOutIcon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.searchOrFilter(
                          operationType: OperationType.filterByCreatedAt,
                          itemId: widget.item['id'],
                          fromDate: start,
                          toDate: end);

                      Navigator.pop(context);
                    }
                  },
                  buttonLabel: 'Date Filter'),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 1),
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        ));

    if (newDateRange == null) {
      return DateTimeRange(
        start: DateTime(DateTime.now().year - 1),
        end: DateTime.now(),
      );
    }

    return newDateRange;
  }
}

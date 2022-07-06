import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:personal_expenses/widgets/adaptative/adaptative_date_picker.dart';
import 'package:personal_expenses/widgets/adaptative/adaptative_text_field.dart';
import 'package:personal_expenses/widgets/adaptative/adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextFiel(
                label: 'transaction-title'.i18n(),
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
              ),
              AdaptativeTextFiel(
                label: '${'transaction-value'.i18n()} ${format.currencySymbol}',
                controller: _valueController,
                onSubmitted: (_) => _submitForm(),
                inputType: const TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'new-transaction'.i18n(),
                    onPressed: _submitForm,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

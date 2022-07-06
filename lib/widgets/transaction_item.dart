import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.format,
    required this.tr,
    required this.mediaQuery,
    required this.onRemove,
  }) : super(key: key);

  final NumberFormat format;
  final Transaction tr;
  final MediaQueryData mediaQuery;
  final void Function(String) onRemove;

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black
  ];

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
    _backgroundColor = TransactionItem.colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '${widget.format.currencySymbol} ${widget.tr.value.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('date-format-list'.i18n()).format(widget.tr.date),
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        trailing: widget.mediaQuery.size.width > 450
            ? TextButton.icon(
          onPressed: () => widget.onRemove(widget.tr.id),
          //todo i18n
          label: Text('Excluir'),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
        )
            : IconButton(
          onPressed: () => widget.onRemove(widget.tr.id),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}

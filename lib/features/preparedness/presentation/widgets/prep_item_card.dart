import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../models/prep_item_model.dart';
import '../../../../models/prep_item_extensions.dart';

class PrepItemCard extends StatefulWidget {
  final PrepItem item;
  final Function(double) onQuantityChanged;
  final VoidCallback? onDelete;

  const PrepItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    this.onDelete,
  });

  @override
  State<PrepItemCard> createState() => _PrepItemCardState();
}

class _PrepItemCardState extends State<PrepItemCard> {
  late TextEditingController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item.currentQuantity.toStringAsFixed(widget.item.currentQuantity.truncateToDouble() == widget.item.currentQuantity ? 0 : 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    final newValue = widget.item.currentQuantity + 1;
    if (newValue <= widget.item.targetQuantity * 2) {
      widget.onQuantityChanged(newValue);
      _controller.text = newValue.toStringAsFixed(0);
    }
  }

  void _decrement() {
    final newValue = widget.item.currentQuantity - 1;
    if (newValue >= 0) {
      widget.onQuantityChanged(newValue);
      _controller.text = newValue.toStringAsFixed(0);
    }
  }

  void _onTextChanged(String value) {
    final newValue = double.tryParse(value);
    if (newValue != null && newValue >= 0) {
      widget.onQuantityChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = widget.item.isItemCompleted;
    final progress = widget.item.progressPercentage;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isComplete,
                        onChanged: (value) {
                          if (value == true) {
                            widget.onQuantityChanged(widget.item.targetQuantity);
                          }
                        },
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: isComplete ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Mål: ${widget.item.targetQuantity.toInt()} ${widget.item.unit}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.item.isCustom && widget.onDelete != null)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: widget.onDelete,
                        ),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isComplete ? Colors.green : Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.item.currentQuantity.toInt()} / ${widget.item.targetQuantity.toInt()} ${widget.item.unit}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${progress.toInt()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isComplete ? Colors.green : Colors.blue,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Justera mängd',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.item.currentQuantity > 0 ? _decrement : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        iconSize: 32,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          onChanged: _onTextChanged,
                          decoration: InputDecoration(
                            suffix: Text(widget.item.unit),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _increment,
                        icon: const Icon(Icons.add_circle_outline),
                        iconSize: 32,
                      ),
                    ],
                  ),
                  if (widget.item.remainingQuantity > 0) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.amber[700], size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Återstår: ${widget.item.remainingQuantity.toInt()} ${widget.item.unit}',
                              style: TextStyle(
                                color: Colors.amber[900],
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

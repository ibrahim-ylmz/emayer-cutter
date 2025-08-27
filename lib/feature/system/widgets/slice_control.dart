import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:flutter/material.dart';

class SliceControl extends StatefulWidget {
  const SliceControl({super.key});

  @override
  State<SliceControl> createState() => _SliceControlState();
}

class _SliceControlState extends State<SliceControl> {
  int horizontalSlices = 0;
  int verticalSlices = 0;

  void _showNumberPad(
    BuildContext context,
    String title,
    int currentValue,
    Function(int) onChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NumberPadDialog(
          title: title,
          currentValue: currentValue,
          onChanged: onChanged,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Horizontal Slices Input
          _buildInputField(
            'Horizontal Slices',
            horizontalSlices,
            () => _showNumberPad(
              context,
              'Horizontal Slices',
              horizontalSlices,
              (value) {
                setState(() {
                  horizontalSlices = value;
                });
              },
            ),
          ),

          SizedBox(height: 20.h),

          // Vertical Slices Input
          _buildInputField(
            'Vertical Slices',
            verticalSlices,
            () => _showNumberPad(context, 'Vertical Slices', verticalSlices, (
              value,
            ) {
              setState(() {
                verticalSlices = value;
              });
            }),
          ),

          SizedBox(height: 30.h),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton('Go Center', Icons.center_focus_strong, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, int value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.onError,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18.sp,
                    color: Theme.of(context).colorScheme.onError,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  Icons.keyboard,
                  color: Theme.of(context).colorScheme.onError.withValues(alpha: 0.6),
                  size: 20.s,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20.s),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 187, 97, 1),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        elevation: 2,
      ),
    );
  }
}

class NumberPadDialog extends StatefulWidget {
  final String title;
  final int currentValue;
  final Function(int) onChanged;

  const NumberPadDialog({
    super.key,
    required this.title,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  State<NumberPadDialog> createState() => _NumberPadDialogState();
}

class _NumberPadDialogState extends State<NumberPadDialog> {
  String _displayValue = '';

  @override
  void initState() {
    super.initState();
    _displayValue = widget.currentValue.toString();
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (_displayValue == '0') {
        _displayValue = number;
      } else {
        _displayValue += number;
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _displayValue = '0';
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_displayValue.length > 1) {
        _displayValue = _displayValue.substring(0, _displayValue.length - 1);
      } else {
        _displayValue = '0';
      }
    });
  }

  void _onConfirmPressed() {
    final value = int.tryParse(_displayValue) ?? 0;
    widget.onChanged(value);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        width: 300.w,
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18.sp,
                color: Theme.of(context).colorScheme.onError,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 20.h),

            // Display
            Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  _displayValue,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24.sp,
                    color: Theme.of(context).colorScheme.onError,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Number Pad
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return _buildNumberButton(
                    'C',
                    _onClearPressed,
                    isSpecial: true,
                  );
                } else if (index == 10) {
                  return _buildNumberButton('0', () => _onNumberPressed('0'));
                } else if (index == 11) {
                  return _buildNumberButton(
                    '⌫',
                    _onBackspacePressed,
                    isSpecial: true,
                  );
                } else {
                  final number = (index + 1).toString();
                  return _buildNumberButton(
                    number,
                    () => _onNumberPressed(number),
                  );
                }
              },
            ),

            SizedBox(height: 20.h),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onError.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _onConfirmPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 187, 97, 1),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(
    String text,
    VoidCallback onPressed, {
    bool isSpecial = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSpecial
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 1,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}

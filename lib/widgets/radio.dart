import 'package:flutter/material.dart';

class RadioOption {
  final String label;
  final dynamic value;

  RadioOption({required this.label, required this.value});
}

class RadioGroup extends StatefulWidget {
  final List<RadioOption> options;
  final String? labelText;
  final void Function(dynamic value)? onChange;
  final bool toggleable;
  final dynamic selectedValue;

  RadioGroup({
    Key? key,
    required this.options,
    this.labelText,
    this.onChange,
    this.toggleable = false,
    this.selectedValue,
  }) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  int selected = -1;

  void handleSelect(int index) {
    setState(() {
      if (selected == index && widget.toggleable) {
        selected = -1;
        widget.onChange?.call(null);
      } else {
        selected = index;
        widget.onChange?.call(widget.options[selected].value);
      }
    });
  }

  @override
  void initState() {
    if (widget.selectedValue != null) {
      setState(() {
        final _index =
            widget.options.indexWhere((e) => e.value == widget.selectedValue);
        selected = _index;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  widget.labelText!,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              )
            : SizedBox(),
        for (int i = 0; i < widget.options.length; i++)
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            onTap: () {
              handleSelect(i);
            },
            leading: Radio(
              toggleable: widget.toggleable,
              value: i,
              groupValue: selected,
              onChanged: (v) {
                handleSelect(i);
              },
            ),
            title: Text(
              widget.options[i].label,
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/BaseUtils.dart';
import '../widget/EditLayout.dart';

class EditWidget extends StatelessWidget {

  final EdgeInsetsGeometry margin;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Decoration decoration;
  final Color bgColor;
  final MainAxisSize mainAxisSize;
  final double height;
  final double width;

  final double size;
  final String text;
  final Color color;
  final Color hintColor;
  final TextAlign textAlign;
  final bool readOnly;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final Color stroke;
  final double radius;
  final EdgeInsetsGeometry padding;
  final InputType inputType;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onEditingComplete;
  final VoidCallback onTap;
  final FocusNode focusNode;


  const EditWidget({Key key, this.margin,
    this.direction, this.mainAxisAlignment,
    this.crossAxisAlignment, this.decoration,
    this.bgColor, this.mainAxisSize,
    this.height, this.width, this.size:12,
    this.color: Colors.black,
    this.hintColor: Colors.grey,
    this.textAlign: TextAlign.start,
    this.readOnly: false,
    this.hint,
    this.onChanged,
    this.controller,
    this.stroke: Colors.transparent,
    this.keyboardType,
    this.maxLength,
    this.focusNode,
    this.text,
    this.radius: 0.0,
    this.padding: const EdgeInsets.symmetric(vertical: 0.0),
    this.inputType: InputType.text, this.onSubmitted, this.onEditingComplete, this.onTap

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    var _controller = controller;
    if(null == controller){
      _controller = TextEditingController();
    }
    if(!BaseUtils.isEmpty(text)) {
      _controller.text = BaseUtils.isEmpty(text) ? "" : text;
    }


    var obscureText =  inputType == InputType.password || inputType == InputType.password_number;

    List<TextInputFormatter> formatters = [];

    if(inputType == InputType.abc){
      var f = FilteringTextInputFormatter(RegExp("[a-zA-Z]"));
      formatters.add(f);
    }

    if(inputType == InputType.number){
      formatters.add(WhitelistingTextInputFormatter.digitsOnly);
    }

    return TextField(
        focusNode: focusNode,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onTap: onTap,
        obscureText: obscureText,
        inputFormatters: formatters,
        controller: _controller,
        style: TextStyle(
            fontSize: size,
            color: color
        ),
        textAlign: textAlign,
        readOnly: readOnly,
        maxLength: maxLength,
        toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true
        ),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            counterText:"",
            contentPadding: padding,
//            focusedBorder: border,
//            border: border,
            hintText: hint,
//            enabledBorder: border,
            hintStyle: TextStyle(
                fontSize: size,
                color: hintColor

            )
        )
    );
  }
}


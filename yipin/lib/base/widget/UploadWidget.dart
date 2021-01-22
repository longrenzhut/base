

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../controller/BaseController.dart';
import '../extension/WidgetExt.dart';
import '../http/HttpsProvider.dart';
import '../http/Params.dart';
import '../http/ReqCallBack.dart';
import '../model/FileModel.dart';
import '../utils/BaseUtils.dart';
import '../utils/ImageHelper.dart';
import '../utils/CstColors.dart';
import '../widget/TextView.dart';


class UploadWidget extends StatefulWidget {


  final String title;
  final String placeholder;
  final double width;
  final double height;
  final FileModel fileInfo;
  final UploadController controller;

  const UploadWidget({Key key, this.title, this.placeholder,
    this.height:129,
    this.width:200,
    this.fileInfo,
    this.controller
  }) : super(key: key);

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {



  @override
  void initState() {
    super.initState();
    widget.controller?.setFileInfo(widget.fileInfo);
  }

  @override
  void dispose() {
    data = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _itemPicWidget(widget.title);
  }

  Uint8List data;

  Widget _itemPicWidget(String title){

    var url = widget.controller?.fileInfo?.url;
    var imageWidget = data != null ? Container(
      height: widget.height,
      width: widget.width,
      child: Image.memory(data, fit: BoxFit.fitWidth,),
    ) :
    ImageHelper.load(url,
        height: widget.height,
        width: widget.width,
        placeholder: widget.placeholder
    ).buildInkWell(() => BaseUtils.launchURL(url));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            imageWidget,
            InkWell(
              child: TextView("打开"),//ImageHelper.buildImage("ic_open_image.png",width: 50,height: 50),
              onTap: () {
                open();
              },
            )
          ],
        ),
        SizedBox(height: 10,),
        TextView(title,size: 14,color: CstColors.cl_7B8290,),
      ],
    );
  }

  open() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowCompression:true,
      type: FileType.image,
      allowedExtensions: ['jpg', 'png'],
    );
    if(!BaseUtils.isEmptyList(result.files)){
      var param = Params(type: 1);
      var model = result.files.first;
      param.putMultipartFile(MultipartFile.fromBytes(model.bytes,filename: model.name));
      await HttpUtils.instance().postFile("common/front/upload/oss/file", param,
        callBack: ReqCallBack(
            onSuccess: (result){
              List<FileModel> list = result.map<FileModel>((item) =>
                  FileModel.fromJson(item)
              ).toList();

              if(!BaseUtils.isEmptyList(list)){
                setState(() {
                  data = model.bytes;
                  widget.controller?.setFileInfo(list.first);
                });
              }
            }
        ),
      );

    }


//        final picker = ImagePicker();
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      url = pickedFile.path;
//    });

  }
}

class UploadController with BaseController{

  FileModel _fileInfo;


  FileModel get fileInfo => _fileInfo;

  setFileInfo(FileModel value) {
    _fileInfo = value;
    setValue(value?.url);
  }


}



import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:yipin/base/base/adapter/BaseAdapter.dart';
import 'package:yipin/base/base/common/PtrSliverListWidget.dart';
import 'package:yipin/base/base/page/BasePage.dart';
import 'package:yipin/base/utils/ToastUtil.dart';
import 'package:yipin/base/widget/tab/TabBarWidget.dart';
import 'package:yipin/base/widget/tab/TabPageWidget.dart';
import 'package:yipin/ui/login/page/LoginPage.dart';
import 'package:yipin/ui/main/page/MainPage.dart';
import '../base/router/routes.dart';
import '../base/router/RouterHelper.dart';

import '../base/extension/WidgetExt.dart';
import '../base/utils/ImageHelper.dart';
import '../base/utils/WidgetUtils.dart';
import '../base/widget/AnimWidget.dart';
import 'TestVM.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class TestPage extends StatefulWidget {

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends LifecyclePageState<TestPage,TestVM> {

  @override
  TestVM getViewModel() =>  TestVM();

  bool isFirst = true;

  int get type => arguments["type"]??0;

  @override
  Widget getView(BuildContext context) {
    if(type == 1)
      return _tabWidget();
    else if(type == 2)
      return Center(
        child: Container(
          width: 200,
          height: 200,
          child: PieOutsideLabelChart.withSampleData(),
        ),
      );
    return PtrSliverListWidget(
      slivers: [
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(height: 30, color: Colors.lightBlue);
                }))
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("charts").buildInkWell(() =>   RouterHelper.build(context, RouteSettings(name: Routes.test,arguments: {"type": 2})))
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                FadeInLeft(
                    delay: Duration(milliseconds: 1000),
                    child: Container(height: 30, width:30,color: Colors.lightBlue) ),
                FadeInUp(  delay: Duration(milliseconds: 1000),child: Container(height: 30, width:30, color: Colors.lightBlue) ),
                FadeInDown(  delay: Duration(milliseconds: 1000),child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                BounceInDown(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
                BounceInUp(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
                BounceInLeft(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
                BounceInRight(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
            child: Column(
              children: <Widget>[
                SlideInDown(child: Container(height: 30,  width:double.infinity,color: Colors.lightBlue) ),
                SlideInUp(child: Container(height: 30,  width:double.infinity,color: Colors.lightBlue) ),
                SlideInLeft(child: Container(height: 30,  width:double.infinity,color: Colors.lightBlue) ),
                SlideInRight(child: Container(height: 30,  width:30,color: Colors.lightBlue) ),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                AnimWidget(),
                InkWell(child:
                AnimatedCrossFade(
                  duration: Duration(seconds: 1),
                  crossFadeState: isFirst? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild:  ImageHelper.buildImage("ic_home.png",width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                  secondChild:  ImageHelper.buildImage("ic_home_selector.png",width: 20,height: 20,type: 1,fit: BoxFit.fitHeight),
                ),
                    onTap: (){
                      isFirst = !isFirst;
                      viewModel.notifyUI();
                      ToastUtil.showToast("$type");
                      // viewModel.notifyUI();
                    }),
              ],
            )
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() =>
                RouterHelper.build(context, RouteSettings(name: Routes.test,arguments: {"type": 1}))
              // showBottomSheet(
              // context: context,
              // backgroundColor: Colors.lightGreenAccent,
              // elevation:20,
              // shape: CircleBorder(),
              // builder: (context) {
              //   return Container(height: 30);
              // })
            )
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomSheet(
                      onClosing:(){
                      },
                      builder:(context){
                        return Text("1111");
                      }
                  );
                }))
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("头部").buildInkWell(() => showModalBottomSheet(
                context: context,
                isScrollControlled: false,
                builder: (BuildContext context) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('老孟$index'),
                      );
                    },
                    itemExtent: 50,
                    itemCount: 10,
                  );
                }))
        ),
        WidgetUtils.buildSliverPadding(
            padding: EdgeInsets.all(20.0),
            child: Text("头部11").buildInkWell(() =>  RouterHelper.build(context, RouteSettings(name: Routes.login)))
        ),
      ],
      viewModel: viewModel,
      itemExtent: 100,
      future: ()=>viewModel.loadData(),
      adapter: BaseAdapter<String>(
          data: viewModel.list,
          builder: (context,index,model){
            return Card(child: Text(model),);
          }
      ),

    );
  }


  _tabWidget(){
    return TabPageWidget(
      tabTitles: [
        "11111","22222"
      ],
      pages: [
        LoginPage(),
        MainPage(),
      ],
    );
  }

  @override
  void onPause() {
    print("---- test onPause");
  }

  @override
  void onResume() {
    print("---- test onResume");
  }
}



class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return new PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return  charts.PieChart(seriesList,
        animate: animate,
        behaviors: [
           charts.DatumLegend(
            // Positions for "start" and "end" will be left and right respectively
            // for widgets with a build context that has directionality ltr.
            // For rtl, "start" and "end" will be right and left respectively.
            // Since this example has directionality of ltr, the legend is
            // positioned on the right side of the chart.
            position: charts.BehaviorPosition.end,
            // By default, if the position of the chart is on the left or right of
            // the chart, [horizontalFirst] is set to false. This means that the
            // legend entries will grow as new rows first instead of a new column.
            horizontalFirst: false,
            // This defines the padding around each legend entry.
            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
            // Set [showMeasures] to true to display measures in series legend.
            showMeasures: true,
            // Configure the measure value to be shown by default in the legend.
            legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
            // Optionally provide a measure formatter to format the measure value.
            // If none is specified the value is formatted as a decimal.
            measureFormatter: (num value) {
              return value == null ? '-' : '${value}k';
            },
          ),
        ],
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

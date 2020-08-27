// Packages
import 'package:flutter/material.dart';

// Scoped Model - Main Model
import 'package:FloodIndicator/src/scoped-model/MainModel.dart';

// Chart Widget
import 'LineChart1.dart';
import 'DailyChart.dart';

class HistoryChart extends StatefulWidget {
  final String id;
  final MainModel model;

  HistoryChart({this.id, this.model});

  @override
  _HistoryChartState createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart>{

  DateTime dateTo = DateTime.now();
  DateTime dateFrom = DateTime.now().add(new Duration(days: -30));

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTo)
      setState(() {
        dateTo = picked;
        inputWidget = _inputBuilder(dropdownValue);
      });
  }

  Future<Null> _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateFrom,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateFrom)
      setState(() {
        dateFrom = picked;
        inputWidget = _inputBuilder(dropdownValue);
      });
  }

  String dropdownValue = "Monthly";

  String defaultBtnText = "Last 30 Days";
  Color defaultBtnTextColor = Colors.white;
  Color defaultBtnColor = Colors.pinkAccent;

  String customBtnText = "Custom";
  Color customBtnTextColor = Colors.pinkAccent;
  Color customBtnColor = Colors.white;

  Widget inputWidget = Row();

  Widget defaultBtn = Container();

  @override void initState() {
    defaultBtn = _defaultBtnBuilder("on");
    super.initState();
  }

  @override
   Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget> [
           Row(
             children: <Widget>[
               Text(
                 "History",
                 style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                 ),
               ),
             ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.pinkAccent,
                  ),
                  onChanged: (String newValue) {
                    if(newValue == "Monthly") {
                      widget.model.fetchInputsMonthlyHistory(widget.model.inputById.detectorId, dateFrom, dateTo);
                    } else {
                       widget.model.fetchInputsDailyHistory(widget.model.inputById.detectorId, dateTo);
                    }
                    setState(() {
                      dropdownValue = newValue;
                      customBtnText = "Custom";
                      inputWidget = _inputBuilder("Off");
                      defaultBtnTextColor = Colors.white;
                      defaultBtnColor = Colors.pinkAccent;
                      customBtnTextColor = Colors.pinkAccent;
                      customBtnColor = Colors.white;
                      if(newValue == "Monthly") {
                        defaultBtnText = "Last 30 Days";
                      } else {
                        defaultBtnText = "Today";
                      }
                      defaultBtn = _defaultBtnBuilder("on");
                    });
                  },
                  items: <String>['Monthly', 'Daily']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                defaultBtn,
                inputWidget,
                GestureDetector(
                  onTap: () {
                    if(dateTo.difference(dateFrom).inDays > 30) {
                      dateFrom = DateTime.now().add(new Duration(days: -30));
                      dateTo = DateTime.now();
                      _showAlertDialog();
                    }
                    setState(() {
                      if(customBtnText == "Go") {
                        if(dropdownValue == "Monthly") {
                          widget.model.fetchInputsMonthlyHistory(widget.model.detectorById.id, dateFrom, dateTo);
                        } else {
                          widget.model.fetchInputsDailyHistory(widget.model.inputById.detectorId, dateTo);
                        }
                        inputWidget = _inputBuilder("Off");
                        customBtnText = "Custom";
                        defaultBtnTextColor = Colors.pinkAccent;
                        defaultBtnColor = Colors.white;
                        customBtnTextColor = Colors.white;
                        customBtnColor = Colors.pinkAccent;
                        if(dropdownValue == "Monthly") {
                          defaultBtnText = "Last 30 Days";
                        } else {
                          defaultBtnText = "Today";
                        }
                        defaultBtn = _defaultBtnBuilder("on");
                      }else {
                        defaultBtnText = "Custom";
                        customBtnText = "Go";
                        inputWidget = _inputBuilder(dropdownValue);
                        defaultBtn = _defaultBtnBuilder("off");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                      color: customBtnColor,
                      border: Border.all(
                        color: customBtnTextColor
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Text(
                        customBtnText,
                        style: TextStyle(
                          color: customBtnTextColor,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            _buildChart(widget.model),
         ]
       ),
     );
   }

  Widget _buildChart(MainModel model) {
    Widget content = Text(
      'History: No Data',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.grey
      ),
    );
    if (model.isLoading) { 
      content = Text("Loading...");
    } else if(!model.isLoading && model.inputsById.length > 0) {
      if(dropdownValue == "Monthly") {
        content = LineChart1(inputs: model.inputsById);
      } else {
        content = DailyChart(inputs: model.inputsById);
      }
    }
    return content;
   }

   Widget _defaultBtnBuilder(String show) {
     if (show == "off") {
       return Container();
     } else {
        return GestureDetector(
          onTap: () {
            setState(() {
              if(customBtnText != "Go") {
                dateTo = DateTime.now();
                dateFrom = DateTime.now().add(new Duration(days: -30));
                if(dropdownValue == "Monthly") {
                  widget.model.fetchInputsMonthlyHistory(widget.model.detectorById.id, dateFrom, dateTo);
                } else {
                  widget.model.fetchInputsDailyHistory(widget.model.inputById.detectorId, dateTo);;
                }
                defaultBtnTextColor = Colors.white;
                defaultBtnColor = Colors.pinkAccent;defaultBtn = _defaultBtnBuilder("on");
                customBtnTextColor = Colors.pinkAccent;
                customBtnColor = Colors.white;
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 30,
            decoration: BoxDecoration(
              color: defaultBtnColor,
              border: Border.all(
                color: defaultBtnTextColor
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                defaultBtnText,
                style: TextStyle(
                  color: defaultBtnTextColor,
                  fontSize: 18
                ),
              ),
            ),
          ),
        );
     }
    
   }

   Widget _inputBuilder(String dDown) {
     if(dDown == "Off") {
       return Row(
         children: <Widget>[
           SizedBox(width: 5)
         ],
       );
     } else if (dDown == "Monthly") {
      return Row(
        children: <Widget>[
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              _selectDateFrom(context);
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Colors.pinkAccent))
              ),
              child: Row(
                children: <Widget> [
                  Text(
                    "${dateFrom.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16
                    ),
                  ),
                  SizedBox(width: 2.5),
                  Icon(Icons.calendar_today, color: Colors.grey[700], size: 20,),
                ]
              ),
            ),
          ),
          SizedBox(width: 2.5,),
          SizedBox(width: 2.5,),
          GestureDetector(
            onTap: () {
              _selectDateTo(context);
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Colors.pinkAccent))
              ),
              child: Row(
                children: <Widget> [
                  Text(
                    "${dateTo.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16
                    ),
                  ),
                  SizedBox(width: 2.5),
                  Icon(Icons.calendar_today, color: Colors.grey[700], size: 20),
                ]
              ),
            ),
          ),
          SizedBox(width: 5,),
        ],
      );
     } else {
       return Row(
        children: <Widget>[
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              _selectDateTo(context);
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: Colors.pinkAccent))
              ),
              child: Row(
                children: <Widget> [
                  Text(
                    "${dateTo.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16
                    ),
                  ),
                  SizedBox(width: 2.5),
                  Icon(Icons.calendar_today, color: Colors.grey[700]),
                ]
              ),
            ),
          ),
          SizedBox(width: 5,),
        ],
      );
     } 
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Range'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The maximum value the range is 30 Days, Please choose the dates again.')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
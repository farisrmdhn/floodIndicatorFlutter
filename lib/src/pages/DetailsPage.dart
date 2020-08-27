// Material App
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

// Widgets
import '../widgets/DetailsCard.dart';
import '../widgets/HistoryChart.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _showCard(),
        SizedBox(height: 10),
        _showChart(),
      ],
    );
  }

  Widget _showCard() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Text(
          'No Data',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
        );
        if (model.isLoading) { 
          content = Column(
            children: <Widget>[
              SizedBox(height: 10),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 10),
              Text(
                'Loading ...',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              )
            ],
          );
        } else if(!model.isLoading && model.detectorById != null && model.inputById != null) {
          content = _cardBuilder(model);
        }
        return content;
      }
    );
  }

  Widget _showChart() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = _chartBuilder(model);
        if (model.isLoading) { 
          content = Text("...");
        }
        return content;
      }
    );
  }

  Widget _cardBuilder(MainModel model) {
    return DetailsCard(
      detector: model.detectorById,
      lastInput: model.inputById,
    );
  }

  Widget _chartBuilder(MainModel model) {
    return HistoryChart(model: model);
  }
}
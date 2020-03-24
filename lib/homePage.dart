import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Bulb {
  //double total = kwh * 30;
  //test

}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    myControllerStartRead = TextEditingController();
    myControllerEndRead = TextEditingController();
    myControllerSupplier = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    myControllerStartRead.dispose();
    myControllerEndRead.dispose();
    myControllerSupplier.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  int selectedSupplier;
  //var selectedColor;

  List<DropdownMenuItem<int>> supplierList = [];

// Create the form values
  void loadSupplierList() {
    supplierList = [];
    supplierList.add(new DropdownMenuItem(
      child: new Text('Bulb Energy - VariFair'),
      value: 0,
    ));
    supplierList.add(new DropdownMenuItem(
      child: new Text('Octopus Energy'),
      value: 1,
    ));
    supplierList.add(new DropdownMenuItem(
      child: new Text(
        'Scottish Power',
      ),
      value: 2,
    ));
  }

// Create the form charateristics
  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: new Text('Select Supplier'),
        style: TextStyle(
          color: Colors.black,
        ),
        items: supplierList,
        value: selectedSupplier,
        onChanged: (value) {
          setState(() {
            selectedSupplier = value;

            //selectedColor = Colors.black;
          });
        },
        isExpanded: true,
      ),
    ));

    return formWidget;
  }

  String selectedPeriod = 'Monthly';
  //var selectedColor;

  List<DropdownMenuItem<String>> periodList = [];

// Create the form values
  void loadPeriodList() {
    periodList = [];
    periodList.add(new DropdownMenuItem(
      child: new Text('Yearly'),
      value: 'Yearly',
    ));
    periodList.add(new DropdownMenuItem(
      child: new Text('Monthly'),
      value: 'Monthly',
    ));
    periodList.add(new DropdownMenuItem(
      child: new Text(
        'Weekly',
      ),
      value: 'Weekly',
    ));
  }

  // Create the form charateristics
  List<Widget> getPeriodWidget() {
    List<Widget> periodWidget = new List();

    periodWidget.add(new DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: new Text('Select Period'),
        style: TextStyle(
          color: Colors.black,
        ),
        items: periodList,
        value: selectedPeriod,
        onChanged: (value) {
          setState(() {
            selectedPeriod = value;
            //selectedColor = Colors.black;
          });
        },
        isExpanded: true,
      ),
    ));

    return periodWidget;
  }

  bool electric = false;
  bool gas = false;

//void setState(Null Function() param0) {}

  double padValue = 0;

  // Retrive text with getter
  var myControllerStartRead = TextEditingController();
  var myControllerEndRead = TextEditingController();
  var myControllerSupplier = TextEditingController();

  int startRead = 0;
  int endRead = 0;
  String start = '';
  static int total = 0;

  static double electricKwh = 0.20;
  double standingCharge = 0.26;
  double electricCost = 0;

  electricUsed() {

    if ( selectedPeriod == 'Monthly' && electric == true) {
      return  (total * electricKwh )+ (standingCharge * 30);
      
    } else if (selectedPeriod == 'Weekly'){
      return electricCost / 4;
    } else {
      return (total * electricKwh) * 12;
    }
      
  }

  var _font = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );

//double totalRead = (startRead + endRead) as double;
//int c = int.parse(startRead);
  @override
  Widget build(BuildContext context) {
    loadSupplierList();
    loadPeriodList();

    return Scaffold(
      key: formKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.red],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  child: Text(
                    'Utility Bill Calculator',
                    style: TextStyle(
                      fontSize: 37.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 40, 40, 20),
                child: Container(
                  child: TextField(
                    //autofocus: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.account_balance),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Enter your monthly start read',
                      hintStyle: TextStyle(
                        color: Colors.yellow[400],
                      ),
                      //labelText: "Enter your start read",
                      //labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),

                    keyboardType: TextInputType.number,

                    onChanged: (sRead) {
                      setState(() {
                        start = sRead;
                      });
                    },
                    controller: myControllerStartRead,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Container(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Enter your monthly end read',
                      hintStyle: TextStyle(
                        color: Colors.yellow[400],
                      ),
                      //labelText: "Enter your start read",
                      //labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    keyboardType: TextInputType.number,
                    onChanged: (eRead) {
                      setState(() {
                        endRead = eRead as int;
                      });
                    },
                    controller: myControllerEndRead,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    /*border: Border.all(
                            //color: Colors.yellow,
                            width: 2.0,
                          ),*/
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey[300],
                    ),
                    child: Column(
                      children: <Widget>[
                        Form(
                          child: Column(
                            children: getFormWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    /*border: Border.all(
                            //color: Colors.yellow,
                            width: 2.0,
                          ),*/
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey[300],
                    ),
                    child: Column(
                      children: <Widget>[
                        Form(
                          child: Column(
                            children: getPeriodWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: CheckboxListTile(
                            value: electric,
                            onChanged: (bool value) {
                              setState(() {
                                electric = value;
                              });
                            },
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                              child: Text(
                                'Electric',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            //controlAffinity: ListTileControlAffinity.leading,
                            //checkColor: Colors.orange,
                            activeColor: Colors.purple,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                            child: CheckboxListTile(
                              value: gas,
                              onChanged: (bool value) {
                                setState(() {
                                  gas = value;
                                });
                              },
                              title: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  'Gas',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              //controlAffinity: ListTileControlAffinity.leading,
                              //checkColor: Colors.orange,
                              activeColor: Colors.purple,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 40),
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      child: Text(
                        'Calculate Bill',
                        style: TextStyle(fontSize: 18),
                      ),
                      padding: EdgeInsets.all(10.0),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          startRead = int.parse(myControllerStartRead.text);
                          endRead = int.parse(myControllerEndRead.text);
                          total = endRead - startRead;
                          electricCost = electricUsed();
                          print('Total $total');
                          myControllerStartRead.text;
                          //myControllerStartRead.clear();
                          //myControllerEndRead.clear();
                          //selectedSupplier = null;
                          //selectedPeriod = null;
                          //electric = false;
                          //gas = false;
                        });
                      },
                      splashColor: Colors.purple,
                      height: 45.0,
                      minWidth: 300,
                      highlightElevation: 8,
                      shape: StadiumBorder(
                          //borderRadius: BorderRadius.circular(10),
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                child: Column(children: [
                  //('start $start'),
                  Text(
                    'Start Read $start',
                    style: _font,
                  ),
                  Text(
                    'End Read $endRead',
                    style: _font,
                  ),
                  Text(
                    'Total $total kWH Used',
                    style: _font,
                  ),
                ]),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have selected the $selectedPeriod billing cycle',
                      style: _font,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'You have used £${electricCost.toStringAsFixed(2)} of Electric',
                        
                        style: TextStyle(
                          fontSize: 18.0,color: Colors.purple[900],
                         
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    myControllerStartRead = TextEditingController();
    myControllerEndRead = TextEditingController();
    myControllerSupplier = TextEditingController();
    myControllerPeriod = TextEditingController(text: '0');
    radioBtn = 1;
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    myControllerStartRead.dispose();
    myControllerEndRead.dispose();
    myControllerSupplier.dispose();
    myControllerPeriod.dispose();

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

  double selectedPeriod = 0;

  int radioBtn;

  //double padValue = 0;

  // Retrive text with getter
  var myControllerStartRead = TextEditingController();
  var myControllerEndRead = TextEditingController();
  var myControllerSupplier = TextEditingController();
  var myControllerPeriod = TextEditingController();

  int startRead = 0;
  int endRead = 0;
  String start = '';
  static int total = 0;

  static double electricKwh = 0.20;
  double eSCharge = 0.26;

  double gasM3 = 0.18;
  double gSCharge = 0.20;

  double energyCost = 0;

  energyUsedCalc() {
    if (radioBtn == 1) {
      return (total * electricKwh) + (eSCharge * selectedPeriod);
    } else {
      return (total * gasM3) + (gSCharge * selectedPeriod);
    }
  }

  totalCalcFunction() {
    if (radioBtn == 1) {
      Text('Total $total kWH Used');
    } else {
      Text('Total $total M3 Used');
    }
  }

  var _font = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );

  String cost = '';

  setRadioBtn(int val) {
    setState(() {
      radioBtn = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadSupplierList();

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
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            style: TextStyle(
                              decoration: TextDecoration.none,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (period) {
                              setState(() {
                                selectedPeriod = period as double;
                                print('$selectedPeriod');
                              });
                            },
                            controller: myControllerPeriod,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                        child: Text(
                          'Electric',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Radio(
                        value: 1,
                        groupValue: radioBtn,
                        activeColor: Colors.yellow[400],
                        //focusColor: Colors.white,
                        onChanged: (val) {
                          setRadioBtn(val);
                        }),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Text(
                          'Gas',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Radio(
                        value: 2,
                        groupValue: radioBtn,
                        activeColor: Colors.yellow[400],
                        onChanged: (val) {
                          setRadioBtn(val);
                        }),
                  ],
                ),
              )),
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
                          selectedPeriod =
                              double.parse(myControllerPeriod.text);
                          energyCost = energyUsedCalc();
                          print('Total $total');
                          myControllerStartRead.text;
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
                child: Column(
                  children: [
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
                      ' $total kWH Used',
                      style: _font,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have selected the ${selectedPeriod.toStringAsFixed(2)} billing cycle',
                      style: _font,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'You have used £${energyCost.toStringAsFixed(2)} of Electric',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.purple[900],
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

import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({super.key});

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  // Color myHexColor = Color(#E6E6FA);

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20.5),
          children: [
            Container(
              height: 250,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(255, 227, 219, 228),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total per Person',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      '₹ ${(calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 19),
              child: Divider(
                thickness: 1.5,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.black, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(15.0),
                //backgorundImage
                // image: DecorationImage(
                //     image: AssetImage('assets/images/calbackground.jpeg'),
                //     fit: BoxFit.cover)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          color: Colors.deepPurple,
                        ),
                        hintText: 'Bill Amount'),
                    controller: fieldText,
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 227, 219, 228),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$_personCounter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 227, 219, 228),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tip',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Text(
                              '₹ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '$_tipPercentage%',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      Slider(
                          value: _tipPercentage.toDouble(),
                          min: 0,
                          max: 100,
                          activeColor: Colors.deepPurple,
                          inactiveColor: Colors.grey.shade300,
                          divisions: 20,
                          onChanged: ((value) {
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          })),
                      ElevatedButton.icon(
                        onPressed: _reset,
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        label: Text('Reset',
                            style: TextStyle(color: Colors.white)),
                        // child: Text(
                        //   'Reset',
                        //   style: TextStyle(color: Colors.deepPurple),
                        // ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;
    return totalPerPerson;
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount <= 0 || billAmount.toString().isEmpty) {
      //do nothing
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }

  void _reset() {
    setState(() {
      _billAmount = 0.0;
      _personCounter = 1;
      _tipPercentage = 0;
      fieldText.clear();
    });
  }
}

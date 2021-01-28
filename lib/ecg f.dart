import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:yata_p1/widgets/custom_check_box_one.dart';
import 'package:yata_p1/widgets/dyspne_check_list.dart';

class FEGCInterPage extends StatefulWidget {
  final bool isVisiting;
  final int id;
  final age, sexe, resume, administrateurCode, facture, photoconsultations;
  final palpitaion, synscope, omi, rfcv, douleur, dyspne;
  final etat, temp, ta, poids, atcd, commentaire;
  final String jwtToken;
  final localCacheKey;
  FEGCInterPage({
    this.id = 1,
    this.isVisiting = false,
    this.age,
    this.sexe,
    this.resume,
    this.administrateurCode,
    this.facture,
    this.photoconsultations,
    this.palpitaion,
    this.synscope,
    this.omi,
    this.rfcv,
    this.douleur,
    this.dyspne,
    this.etat = 0,
    this.temp,
    this.ta,
    this.poids,
    this.commentaire,
    this.atcd,
    this.jwtToken,
    this.localCacheKey,
  });

  @override
  State<StatefulWidget> createState() => _FEGCInterPageState();
}

class _FEGCInterPageState extends State<FEGCInterPage> with AutomaticKeepAliveClientMixin {
  String _sexe = 'Masculin';

  TextEditingController codeAdminC = new TextEditingController();
  TextEditingController nFactureC = new TextEditingController();
  TextEditingController resumeC = new TextEditingController();
  TextEditingController ageC = new TextEditingController();
  TextEditingController tempC = new TextEditingController();
  TextEditingController ta1C = new TextEditingController();
  TextEditingController ta2C = new TextEditingController();
  TextEditingController poidsC = new TextEditingController();
  TextEditingController commentaireC = new TextEditingController();
  TextEditingController atcdC = new TextEditingController();

  // CHECKBOXES DATA
  List<bool> frcv = [false, false, false, false, false];
  List<String> frcvTexts = ["HTA", "Diabète", "Tabac", "Obésité", "Dyslpidémie"];

  List<bool> dyspne = [false, false, false, false];
  List<String> dyspneTexts = ["Stade 1", "Stade 2", "Stade 3", "Stade 4"];

  List<bool> douleur = [false, false, false, false, false];
  List<String> douleurTexts = ["Rétro Stérnal", "basi-thoracique", "Hépatalgie d'effort", "médio-thoracique", "Atypique"];

  // YES / NO CHECKBOXES
  bool palpit = false;
  bool synclin = false;
  bool oedmeminf = false;

  int sent = 0;
  int total = 100;
  String uploadMessage = "Upload Consultation";
  Size size;

  loadForVisiting() {
    codeAdminC.text = widget.administrateurCode.toString();
    resumeC.text = widget.resume.toString();
    nFactureC.text = widget.facture.toString();
    ageC.text = widget.age.toString();
    widget.sexe == "H" ? _sexe = "Masculin" : _sexe = "Féminin";
    tempC.text = widget.temp.toString();
    ta1C.text = widget.ta.toString().split("/")[0];
    ta2C.text = widget.ta.toString().split("/")[1];
    poidsC.text = widget.poids.toString();
    atcdC.text = widget.atcd.toString();
    palpit = widget.palpitaion;
    synclin = widget.synscope;
    commentaireC.text = widget.commentaire;
    oedmeminf = widget.omi.toString() == "true";

    // TODO: SUBMIT THE CHEKCBOXES DATA FROM THE CONSTRUCTOR.

    setState(() {});
  }

  endSubscription() async {
    //  CONVERT CHECKBOXES DATA TO JSON.
  }

  void initState() {
    if (widget.isVisiting)
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        loadForVisiting();
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                width: size.width - 20,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        color: Color(0xFF000043),
                                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment: widget.id == null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(CupertinoIcons.back, size: size.width / 20, color: Colors.white),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            Text(
                                              "  Formulaire ECG",
                                              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: size.width / 27.5, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Image.asset('assets/images/services/ecg.png', width: size.width / 4),
                                          Text(
                                            " LECTURE\n électrocardiogramme".toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontFamily: 'bern', fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF000043)),
                                          ),
                                          SizedBox(
                                            width: size.width / 15,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width / 75),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 8,
                                            ),
                                            widget.isVisiting
                                                ? Text(
                                                    "№:  ${widget.id}",
                                                    style:
                                                        TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 32, color: Color(0xFF000043)),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: size.width / 25),
                                        child: Text(
                                          "Renseignements cliniques",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 27.5, color: Color(0xFF000043)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.width / 32,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Age:    ",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 37.5, color: Color(0xFF000043)),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 28,
                                            child: TextField(
                                              enabled: widget.etat < 3,
                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                              style: TextStyle(fontSize: 12),
                                              maxLength: 3,
                                              controller: ageC,
                                              decoration: InputDecoration(
                                                  counterText: '',
                                                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                            ),
                                          ),
                                          Text("  ans",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 37.5, color: Color(0xFF000043))),
                                          SizedBox(width: size.width / 10),
                                          Text("Sexe:    ",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 37.5, color: Color(0xFF000043))),
                                          widget.etat >= 3
                                              ? Text("$_sexe",
                                                  style:
                                                      TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 37.5, color: Color(0xFF000043)))
                                              : DropdownButton<String>(
                                                  value: _sexe,
                                                  elevation: 16,
                                                  style: TextStyle(color: Color(0xFF000043), fontSize: size.width / 37.5),
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      _sexe = newValue;
                                                    });
                                                  },
                                                  items: <String>['Masculin', 'Féminin'].map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      // t ta poids
                                      Row(
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          //mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: size.width / 20,
                                            ),
                                            Text("Constants: ",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF000043))),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "T°:   ",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                      Container(
                                                        width: 138,
                                                        height: 32,
                                                        child: TextField(
                                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                          style: TextStyle(fontSize: 12),
                                                          controller: tempC,
                                                          enabled: widget.etat < 3,
                                                          maxLength: 4,
                                                          maxLines: 1,
                                                          textAlign: TextAlign.right,
                                                          decoration: InputDecoration(
                                                              counterText: '',
                                                              contentPadding: EdgeInsets.only(bottom: 14, right: 4),
                                                              border:
                                                                  UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                                        ),
                                                      ),
                                                      Text(
                                                        "°C",
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "TA:  ",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                      Container(
                                                        width: 64,
                                                        height: 32,
                                                        child: TextField(
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(fontSize: 12),
                                                          controller: ta1C,
                                                          enabled: widget.etat < 3,
                                                          maxLength: 3,
                                                          textAlign: TextAlign.right,
                                                          maxLines: 1,
                                                          decoration: InputDecoration(
                                                              counterText: '',
                                                              contentPadding: EdgeInsets.only(bottom: 14, right: 4),
                                                              border:
                                                                  UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                                        ),
                                                      ),
                                                      Text(
                                                        " / ",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                      Container(
                                                        width: 64,
                                                        height: 32,
                                                        child: TextField(
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(fontSize: 12),
                                                          controller: ta2C,
                                                          enabled: widget.etat < 3,
                                                          maxLength: 3,
                                                          maxLines: 1,
                                                          textAlign: TextAlign.right,
                                                          decoration: InputDecoration(
                                                              counterText: '',
                                                              contentPadding: EdgeInsets.only(bottom: 14, right: 4),
                                                              border:
                                                                  UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                                        ),
                                                      ),
                                                      Text(
                                                        "mmHg",
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Poids:  ",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                      Container(
                                                        width: 128,
                                                        height: 32,
                                                        child: TextField(
                                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                          style: TextStyle(fontSize: 12),
                                                          controller: poidsC,
                                                          enabled: widget.etat < 3,
                                                          maxLength: 4,
                                                          maxLines: 1,
                                                          textAlign: TextAlign.right,
                                                          decoration: InputDecoration(
                                                              counterText: '',
                                                              contentPadding: EdgeInsets.only(bottom: 14, right: 4),
                                                              border:
                                                                  UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Kg",
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Color(0xFF000043)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                ],
                                              ),
                                            )
                                          ]),
                                      SizedBox(height: 20),
                                      // end ttp
                                      //ATCD
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: size.width / 45, bottom: 4, left: size.width / 25),
                                            child:
                                                Text("ATCD:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF000043))),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: size.width / 25,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              controller: atcdC,
                                              style: TextStyle(fontSize: 12),
                                              minLines: 2,
                                              maxLines: 5,
                                              enabled: widget.etat < 3,
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      //end
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              width: 60,
                                              child: Text(
                                                "FRCV: ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043)),
                                              )),
                                          Container(
                                              width: size.width - 60,
                                              child: Wrap(direction: Axis.horizontal, spacing: size.width / 50, children: <Widget>[
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        onChanged: (value) {
                                                          frcv[0] = value;
                                                        },
                                                        etat: widget.etat,
                                                        value: frcv[0],
                                                      ),
                                                    ),
                                                    Text("HTA", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        onChanged: (value) {
                                                          frcv[1] = value;
                                                        },
                                                        etat: widget.etat,
                                                        value: frcv[1],
                                                      ),
                                                    ),
                                                    Text("Diabète", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        onChanged: (value) {
                                                          frcv[2] = value;
                                                        },
                                                        etat: widget.etat,
                                                        value: frcv[2],
                                                      ),
                                                    ),
                                                    Text("Tabac", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        onChanged: (value) {
                                                          frcv[3] = value;
                                                        },
                                                        etat: widget.etat,
                                                        value: frcv[3],
                                                      ),
                                                    ),
                                                    Text("Obésité", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        onChanged: (value) {
                                                          frcv[4] = value;
                                                        },
                                                        etat: widget.etat,
                                                        value: frcv[4],
                                                      ),
                                                    ),
                                                    Text("Dyslipidémie", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                              ])),
                                        ],
                                      ),
                                      SizedBox(height: 18),
                                      Text(
                                        "  Motifs de consultation: ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043)),
                                      ),
                                      Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <
                                          Widget>[
                                        Container(
                                          width: 60,
                                          //                              child: Text("Motifs de consultation: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043)),)
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text("  Dyspnée", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043))),
                                            DyspneCheckList(
                                              size: size,
                                              dyspne: dyspne,
                                              etat: widget.etat,
                                              onChanged: (values) {
                                                dyspne = values;
                                              },
                                            ),
                                            SizedBox(height: 12),
                                            Text("  Douleur", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043))),
                                            Container(
                                              width: size.width - 60,
                                              child: Wrap(direction: Axis.horizontal, spacing: size.width / 50, children: <Widget>[
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        value: douleur[0],
                                                        etat: widget.etat,
                                                        onChanged: (bool a) {
                                                          douleur[0] = a;
                                                        },
                                                      ),
                                                    ),
                                                    Text("Rétro Stérnal", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        value: douleur[1],
                                                        etat: widget.etat,
                                                        onChanged: (bool a) {
                                                          douleur[1] = a;
                                                        },
                                                      ),
                                                    ),
                                                    Text("basi-thoracique", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        value: douleur[2],
                                                        etat: widget.etat,
                                                        onChanged: (bool a) {
                                                          douleur[2] = a;
                                                        },
                                                      ),
                                                    ),
                                                    Text("Hépatalgie d\'effort", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        value: douleur[3],
                                                        etat: widget.etat,
                                                        onChanged: (bool a) {
                                                          douleur[3] = a;
                                                        },
                                                      ),
                                                    ),
                                                    Text("Médio-thoracique", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: CustomCheckBox(
                                                        value: douleur[4],
                                                        etat: widget.etat,
                                                        onChanged: (bool a) {
                                                          douleur[4] = a;
                                                        },
                                                      ),
                                                    ),
                                                    Text("Atypique", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                            SizedBox(height: 12),
                                            Text("  Palpitation",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043))),
                                            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CustomCheckBox(
                                                  value: palpit,
                                                  etat: widget.etat,
                                                  onChanged: (bool a) {
                                                    palpit = a;
                                                  },
                                                ),
                                              ),
                                              Text("Oui", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                              SizedBox(width: size.width / 25),
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CustomCheckBox(
                                                  value: !palpit,
                                                  etat: widget.etat,
                                                  onChanged: (bool a) {
                                                    palpit = !a;
                                                  },
                                                ),
                                              ),
                                              Text("Non", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                              SizedBox(width: size.width / 30),
                                            ]),
                                            SizedBox(height: 12),
                                            Text("  Syncope ou lipothymie",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043))),
                                            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CustomCheckBox(
                                                  value: synclin,
                                                  etat: widget.etat,
                                                  onChanged: (bool a) {
                                                    synclin = a;
                                                  },
                                                ),
                                              ),
                                              Text("Oui", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                              SizedBox(width: size.width / 25),
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CustomCheckBox(
                                                  value: !synclin,
                                                  etat: widget.etat,
                                                  onChanged: (bool a) {
                                                    synclin = !a;
                                                  },
                                                ),
                                              ),
                                              Text("Non", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                              SizedBox(width: size.width / 30),
                                            ]),
                                            SizedBox(height: 12),
                                            Text("  Odèmes des membres inférieurs",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF000043))),
                                            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CustomCheckBox(
                                                  value: oedmeminf,
                                                  etat: widget.etat,
                                                  onChanged: (bool a) {
                                                    oedmeminf = a;
                                                  },
                                                ),
                                              ),
                                              Text("Oui", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                              SizedBox(width: size.width / 25),
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CustomCheckBox(
                                                  value: !oedmeminf,
                                                  etat: widget.etat,
                                                  onChanged: (bool a) {
                                                    oedmeminf = !a;
                                                  },
                                                ),
                                              ),
                                              Text("Non", style: TextStyle(fontSize: 16, color: Color(0xFF000043))),
                                              SizedBox(width: size.width / 30),
                                            ]),
                                          ],
                                        ),
                                      ]),
                                      Padding(
                                        padding: EdgeInsets.only(top: size.width / 25, left: size.width / 20),
                                        child: Text("Résumé Syndromique:",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF000043))),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: size.width / 20, right: size.width / 20),
                                        child: TextField(
                                          minLines: 3,
                                          maxLines: 10,
                                          style: TextStyle(fontSize: 16),
                                          enabled: widget.etat < 3,
                                          controller: resumeC,
                                          decoration:
                                              InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                        ),
                                      ),
                                      SizedBox(height: size.width / 30),
                                      Padding(
                                        padding: EdgeInsets.only(top: size.width / 25, left: size.width / 20),
                                        child: RichText(
                                            text: TextSpan(
                                                text: "Objets",
                                                children: [
                                                  TextSpan(
                                                      text: " (vos questions)",
                                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xFF000043)))
                                                ],
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF000043)))),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: size.width / 20, right: size.width / 20),
                                        child: TextField(
                                          minLines: 1,
                                          maxLines: 999,
                                          style: TextStyle(fontSize: 16),
                                          enabled: widget.etat < 3,
                                          controller: commentaireC,
                                          decoration:
                                              InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFF000043)))),
                                        ),
                                      ),
                                      SizedBox(height: size.width / 40),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              widget.isVisiting
                                                  ? widget.photoconsultations.toString() == "[]"
                                                      ? ""
                                                      : "Les Images:"
                                                  : "Joindre des Images:",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width / 25, color: Color(0xFF000043))),
                                        ],
                                      ),
                                      SizedBox(height: size.width / 20),
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ],
                ),
                bottom: false,
              ),
              extendBody: true,
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

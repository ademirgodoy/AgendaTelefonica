import 'package:flutter/material.dart';
import 'package:agendatelefonica/util/dbhelper.dart';
import 'package:agendatelefonica/model/agenda.dart';

class AgendaPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AgendaPrincipalState();
}

class AgendaPrincipalState extends State<AgendaPrincipal> {
  DbHelper helper = DbHelper();
  List<Agenda> dados;
  int count = 0;

  void getDados() {
    final dbFuture = helper.initializeDb();
    dbFuture.then( (result) {
      final DadosFuture = helper.getAgenda();
      DadosFuture.then( (result) {
        List<Agenda> agendaList = List<Agenda>();
        count = result.length;
        for (int i=0; i<count; i++) {
          agendaList.add(Agenda.fromObject(result[i]));
          debugPrint(agendaList[i].nome);
        }

        setState(() {
          dados = agendaList;
        });
        debugPrint("Items " + count.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nome = TextEditingController();
    TextEditingController telefone = TextEditingController();

    if (dados == null) {
      dados = List<Agenda>();
      getDados();
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
      Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child:  TextField(
        controller: nome,
        decoration: InputDecoration(
            labelText: 'Nome',
            hintText: 'Informe o nome',
            labelStyle: Theme.of(context).textTheme.headline6,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
        ),
        child:  TextField(
          controller: telefone,
          decoration: InputDecoration(
            labelText: 'Telefone',
            hintText: 'Informe o telefone',
            labelStyle: Theme.of(context).textTheme.headline6,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
        ),
        child:  RaisedButton(
          color: Theme.of(context).primaryColorDark,
          textColor: Theme.of(context).primaryColorLight,
          child: Text(
            'Gravar',
            textScaleFactor: 1.5,
          ),
          onPressed: () {
            setState(() {
              if (nome.text == "" || telefone.text == "") {
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Campo Nome ou Telefone está vazio. Dados não gravados."),
                ));
              } else {
                GravarAgenda(nome.text, telefone.text);
                getDados();
              }
            });
          },
        ),
      ),

      Expanded(
        child: AgendaListItems(),
      ),
        ],
     )

    );
  }

  ListView AgendaListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {

        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.dados[position].nome),
            subtitle: Text(this.dados[position].telefone),
            onTap: () {
              debugPrint("Tapped on " + this.dados[position].idAgenda.toString());
            },
          ),
        );
      },
    );
  }

  void GravarAgenda (String nome, String telefone){
       DateTime dataAtual = DateTime.now();
       Agenda reg = Agenda(nome, telefone, dataAtual.toString());
       Future id = helper.insertAgenda(reg);
       id.then( (value) => debugPrint(value.toString()) );
  }

}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';

class ServiceImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        wp: wp,
        text: 'Crear servicio',
        onPressed: () =>
            BlocProvider.of<ServicesBloc>(context).add(OnHandleServiceCreate()),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: BlocListener<ServicesBloc, ServicesState>(
          listenWhen: (previous, current) =>
              previous.isServiceCreated != current.isServiceCreated,
          listener: (_, state) {
            if (state.isServiceCreated == IsServiceCreated.SUCCESS) {
              showAlert(context,
                  title: 'Servicio creado con exito',
                  subtitle: 'Aceptar',
                  child: MainPage());
              BlocProvider.of<ServicesBloc>(context).add(OnCleanServiceData());
            } else if (state.isServiceCreated == IsServiceCreated.FAIL) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Servicio existente"),
                      ));
            } else if (state.isServiceCreated == IsServiceCreated.LOADING) {
              showDialog(
                
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Creando servicio..."),
                      ));
            }
          },
          child: Container(
            child: Column(
              children: [
                _header(context, wp(5)),
                BlocBuilder<ServicesBloc, ServicesState>(
                  builder: (context, state) {
                    return _imageProducts(hp, wp, context, state);
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _header(BuildContext context, double wp) {
    return Material(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context)),
                Text(
                  'Nuevo servicio',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: wp),
                ),
              ],
            ),
            Container(
              height: 30,
              width: 60,
              child: Center(
                  child: Text(
                '2/2',
                style: GoogleFonts.lato(color: kprimarycolorlight),
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _imageProducts(
      Function hp, Function wp, BuildContext context, ServicesState state) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      height: hp(76),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fotos del servicio(Max. 5)',
            style: GoogleFonts.lato(
                color: kdarkcolor,
                fontSize: wp(4),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: hp(3),
          ),
          state.filesService.isNotEmpty
              ? Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.filesService.length,
                    itemBuilder: (context, index) {
                      return MaterialButton(
                        height: hp(8),
                        color: kprimarycolorlight,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => print(''),
                        elevation: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 4,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: wp(5),
                                    backgroundImage: Image.file(
                                      state.filesService[index],
                                    ).image,
                                  ),
                                  SizedBox(width: wp(2),),
                                  Text(
                                    's${index+1}.jpeg',
                                    style: GoogleFonts.lato(fontSize: wp(4),color: kdarkcolor),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: CircleAvatar(
                                backgroundColor: kwrongAnswer,
                                radius: wp(4),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kprimarycolorlight,
                                    size: wp(4),
                                  ),
                                  onPressed: () =>
                                      BlocProvider.of<ServicesBloc>(context)
                                          .add(OnDeleteServiceImage(index)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: hp(3),
                      color: kprimarycolorlight,
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: hp(3),
          ),
          MaterialButton(
            height: hp(6),
            color: kprimarycolorlight,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => state.filesService.length > 4
                ? null
                : BlocProvider.of<ServicesBloc>(context)
                    .add(OnAddServiceImage()),
            elevation: 3,
            child: Row(
              children: [
                Icon(
                  Icons.add_box_rounded,
                  color: Colors.blue,
                ),
                Text(' Añadir foto(s)')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

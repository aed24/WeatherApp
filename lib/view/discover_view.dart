import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/components/discover_cities_button.dart';
import 'package:weather/viewmodel/discover_view_model.dart';



@RoutePage()
class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<DiscoverViewModel>(
                builder: (context, viewModel, child) {
                  return Center(
                    child: Column(
                      children: [
                        TextField(
                          controller: _textController,
                          onChanged: (value) {setState(() {});},
                          decoration: InputDecoration(
                            labelText: 'Metin Girin',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        // Text(viewModel.cityDetails!.cityName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (_textController.text == null || _textController.text== ""|| _textController.text== " ")
                                    ?Column(
                                  children: [
                                    for(var a in viewModel.historyList.reversed)
                                        DiscoverCitiesButton(city: a)
                                  ],
                                )
                                    :Column(
                                  children: [
                                    for(var a in viewModel.cityList)
                                      if(a.cityName.toLowerCase().contains(_textController.text.toLowerCase()))
                                      DiscoverCitiesButton(city: a)
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },)
            ],
          ),
        )

    );
  }
}



import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../news_app_layout/cubit/cubit.dart';
import '../news_app_layout/cubit/states.dart';
import '../shared/components/components.dart';
class SearchScreen  extends StatelessWidget {
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange:(value){
                      NewsCubit.get(context).getSearch(value);

                    },
                    validate: (String? value){
                      if(value==null || value.isEmpty ){
                        return ' search must not be empty';
                      }else
                      {
                        return null ;
                      }

                    },
                    label: 'search',
                    prefix: Icons.search),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),

        );
      },
    );
  }
}

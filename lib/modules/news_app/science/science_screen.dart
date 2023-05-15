import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../news_app_layout/cubit/cubit.dart';
import '../news_app_layout/cubit/states.dart';
import '../shared/components/components.dart';



class ScienceScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener:(context,state){
      },
      builder:(context,state){
        var list = NewsCubit.get(context).science;
        return articleBuilder (list,context);
      },

    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../news_app_layout/cubit/cubit.dart';
import '../../webView/webView_screen.dart';
import '../cubit/cubit.dart';
import '../styles/colors.dart';


Widget defaultButton({
   double width = double.infinity  ,
   Color background = default_color ,
  required Function function ,
  required String text ,
  bool isUpperCase = true ,
  double radius = 0.0,


}) =>  Container(
  width: width,

  // ignore: sort_child_properties_last
  child: MaterialButton(
    onPressed:() {
      function();
    } ,
    child: Text(
      isUpperCase ? text.toUpperCase() : text ,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color:background,
  ),
);

Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  Function? onSubmit ,
  Function? onChange ,
  required FormFieldValidator<String>? validate ,
  required String label,
  required IconData prefix ,
  VoidCallback? onTap ,
  IconData? suffix ,
  Function? suffixPressed ,

  bool isPassword = false,
  
}) => TextFormField(
controller: controller,
keyboardType: type,
obscureText: isPassword,
onFieldSubmitted:(value){

},
onChanged: (val){

},
validator: validate,
onTap:onTap,
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
prefix,
),
suffixIcon: suffix != null ? IconButton(
  onPressed: (){
    suffixPressed!();
  } ,
  icon : Icon(
  
    suffix,
  
  ),
) : null ,
  border: OutlineInputBorder(),
),

);

Widget buildArticleItem(article , context,index) =>  Container(
  color: NewsCubit.get(context).selectBusinessItem==index&&NewsCubit.get(context).isDesktop?Colors.grey[200]:null,
  child: InkWell(
      onTap:(){
        //navigateTo(context,WebViewScreen(article['url']));
        NewsCubit.get(context).selectBusinessItemMethod(index);
      } ,
  child:Padding(
  padding: const EdgeInsets.all(20.0),
      child: Row(
           children: [
                 Container(
                       width: 120.0,
                       height: 120.0,
                       decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                           image: NetworkImage('${article['urlToImage']}'),
                            fit:BoxFit.cover,
                     ), 
                ),
  ),
   const SizedBox( 
    width: 20.0,
   ),
  Expanded(
    child: Container(
      height: 120.0,
      child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
        Expanded(
          child: Text('${article['title']}',
             style: Theme.of(context).textTheme.bodyText1,
              maxLines: 3,
             overflow: TextOverflow.ellipsis,
          ),
  ),
  Text(
  '${article['publishedAt']}',
   style: const TextStyle(
   color: Colors.grey,
  ),
  ),
   ],
   ),),),
   ],
   ),)),
);

Widget myDivider()=> Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Container(
    height: 1.0,
    width: 1.0,
  ),
);

Widget articleBuilder (list,context,{isSearch =false})=>ConditionalBuilder(
  condition: list.length>0,
  builder:(context)=> ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=> buildArticleItem(list[index],context,index) ,
      separatorBuilder:(context,index)=> myDivider(),
      itemCount:list.length ),
  fallback:(context)=> isSearch? Container():const Center(child: CircularProgressIndicator()),

);
void navigateTo(context,widget)=>  Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => widget,
));
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context)=>widget ),
        (route) => false);


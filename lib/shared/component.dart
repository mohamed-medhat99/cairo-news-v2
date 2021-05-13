import 'package:conditional_builder/conditional_builder.dart';
import 'package:egyptnews/modules/webview/webview.dart';
import 'package:flutter/material.dart';


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget ArticlesCard(article , context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(url: article['url'],));
  },
  child:   Container(

        margin: EdgeInsets.only(left: 6, top: 15, right: 6),

        height: 250,

        width: double.infinity,

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.only(

              topLeft: Radius.circular(10),

              topRight: Radius.circular(10),

              bottomLeft: Radius.circular(10),

              bottomRight: Radius.circular(10)),

          boxShadow: [

            BoxShadow(

              color: Colors.grey.withOpacity(0.5),

              spreadRadius: 5,

              blurRadius: 7,

              offset: Offset(0, 3), // changes position of shadow

            ),

          ],

        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(

              height: 150.0,

              width: double.infinity,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.only(

                  topRight: Radius.circular(10),

                  topLeft: Radius.circular(10),

                ),

                image: DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.fitWidth,

                ),

              ),

            ),

            Expanded(

              child: Text(

                '${article['title']}',

                style: Theme.of(context).textTheme.bodyText1,

                maxLines: 3,

              ),

            ),

            Padding(

              padding: EdgeInsets.only(top: 20),

              child: Text(

                '${article['publishedAt']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ),

          ],

        ),

      ),
);
Widget ArticleBuilder(list , context , {isSearch = false})=>ConditionalBuilder(
  condition: list.length > 0  ,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index)=>ArticlesCard(list[index] , context),
    separatorBuilder: (context , index)=>SizedBox(),
    itemCount: list.length,
  ),
  fallback: (context)=>isSearch? Center(
    child: Text('search for any news you want',
    style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),
    ),
  ) : Center(child: CircularProgressIndicator()),
);
void navigateTo (context , widget){

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
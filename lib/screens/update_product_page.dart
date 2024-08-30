import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';

class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({super.key});

  static String id = 'UpdateProductPage';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? productName, desc, image;

  String? price;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Update Product',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      productName = data;
                    },
                    hintText: 'Product Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      desc = data;
                    },
                    hintText: 'description',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      price = data;
                    },
                    hintText: 'price',
                    inputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'image',
                    onChanged: (data) {
                      image = data;
                    },
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  CustomButon(
                      text: 'Update',
                      onTap: () async{
                        isLoading = true;
                        setState(() {});

                        try {
                          await UpdateProduct(product);
                        } catch (e) {
                          print(e.toString());
                        }
                   
                        isLoading = false;
                        setState(() {});
                      }),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> UpdateProduct(ProductModel product) async{
    await UpdateProductService().updateProduct(
        title: productName==null ? product.title:productName!,
        price: price==null ? product.price.toString():price!,
        desc: desc==null ? product.description:desc! ,
        image: image==null ? product.image:image!,
        id: product.id,
        category: product.category);

    isLoading = false;
  }
}

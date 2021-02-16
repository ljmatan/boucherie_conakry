import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PromotionCarouselEntry extends StatelessWidget {
  final Product product;

  PromotionCarouselEntry({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[2],
          color: Colors.white,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CachedNetworkImage(
                    imageUrl: product.images.first.src,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Stack(
                  children: [
                    Text(
                      product.price + ' GNF',
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.price + ' GNF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

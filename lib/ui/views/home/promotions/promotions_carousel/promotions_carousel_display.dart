import 'dart:async';

import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';

import 'entry/promotion_carousel_entry.dart';
import 'bloc/promotion_index_controller.dart';
import 'indicator_dot.dart';
import 'package:flutter/material.dart';

class PromotionsCarousel extends StatefulWidget {
  final Function() showViewAllButton;

  PromotionsCarousel(this.showViewAllButton);

  @override
  State<StatefulWidget> createState() {
    return _PromotionsCarouselState();
  }
}

class _PromotionsCarouselState extends State<PromotionsCarousel> {
  final PageController _pageController = PageController();

  void _addPageControllerListener() => _pageController.addListener(() {
        if (_currentPage != _pageController.page.round()) {
          _timer.cancel();
          _currentPage = _pageController.page.round();
          PromotionIndexController.change(_currentPage);
          _setTimer();
        }
      });

  int _currentPage = 0;
  int _maxExtent;

  Timer _timer;
  void _setTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        if (_currentPage < _maxExtent)
          _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        else
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
      },
    );
  }

  Future<List<Product>> _getFeatured;

  @override
  void initState() {
    super.initState();
    PromotionIndexController.init();
    _getFeatured = WoocommerceAPI.getFeatured().then((products) {
      if (products.isNotEmpty && products.length > 1) {
        _maxExtent = products.length > 4 ? 3 : products.length - 1;
        _setTimer();
        _addPageControllerListener();
      }
      if (products.length > 4) widget.showViewAllButton();
      return products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.66,
        child: FutureBuilder(
          future: _getFeatured,
          initialData: Products.featured,
          builder: (context, products) => products.hasData &&
                  products.data.isNotEmpty
              ? Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      children: [
                        for (var i = 0;
                            i <
                                (products.data.length > 4
                                    ? 4
                                    : products.data.length);
                            i++)
                          PromotionCarouselEntry(product: products.data[i]),
                      ],
                    ),
                    if (products.data.length > 1)
                      Positioned(
                        bottom: 38,
                        right: 28,
                        child: Row(
                          children: [
                            for (var i = 0;
                                i <
                                    (products.data.length > 4
                                        ? 4
                                        : products.data.length);
                                i++)
                              IndicatorDot(index: i),
                          ],
                        ),
                      ),
                  ],
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: products.connectionState != ConnectionState.done
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              products.hasError
                                  ? products.error.toString()
                                  : 'No featured items found',
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    PromotionIndexController.dispose();
    super.dispose();
  }
}

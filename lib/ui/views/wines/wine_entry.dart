import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/global/current_order/order_item_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/html_parsing/string_processing.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/ui/shared/bookmark_button.dart';
import 'add_to_cart_dialog/add_to_card_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WineEntry extends StatefulWidget {
  final Product product;
  final int index;

  WineEntry(
    Key key, {
    @required this.product,
    @required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WineEntryState();
  }
}

class _WineEntryState extends State<WineEntry> {
  String _formattedDescription;

  int _quantity;

  @override
  void initState() {
    super.initState();
    // Description returned from Woocommerce is filled with HTML tags, so
    // some "processing" has to be done
    _formattedDescription = StringProcessing.removeAllHtmlTags(
      widget.product.shortDescription.split('\n').first,
    );

    _formattedDescription = _formattedDescription.replaceAll('&#8220;', '“');
    _formattedDescription = _formattedDescription.replaceAll('&#8221;', '”');
    _formattedDescription = _formattedDescription.replaceAll('&#8217;', '’');
    _formattedDescription = _formattedDescription.replaceAll('&#8230;', '…');

    final OrderItemModel thisItem = CurrentOrder.instance.singleWhere(
      (product) => product.id == widget.product.id,
      orElse: () => null,
    );

    if (thisItem != null) _quantity = thisItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: widget.index == 0 ? 16 : 0,
              bottom: widget.index != 0 ? 16 : 0,
            ),
            child: widget.index == 0 ? null : const Divider(height: 0),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: kElevationToShadow[1],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.images[0].src,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.product.name,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            BookmarkButton(id: widget.product.id.toString()),
                          ],
                        ),
                        Text(
                          int.tryParse(widget.product.price) == null
                              ? 'N/A'
                              : (NumberFormat().format(
                                      int.tryParse(widget.product.price)) +
                                  ' GNF'),
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_formattedDescription != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_formattedDescription),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 16),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: kElevationToShadow[1],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_quantity == null)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(Icons.bubble_chart, size: 16),
                              ),
                            Text(
                              _quantity != null
                                  ? '$_quantity ' + I18N.text('bottles')
                                  : I18N.text('quantity'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Center(
                            child: Icon(
                              _quantity != null ? Icons.close : Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: _quantity != null
                          ? () {
                              CurrentOrder.removeFromOrder(widget.product.id);
                              setState(() => _quantity = null);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              onTap: () async {
                final quantity = await showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (context) => WinesAddToCartDialog(
                    name: widget.product.name,
                    id: widget.product.id,
                    price: int.tryParse(widget.product.price),
                    quantity: _quantity,
                  ),
                );
                if (quantity != null) setState(() => _quantity = quantity);
              },
            ),
          ),
        ],
      ),
    );
  }
}

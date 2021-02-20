import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/global/current_order/order_item_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/ui/shared/bookmark_button.dart';
import 'package:boucherie_conakry/ui/views/specials/add_to_cart/add_to_cart_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'option.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpecialsEntry extends StatefulWidget {
  final Product product;
  final int index;

  SpecialsEntry(Key key, {@required this.product, @required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SpecialsEntryState();
  }
}

class _SpecialsEntryState extends State<SpecialsEntry> {
  List<String> _servings = [];
  String _formattedDescription;

  int _quantity, _persons;

  @override
  void initState() {
    super.initState();
    // Description returned from Woocommerce is filled with HTML tags, so
    // some "processing" has to be done

    // Processes the portion to people ratio
    final String _servingsUnprocessed =
        widget.product.description.split('Pour').last;
    _servings.add(_servingsUnprocessed.substring(1, 2));
    _servings.add(_servingsUnprocessed.substring(5, 6));

    // Processess the description
    _formattedDescription = widget.product.description
        .split('center;">')
        .last
        .split('</')
        .first
        .split('<br />')
        .join(', ')
        .split('\n')
        .join();
    // Validates description output
    RegExp descriptionValidation =
        RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    if (descriptionValidation.hasMatch(_formattedDescription))
      _formattedDescription = null;

    final OrderItemModel thisItem = CurrentOrder.instance.singleWhere(
      (product) => product.id == widget.product.id,
      orElse: () => null,
    );

    if (thisItem != null) {
      _quantity = thisItem.quantity;
      _persons = thisItem.portion;
    }
  }

  void _setQtyAndPersons([Map info]) => setState(() {
        if (info != null) {
          _quantity = info['quantity'];
          _persons = info['persons'];
        } else {
          _quantity = null;
          _persons = null;
        }
      });

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
            height: 110,
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: kElevationToShadow[1],
                  ),
                  child: SizedBox(
                    width: 130,
                    height: 110,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (int.tryParse(_servings[0]) != null &&
                                int.tryParse(_servings[1]) != null)
                              Text(
                                I18N.text('4 to 8'),
                                style: const TextStyle(fontSize: 12),
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
              child: Text(
                '${I18N.text('prepared in restaurant')}, $_formattedDescription',
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 16),
            child: GestureDetector(
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
                    SpecialsOrderOption(
                      amount: _persons,
                      icon: Icons.people,
                      label: I18N.text('persons'),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      child: const SizedBox(width: 0.5, height: 44),
                    ),
                    SpecialsOrderOption(
                      amount: _quantity,
                      icon: Icons.bubble_chart,
                      label: I18N.text('quantity'),
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
                              _quantity == null ? Icons.add : Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: _quantity == null
                          ? null
                          : () {
                              CurrentOrder.removeFromOrder(widget.product.id);
                              _setQtyAndPersons();
                            },
                    ),
                  ],
                ),
              ),
              onTap: () async {
                final info = await showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (context) => SpecialsAddToCart(
                    product: widget.product,
                    quantity: _quantity,
                    persons: _persons,
                  ),
                );
                if (info != null) _setQtyAndPersons(info);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/ui/shared/bookmark_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'option.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpecialsEntry extends StatefulWidget {
  final Product product;
  final int index;

  SpecialsEntry({@required this.product, @required this.index});

  @override
  State<StatefulWidget> createState() {
    return _SpecialsEntryState();
  }
}

class _SpecialsEntryState extends State<SpecialsEntry> {
  List<String> _servings = [];
  String _formattedDescription;

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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.product.name,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Machine incluse',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
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
                                'Pour - ${_servings[0]} à ${_servings[1]} personnes',
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
              child: Text(_formattedDescription),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 16),
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
                    icon: Icons.people,
                    label: 'Personnes',
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: const SizedBox(width: 0.5, height: 44),
                  ),
                  SpecialsOrderOption(
                    icon: Icons.bubble_chart,
                    label: 'Quantité',
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
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

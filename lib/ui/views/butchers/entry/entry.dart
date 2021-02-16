import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/html_parsing/string_processing.dart';
import 'package:boucherie_conakry/ui/shared/bookmark_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ButchersEntry extends StatefulWidget {
  final Product product;
  final int index;

  ButchersEntry(
    Key key, {
    @required this.product,
    @required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ButchersEntryState();
  }
}

class _ButchersEntryState extends State<ButchersEntry> {
  String _formattedDescription;

  @override
  void initState() {
    super.initState();
    // Description returned from Woocommerce is filled with HTML tags, so
    // some "processing" has to be done
    _formattedDescription = StringProcessing.removeAllHtmlTags(
      widget.product.description
          .split('8 personnes')
          .last
          .split('\n')
          .join(', '),
    );

    if (_formattedDescription.startsWith(', '))
      _formattedDescription = _formattedDescription.substring(2);

    if (_formattedDescription.startsWith(
        'Notre boucher a sélectionné pour vous le meilleur de la viande de bœuf.'))
      _formattedDescription = null;
    else if (_formattedDescription.startsWith(
        'Notre boucher a sélectionné pour vous le meilleur de la viande.'))
      _formattedDescription = null;
    else if (_formattedDescription.startsWith(
        'Notre boucher a sélectionné pour vous le meilleur de la volaille.'))
      _formattedDescription = null;
    else if (_formattedDescription.startsWith(
        'Notre boucher a sélectionné pour vous le meilleur de la viande de veau.'))
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
                            Flexible(
                              child: Text(
                                widget.product.name,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
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
                            if (widget.product.description.contains('8'))
                              Text('Pour 4 à 8 personnes')
                            else if (widget.product.defaultAttributes.length >
                                    0 &&
                                widget.product?.defaultAttributes?.first
                                        ?.option !=
                                    null)
                              Text(
                                widget.product.defaultAttributes.first.option,
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
                  Expanded(
                    child: GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.bubble_chart, size: 16),
                            ),
                            Text(
                              'Portion',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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

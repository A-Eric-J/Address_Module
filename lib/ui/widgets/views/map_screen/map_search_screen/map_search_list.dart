import 'package:address_module/ui/widgets/views/map_screen/map_search_screen/map_search_list_item.dart';
import 'package:address_module/ui/widgets/views/map_screen/map_search_screen/map_search_list_item_in_busy_state.dart';
import 'package:flutter/material.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/models/map.dart';

/// [MapSearchList] is list for search results
class MapSearchList extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final int? numberOfChildren;
  final List<MapModel>? addresses;
  final ViewState? state;

  const MapSearchList({
    Key? key,
    this.padding,
    this.numberOfChildren = 12,
    this.addresses,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0.0),
          itemCount:
              state == ViewState.busy ? numberOfChildren : addresses!.length,
          itemBuilder: (context, index) {
            return state == ViewState.busy
                ? const MapSearchListItemInBusyState()
                : MapSearchListItem(address: addresses![index], index: index);
          },
        ));
  }
}

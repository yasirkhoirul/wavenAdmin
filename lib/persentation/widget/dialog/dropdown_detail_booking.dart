import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/domain/entity/photographer_dropdown.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/get_list_addons_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/get_package_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/get_photographer_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/get_university_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

class DropDownAddons extends ConsumerWidget {
  final AsyncValue<ListAddons> stateAddons;
  final Function(Addon) onValues;
  final Function(Addon?) onChanged;
  final List<Addon> selectedAddonIds;
  const DropDownAddons({
    super.key,
    required this.stateAddons,
    required this.selectedAddonIds,
    required this.onValues,
    required this.onChanged,
  });
  Widget _buildStatusChip(
    String label,
    VoidCallback ontap, {
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
          InkWell(
            onTap: ontap,
            child: Icon(Icons.cancel, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      spacing: 10,
      children: [
        ItemDetail(
          judul: "Addon Yang Ada",
          sub: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: selectedAddonIds.isEmpty
                ? Text("Tidak ada extra dipilih")
                : Row(
                    children: selectedAddonIds
                        .map<Widget>(
                          (e) => _buildStatusChip(e.title, () {
                            onValues(e);
                          }, color: MyColor.hijauaccent),
                        )
                        .toList(),
                  ),
          ),
        ),

        ItemDetail(
          judul: "Tambah Extra",
          sub: stateAddons.when(
            data: (addonsData) {
              return DropdownSearch<Addon>(
                itemAsString: (item) => item.title,
                items: (filter, loadProps) {
                  // Trigger search dengan debouncing saat user mengetik
                  if (filter.isNotEmpty) {
                    ref
                        .read(
                          getListAddonsProvider(
                            1,
                            100,
                            search: filter,
                          ).notifier,
                        )
                        .onSearch(1, 100, search: filter);
                  }
                  return addonsData.addons;
                },
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                compareFn: (item1, item2) => item1.id == item2.id,
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Cari Addons",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                dropdownBuilder: (context, selectedItem) {
                  return Text('Pilih Addon');
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
          ),
        ),
      ],
    );
  }
}

class DropDownFotografer extends ConsumerStatefulWidget {
  final AsyncValue<PhotographerDropdown> stateFotografer;
  final Function(PhotographerDropdownItem) onValues;
  final Function(PhotographerDropdownItem?) onChanged;
  final List<PhotographerDropdownItem> selectedPhotographers;
  const DropDownFotografer({
    super.key,
    required this.stateFotografer,
    required this.selectedPhotographers,
    required this.onValues,
    required this.onChanged,
  });

  @override
  ConsumerState<DropDownFotografer> createState() => _DropDownFotograferState();
}

class _DropDownFotograferState extends ConsumerState<DropDownFotografer> {
  PhotographerDropdownItem? selectedPhotographer;
  final fee = TextEditingController();

  

  Widget _buildStatusChip(
    String label,
    VoidCallback ontap, {
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
          InkWell(
            onTap: ontap,
            child: Icon(Icons.cancel, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    fee.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        ItemDetail(
          judul: "Fotografer",
          sub: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: widget.selectedPhotographers.isEmpty
                ? SizedBox(
                  height: 50,
                  child: Center(child: Text("Tidak ada fotografer dipilih")))
                : Row(
                    children: widget.selectedPhotographers
                        .map<Widget>(
                          (e) => _buildStatusChip(e.name, () {
                            widget.onValues(e);
                          }, color: MyColor.birutua),
                        )
                        .toList(),
                  ),
          ),
        ),

        Row(
          children: [
            Expanded(
              child: ItemDetail(
                judul: "Tambah Fotografer",
                sub: widget.stateFotografer.when(
                  data: (addonsData) {
                    return DropdownSearch<PhotographerDropdownItem>(
                      itemAsString: (item) =>
                          "${item.name}, fee : ${item.feePerHour} ",
                      items: (filter, loadProps) {
                        // Trigger search dengan debouncing saat user mengetik
                        if (filter.isNotEmpty) {
                          ref
                              .read(
                                getPhotographerDropdownProvider(
                                  1,
                                  100,
                                  search: filter,
                                ).notifier,
                              )
                              .onSearch(1, 100, search: filter);
                        }
                        return addonsData.photographers;
                      },
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedPhotographer = value;
                            fee.text = value.feePerHour.toString();
                          });
                        }
                      },
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Cari Fotografer",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return Text(selectedItem?.name ?? 'Pilih Fotografer');
                      },
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text('Error: $error'),
                ),
              ),
            ),
            Expanded(
              child: ItemDetailInputOutlineGreenText(judul: "Fee", controller: fee,keyboardType: TextInputType.number,textInputFormatter: [FilteringTextInputFormatter.digitsOnly],validator: (value) {
                if (value == null||value.isEmpty) {
                  return 'tidak boleh kosong';
                }
                return null;
              },),
            )
          ],
        ),
        MediaQuery.of(context).size.width>700?  LBUttonMobile(ontap: () {
          if (selectedPhotographer?.id == null||fee.text.isEmpty) return;
          widget.onChanged(PhotographerDropdownItem(
            id: selectedPhotographer!.id,
            name: selectedPhotographer!.name,
            feePerHour: int.parse(fee.text)
          ));
        }, teks: "Tambah"):LBUttonMobile(ontap: () {
          if (selectedPhotographer?.id == null||fee.text.isEmpty) return;
          widget.onChanged(PhotographerDropdownItem(
            id: selectedPhotographer!.id,
            name: selectedPhotographer!.name,
            feePerHour: int.parse(fee.text)
          ));
        }, teks: "Tambah")
      ],
    );
  }
}

class DropDownUniv extends ConsumerWidget {
  final AsyncValue<UniversityDropdown> stateUniversitas;
  final Function(University?) onChanged;
  final University? selectedUniv;
  const DropDownUniv({
    super.key,
    required this.stateUniversitas,
    required this.selectedUniv,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context, ref) {
    return ItemDetail(
      judul: "Universitas",
      sub: stateUniversitas.when(
        data: (univstate) {
          return DropdownSearch<University>(
            selectedItem: selectedUniv,
            itemAsString: (item) => item.name,
            items: (filter, loadProps) {
              // Trigger search dengan debouncing saat user mengetik
              if (filter.isNotEmpty) {
                ref
                    .read(
                      getUniversityDropdownProvider(
                        1,
                        100,
                        search: filter,
                      ).notifier,
                    )
                    .onSearch(1, 100, search: filter);
              }
              return univstate.universities;
            },
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari Universitas",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?.name ?? 'Cari Universitas');
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}

class DropdownPackage extends ConsumerWidget {
  final AsyncValue<PackageDropdown> statePackage;
  final Function(Package?) onChanged;
  final Package? selectedPackage;
  const DropdownPackage({
    super.key,
    required this.statePackage,
    required this.selectedPackage,

    required this.onChanged,
  });
  @override
  Widget build(BuildContext context, ref) {
    return ItemDetail(
      judul: "Package",
      sub: statePackage.when(
        data: (package) {
          return DropdownSearch<Package>(
            selectedItem: selectedPackage,
            itemAsString: (item) => item.title,
            items: (filter, loadProps) {
              // Trigger search dengan debouncing saat user mengetik
              if (filter.isNotEmpty) {
                ref
                    .read(
                      getPackageDropdownProvider(
                        1,
                        100,
                        search: filter,
                      ).notifier,
                    )
                    .onSearch(1, 100, search: filter);
              }
              return package.packages;
            },
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Cari Package",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?.title ?? 'Cari Package');
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/cubit/auth_cubit.dart';

class MainScaffoldDrawer extends StatelessWidget {
  final StatefulNavigationShell statefulNavigationShell;
  const MainScaffoldDrawer({super.key, required this.statefulNavigationShell});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
      children: [
        ItemSideNavigation(
              judul: "Dashboard",
              aset: MyIcon.icondashboard,
              isActive: statefulNavigationShell.currentIndex == 0,
              onTap: () => statefulNavigationShell.goBranch(0),
            ),
            kIsWeb? Container(): ItemSideNavigation(
              judul: "Find Edited Photo",
              aset: MyIcon.iconpengaturan,
              isActive: statefulNavigationShell.currentIndex == 1,
              onTap: () => statefulNavigationShell.goBranch(1),
            ),
            ItemSideNavigationDropdown(
              judul: "Manajemen Client",
              aset: MyIcon.iconmanajemenclien,
              isActive: false,
              subitem: [
                ItemSideNavigation(
                  judul: "Schedule",
                  isActive: statefulNavigationShell.currentIndex == 3,
                  onTap: () => statefulNavigationShell.goBranch(3),
                  aset: MyIcon.iconmanajemenclien,
                ),
                ItemSideNavigation(
                  judul: "client",
                  isActive: statefulNavigationShell.currentIndex == 2,
                  onTap: () => statefulNavigationShell.goBranch(2),
                  aset: MyIcon.iconmanajemenclien,
                ),
              ],
            ),
            ItemSideNavigationDropdown(
              judul: "User Management",
              isActive: false,
              aset: MyIcon.iconusers,
              subitem: [
                ItemSideNavigation(
                  judul: "User",
                  isActive: statefulNavigationShell.currentIndex == 4,
                  onTap: () => statefulNavigationShell.goBranch(4),
                  aset: MyIcon.iconusers,
                ),
                ItemSideNavigation(
                  judul: "Admin",
                  isActive: statefulNavigationShell.currentIndex == 5,
                  onTap: () => statefulNavigationShell.goBranch(5),
                  aset: MyIcon.iconusers,
                ),
                ItemSideNavigation(
                  judul: "Photographer",
                  isActive: statefulNavigationShell.currentIndex == 6,
                  onTap: () => statefulNavigationShell.goBranch(6),
                  aset: MyIcon.iconusers,
                ),
              ],
            ),
            ItemSideNavigationDropdown(
              judul: "Reference Settings",
              isActive: false,
              aset: MyIcon.iconreferensi,
              subitem: [
                ItemSideNavigation(
                  judul: "Universitas",
                  isActive: statefulNavigationShell.currentIndex == 7,
                  onTap: () => statefulNavigationShell.goBranch(7),
                  aset: MyIcon.iconreferensi,
                ),
                ItemSideNavigation(
                  judul: "Package",
                  isActive: statefulNavigationShell.currentIndex == 8,
                  onTap: () => statefulNavigationShell.goBranch(8),
                  aset: MyIcon.iconreferensi,
                ),
                ItemSideNavigation(
                  judul: "Photographer",
                  isActive: statefulNavigationShell.currentIndex == 9,
                  onTap: () => statefulNavigationShell.goBranch(9),
                  aset: MyIcon.iconreferensi,
                ),
                ItemSideNavigation(
                  judul: "Addons",
                  isActive: statefulNavigationShell.currentIndex == 10,
                  onTap: () => statefulNavigationShell.goBranch(10),
                  aset: MyIcon.iconreferensi,
                ),
              ],
            ),
            ItemSideNavigation(
              judul: "Setting",
              isActive: statefulNavigationShell.currentIndex == 11,
              onTap: () => statefulNavigationShell.goBranch(11),
              aset: MyIcon.iconpengaturan,
            ),
            ItemSideNavigation(
              judul: "Logout",
              isActive: false,
              onTap: () {
                context.read<AuthCubit>().logOut();
              },
              aset: MyIcon.iconcancel,
            ),
      ],
    ));
  }
}

class SideNavigation extends StatelessWidget {
  final StatefulNavigationShell statefulNavigationShell;
  const SideNavigation({super.key, required this.statefulNavigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ListView(
          children: [
            ItemSideNavigation(
              judul: "Dashboard",
              aset: MyIcon.icondashboard,
              isActive: statefulNavigationShell.currentIndex == 0,
              onTap: () => statefulNavigationShell.goBranch(0),
            ),
            kIsWeb? Container(): ItemSideNavigation(
              judul: "Find Edited Photo",
              aset: MyIcon.iconpengaturan,
              isActive: statefulNavigationShell.currentIndex == 1,
              onTap: () => statefulNavigationShell.goBranch(1),
            ),
            ItemSideNavigationDropdown(
              judul: "Manajemen Client",
              aset: MyIcon.iconmanajemenclien,
              isActive: false,
              subitem: [
                ItemSideNavigation(
                  judul: "Schedule",
                  isActive: statefulNavigationShell.currentIndex == 3,
                  onTap: () => statefulNavigationShell.goBranch(3),
                  aset: MyIcon.iconmanajemenclien,
                ),
                ItemSideNavigation(
                  judul: "client",
                  isActive: statefulNavigationShell.currentIndex == 2,
                  onTap: () => statefulNavigationShell.goBranch(2),
                  aset: MyIcon.iconmanajemenclien,
                ),
              ],
            ),
            ItemSideNavigationDropdown(
              judul: "User Management",
              isActive: false,
              aset: MyIcon.iconusers,
              subitem: [
                ItemSideNavigation(
                  judul: "User",
                  isActive: statefulNavigationShell.currentIndex == 4,
                  onTap: () => statefulNavigationShell.goBranch(4),
                  aset: MyIcon.iconusers,
                ),
                ItemSideNavigation(
                  judul: "Admin",
                  isActive: statefulNavigationShell.currentIndex == 5,
                  onTap: () => statefulNavigationShell.goBranch(5),
                  aset: MyIcon.iconusers,
                ),
                ItemSideNavigation(
                  judul: "Photographer",
                  isActive: statefulNavigationShell.currentIndex == 6,
                  onTap: () => statefulNavigationShell.goBranch(6),
                  aset: MyIcon.iconusers,
                ),
              ],
            ),
            ItemSideNavigationDropdown(
              judul: "Reference Settings",
              isActive: false,
              aset: MyIcon.iconreferensi,
              subitem: [
                ItemSideNavigation(
                  judul: "Universitas",
                  isActive: statefulNavigationShell.currentIndex == 7,
                  onTap: () => statefulNavigationShell.goBranch(7),
                  aset: MyIcon.iconreferensi,
                ),
                ItemSideNavigation(
                  judul: "Package",
                  isActive: statefulNavigationShell.currentIndex == 8,
                  onTap: () => statefulNavigationShell.goBranch(8),
                  aset: MyIcon.iconreferensi,
                ),
                ItemSideNavigation(
                  judul: "Photographer",
                  isActive: statefulNavigationShell.currentIndex == 9,
                  onTap: () => statefulNavigationShell.goBranch(9),
                  aset: MyIcon.iconreferensi,
                ),
                ItemSideNavigation(
                  judul: "Addons",
                  isActive: statefulNavigationShell.currentIndex == 10,
                  onTap: () => statefulNavigationShell.goBranch(10),
                  aset: MyIcon.iconreferensi,
                ),
              ],
            ),
            ItemSideNavigation(
              judul: "Setting",
              isActive: statefulNavigationShell.currentIndex == 11,
              onTap: () => statefulNavigationShell.goBranch(11),
              aset: MyIcon.iconpengaturan,
            ),
            ItemSideNavigation(
              judul: "Logout",
              isActive: false,
              onTap: () {
                context.read<AuthCubit>().logOut();
              },
              aset: MyIcon.iconcancel,
            ),
          ],
        );
      },
    );
  }
}

class ItemSideNavigation extends StatelessWidget {
  final String judul;
  final bool isActive;
  final VoidCallback onTap;
  final String aset;

  const ItemSideNavigation({
    super.key,
    required this.judul,
    required this.isActive,
    required this.onTap,
    required this.aset,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: isActive ? Colors.white : MyColor.hijauaccent,
        end: isActive ? MyColor.hijauaccent : Colors.white,
      ),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      builder: (context, animatedColor, child) {
        return ListTile(
          iconColor: animatedColor,
          leading: SvgPicture.asset(
            aset,
            colorFilter: ColorFilter.mode(
              animatedColor ?? Colors.white,
              BlendMode.srcIn,
            ),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: GoogleFonts.publicSans(color: animatedColor),
            child: Text(judul),
          ),
          onTap: onTap,
          selectedTileColor: MyColor.hijauaccent.withOpacity(
            isActive ? 0.15 : 0.0,
          ),
          selected: isActive,
        );
      },
    );
  }
}

class ItemSideNavigationDropdown extends StatefulWidget {
  final String judul;
  final bool isActive;
  final String aset;
  final List<Widget>? subitem;
  const ItemSideNavigationDropdown({
    super.key,
    required this.judul,
    required this.isActive,
    required this.aset,
    this.subitem,
  });

  @override
  State<ItemSideNavigationDropdown> createState() =>
      _ItemSideNavigationDropdownState();
}

class _ItemSideNavigationDropdownState
    extends State<ItemSideNavigationDropdown> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: show || widget.isActive ? Colors.white : MyColor.hijauaccent,
        end: show || widget.isActive ? MyColor.hijauaccent : Colors.white,
      ),
      builder: (context, value, child) => Column(
        children: [
          ListTile(
            iconColor: value,
            leading: SvgPicture.asset(
              widget.aset,
              colorFilter: ColorFilter.mode(
                value ?? Colors.white,
                BlendMode.srcIn,
              ),
            ),
            title: AnimatedDefaultTextStyle(
              style: GoogleFonts.publicSans(color: value),
              duration: const Duration(milliseconds: 250),
              child: Text(widget.judul),
            ),
            onTap: () {
              setState(() {
                show = !show;
              });
            },
            selectedTileColor: MyColor.hijauaccent,
            selected: widget.isActive,
            trailing: AnimatedRotation(
              turns: show ? 0.5 : 0, // 0.5 = 180 derajat
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: show && widget.subitem != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.subitem!,
                    ),
                  )
                : const SizedBox.shrink(), // animasi collapse
          ),
        ],
      ),
      duration: const Duration(milliseconds: 250),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// 默认图标颜色
const Color _defaultIconColor = Color(0xFF21417B);

/// 默认图标尺寸
const double _defaultIconSize = 24.0;

/// 正方形图标基座：固定宽高为 [size]，内部居中绘制图标，可传 [color] 与 [size]。
class _SquareIcon extends StatelessWidget {
  const _SquareIcon({required this.icon, this.color, this.size});

  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final IconThemeData theme = Theme.of(context).iconTheme;
    final Color color = this.color ?? theme.color ?? _defaultIconColor;
    final double size = this.size ?? theme.size ?? _defaultIconSize;

    return SizedBox(width: size, height: size, child: Center(child: FaIcon(icon, color: color, size: size)));
  }
}

// --- 全局图标组件（正方形，默认颜色 #21417B，默认尺寸 24，命名格式 XxxIcon）---

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final IconThemeData theme = Theme.of(context).iconTheme;
    final Color color = this.color ?? theme.color ?? _defaultIconColor;
    final double size = this.size ?? theme.size ?? _defaultIconSize;
    return Center(
      child: SizedBox(width: size, height: size, child: CircularProgressIndicator(strokeWidth: 2, color: color)),
    );
  }
}

class ChevronLeftIcon extends StatelessWidget {
  const ChevronLeftIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.chevronLeft, color: color, size: size);
}

class ChevronRightIcon extends StatelessWidget {
  const ChevronRightIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.chevronRight, color: color, size: size);
}

class ChevronUpIcon extends StatelessWidget {
  const ChevronUpIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.chevronUp, color: color, size: size);
}

class ChevronDownIcon extends StatelessWidget {
  const ChevronDownIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.chevronDown, color: color, size: size);
}

class HouseIcon extends StatelessWidget {
  const HouseIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.house, color: color, size: size);
}

class CubesIcon extends StatelessWidget {
  const CubesIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.cubes, color: color, size: size);
}

class ChartLineIcon extends StatelessWidget {
  const ChartLineIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.chartLine, color: color, size: size);
}

class CalculatorIcon extends StatelessWidget {
  const CalculatorIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.calculator, color: color, size: size);
}

class MoonIcon extends StatelessWidget {
  const MoonIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.moon, color: color, size: size);
}

class UtensilsIcon extends StatelessWidget {
  const UtensilsIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.utensils, color: color, size: size);
}

class CalendarDaysIcon extends StatelessWidget {
  const CalendarDaysIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.calendarDays, color: color, size: size);
}

class ListUlIcon extends StatelessWidget {
  const ListUlIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.listUl, color: color, size: size);
}

class ChartBarIcon extends StatelessWidget {
  const ChartBarIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.chartBar, color: color, size: size);
}

class UserIcon extends StatelessWidget {
  const UserIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.user, color: color, size: size);
}

class UsersIcon extends StatelessWidget {
  const UsersIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) =>
      _SquareIcon(icon: FontAwesomeIcons.users, color: color, size: size != null ? size! * 0.75 : null);
}

class FileLinesIcon extends StatelessWidget {
  const FileLinesIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.fileLines, color: color, size: size);
}

class PenToSquareIcon extends StatelessWidget {
  const PenToSquareIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.penToSquare, color: color, size: size);
}

class CalendarCheckIcon extends StatelessWidget {
  const CalendarCheckIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.calendarCheck, color: color, size: size);
}

class ClockIcon extends StatelessWidget {
  const ClockIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.clock, color: color, size: size);
}

class BriefcaseIcon extends StatelessWidget {
  const BriefcaseIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) => _SquareIcon(icon: FontAwesomeIcons.briefcase, color: color, size: size);
}

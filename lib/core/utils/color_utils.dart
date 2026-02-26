import 'package:flutter/material.dart';

/// 颜色工具：通过亮度、饱和度、RGB 等调整得到新颜色
class ColorUtils {
  ColorUtils._();

  // --- RGB / Alpha 调整 ---

  /// 设置新的红色分量 [0, 255]
  static Color withRed(Color color, int red) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      red.clamp(0, 255),
      (color.g * 255).round().clamp(0, 255),
      (color.b * 255).round().clamp(0, 255),
    );
  }

  /// 设置新的绿色分量 [0, 255]
  static Color withGreen(Color color, int green) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (color.r * 255).round().clamp(0, 255),
      green.clamp(0, 255),
      (color.b * 255).round().clamp(0, 255),
    );
  }

  /// 设置新的蓝色分量 [0, 255]
  static Color withBlue(Color color, int blue) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (color.r * 255).round().clamp(0, 255),
      (color.g * 255).round().clamp(0, 255),
      blue.clamp(0, 255),
    );
  }

  /// 设置新的透明度 [0.0, 1.0]
  static Color withAlpha(Color color, double alpha) {
    return color.withAlpha((alpha.clamp(0.0, 1.0) * 255).round());
  }

  /// 按比例缩放 RGB 各分量，[scale] 通常为 0.0～1.0 或 >1 提亮
  static Color scaleRgb(Color color, double scale) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (color.r * 255 * scale).round().clamp(0, 255),
      (color.g * 255 * scale).round().clamp(0, 255),
      (color.b * 255 * scale).round().clamp(0, 255),
    );
  }

  /// 对 RGB 各分量加上偏移 [delta]，可正可负
  static Color shiftRgb(Color color, int delta) {
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (r + delta).clamp(0, 255),
      (g + delta).clamp(0, 255),
      (b + delta).clamp(0, 255),
    );
  }

  // --- HSL 亮度 / 饱和度 ---

  /// 设置新的亮度（HSL 的 L）[0.0, 1.0]
  static Color withBrightness(Color color, double lightness) {
    final hsl = _rgbToHsl(
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
    final rgb = _hslToRgb(hsl.$1, hsl.$2, lightness.clamp(0.0, 1.0));
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      rgb.$1,
      rgb.$2,
      rgb.$3,
    );
  }

  /// 在原有亮度上增加 [delta]，正数变亮、负数变暗，结果限制在 [0, 1]
  static Color adjustBrightness(Color color, double delta) {
    final hsl = _rgbToHsl(
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
    final newL = (hsl.$3 + delta).clamp(0.0, 1.0);
    final rgb = _hslToRgb(hsl.$1, hsl.$2, newL);
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      rgb.$1,
      rgb.$2,
      rgb.$3,
    );
  }

  /// 设置新的饱和度（HSL 的 S）[0.0, 1.0]
  static Color withSaturation(Color color, double saturation) {
    final hsl = _rgbToHsl(
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
    final rgb = _hslToRgb(hsl.$1, saturation.clamp(0.0, 1.0), hsl.$3);
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      rgb.$1,
      rgb.$2,
      rgb.$3,
    );
  }

  /// 在原有饱和度上增加 [delta]，结果限制在 [0, 1]
  static Color adjustSaturation(Color color, double delta) {
    final hsl = _rgbToHsl(
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
    final newS = (hsl.$2 + delta).clamp(0.0, 1.0);
    final rgb = _hslToRgb(hsl.$1, newS, hsl.$3);
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      rgb.$1,
      rgb.$2,
      rgb.$3,
    );
  }

  /// 设置新的色相（HSL 的 H）[0.0, 360.0] 或 [0.0, 1.0] 按需使用
  static Color withHue(Color color, double hue) {
    final h = hue % 360.0;
    final hsl = _rgbToHsl(
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
    final rgb = _hslToRgb(h, hsl.$2, hsl.$3);
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      rgb.$1,
      rgb.$2,
      rgb.$3,
    );
  }

  /// 在原有色相上增加 [delta] 度
  static Color adjustHue(Color color, double delta) {
    final hsl = _rgbToHsl(
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
    final newH = (hsl.$1 + delta) % 360.0;
    final rgb = _hslToRgb(newH, hsl.$2, hsl.$3);
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      rgb.$1,
      rgb.$2,
      rgb.$3,
    );
  }

  // --- 综合：一次设置多项 ---

  /// 通过可选参数一次性调整亮度、饱和度、RGB 等，未传的项保持原色不变
  static Color copyWith({
    required Color color,
    int? red,
    int? green,
    int? blue,
    double? alpha,
    double? brightness,
    double? saturation,
    double? hue,
  }) {
    int r = (color.r * 255).round().clamp(0, 255);
    int g = (color.g * 255).round().clamp(0, 255);
    int b = (color.b * 255).round().clamp(0, 255);
    int a = (color.a * 255).round().clamp(0, 255);

    if (red != null) r = red.clamp(0, 255);
    if (green != null) g = green.clamp(0, 255);
    if (blue != null) b = blue.clamp(0, 255);
    if (alpha != null) a = (alpha.clamp(0.0, 1.0) * 255).round();

    if (brightness != null || saturation != null || hue != null) {
      final hsl = _rgbToHsl(r, g, b);
      final h = hue ?? hsl.$1;
      final s = saturation ?? hsl.$2;
      final l = brightness ?? hsl.$3;
      final rgb = _hslToRgb(h, s.clamp(0.0, 1.0), l.clamp(0.0, 1.0));
      r = rgb.$1;
      g = rgb.$2;
      b = rgb.$3;
    }

    return Color.fromARGB(a, r, g, b);
  }

  // --- RGB <-> HSL 内部转换 ---

  /// (H, S, L), H in [0, 360], S/L in [0, 1]
  static (double, double, double) _rgbToHsl(int r, int g, int b) {
    final rr = r / 255.0;
    final gg = g / 255.0;
    final bb = b / 255.0;
    final max = [rr, gg, bb].reduce((a, x) => a > x ? a : x);
    final min = [rr, gg, bb].reduce((a, x) => a < x ? a : x);
    final l = (max + min) / 2.0;

    double h;
    double s;
    if (max == min) {
      h = 0.0;
      s = 0.0;
    } else {
      final d = max - min;
      s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
      if (max == rr) {
        h = (gg - bb) / d + (gg < bb ? 6.0 : 0.0);
      } else if (max == gg) {
        h = (bb - rr) / d + 2.0;
      } else {
        h = (rr - gg) / d + 4.0;
      }
      h = h / 6.0;
    }
    return (h * 360.0, s, l);
  }

  /// H in [0, 360], S/L in [0, 1] -> (R, G, B) in 0-255
  static (int, int, int) _hslToRgb(double h, double s, double l) {
    h = h / 360.0;
    double r, g, b;
    if (s == 0.0) {
      r = g = b = l;
    } else {
      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = _hueToRgb(p, q, h + 1 / 3.0);
      g = _hueToRgb(p, q, h);
      b = _hueToRgb(p, q, h - 1 / 3.0);
    }
    return (
      (r * 255).round().clamp(0, 255),
      (g * 255).round().clamp(0, 255),
      (b * 255).round().clamp(0, 255),
    );
  }

  static double _hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }
}

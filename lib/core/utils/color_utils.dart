import 'package:flutter/material.dart';

/// 色ユーティリティ：明度・彩度・RGB などを調整して新しい色を生成します
class ColorUtils {
  ColorUtils._();

  // --- RGB / アルファ調整 ---

  /// 赤成分を設定します [0, 255]
  static Color withRed(Color color, int red) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      red.clamp(0, 255),
      (color.g * 255).round().clamp(0, 255),
      (color.b * 255).round().clamp(0, 255),
    );
  }

  /// 緑成分を設定します [0, 255]
  static Color withGreen(Color color, int green) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (color.r * 255).round().clamp(0, 255),
      green.clamp(0, 255),
      (color.b * 255).round().clamp(0, 255),
    );
  }

  /// 青成分を設定します [0, 255]
  static Color withBlue(Color color, int blue) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (color.r * 255).round().clamp(0, 255),
      (color.g * 255).round().clamp(0, 255),
      blue.clamp(0, 255),
    );
  }

  /// 透明度を設定します [0.0, 1.0]
  static Color withAlpha(Color color, double alpha) {
    return color.withAlpha((alpha.clamp(0.0, 1.0) * 255).round());
  }

  /// RGB 各成分を比率でスケールします（[scale] は通常 0.0〜1.0、>1 で明るくします）
  static Color scaleRgb(Color color, double scale) {
    return Color.fromARGB(
      (color.a * 255).round().clamp(0, 255),
      (color.r * 255 * scale).round().clamp(0, 255),
      (color.g * 255 * scale).round().clamp(0, 255),
      (color.b * 255 * scale).round().clamp(0, 255),
    );
  }

  /// RGB 各成分にオフセット [delta] を加算します（正/負どちらも可）
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

  // --- HSL（明度 / 彩度）---

  /// 明度（HSL の L）を設定します [0.0, 1.0]
  static Color withBrightness(Color color, double lightness) {
    final hsl = _rgbToHsl((color.r * 255).round(), (color.g * 255).round(), (color.b * 255).round());
    final rgb = _hslToRgb(hsl.$1, hsl.$2, lightness.clamp(0.0, 1.0));
    return Color.fromARGB((color.a * 255).round().clamp(0, 255), rgb.$1, rgb.$2, rgb.$3);
  }

  /// 現在の明度に [delta] を加算します（正で明るく、負で暗く。結果は [0, 1] に制限）
  static Color adjustBrightness(Color color, double delta) {
    final hsl = _rgbToHsl((color.r * 255).round(), (color.g * 255).round(), (color.b * 255).round());
    final newL = (hsl.$3 + delta).clamp(0.0, 1.0);
    final rgb = _hslToRgb(hsl.$1, hsl.$2, newL);
    return Color.fromARGB((color.a * 255).round().clamp(0, 255), rgb.$1, rgb.$2, rgb.$3);
  }

  /// 彩度（HSL の S）を設定します [0.0, 1.0]
  static Color withSaturation(Color color, double saturation) {
    final hsl = _rgbToHsl((color.r * 255).round(), (color.g * 255).round(), (color.b * 255).round());
    final rgb = _hslToRgb(hsl.$1, saturation.clamp(0.0, 1.0), hsl.$3);
    return Color.fromARGB((color.a * 255).round().clamp(0, 255), rgb.$1, rgb.$2, rgb.$3);
  }

  /// 現在の彩度に [delta] を加算します（結果は [0, 1] に制限）
  static Color adjustSaturation(Color color, double delta) {
    final hsl = _rgbToHsl((color.r * 255).round(), (color.g * 255).round(), (color.b * 255).round());
    final newS = (hsl.$2 + delta).clamp(0.0, 1.0);
    final rgb = _hslToRgb(hsl.$1, newS, hsl.$3);
    return Color.fromARGB((color.a * 255).round().clamp(0, 255), rgb.$1, rgb.$2, rgb.$3);
  }

  /// 色相（HSL の H）を設定します（[0.0, 360.0]。必要に応じて [0.0, 1.0] も使用可）
  static Color withHue(Color color, double hue) {
    final h = hue % 360.0;
    final hsl = _rgbToHsl((color.r * 255).round(), (color.g * 255).round(), (color.b * 255).round());
    final rgb = _hslToRgb(h, hsl.$2, hsl.$3);
    return Color.fromARGB((color.a * 255).round().clamp(0, 255), rgb.$1, rgb.$2, rgb.$3);
  }

  /// 現在の色相に [delta] 度を加算します
  static Color adjustHue(Color color, double delta) {
    final hsl = _rgbToHsl((color.r * 255).round(), (color.g * 255).round(), (color.b * 255).round());
    final newH = (hsl.$1 + delta) % 360.0;
    final rgb = _hslToRgb(newH, hsl.$2, hsl.$3);
    return Color.fromARGB((color.a * 255).round().clamp(0, 255), rgb.$1, rgb.$2, rgb.$3);
  }

  // --- まとめて調整（複数項目を一度に設定）---

  /// 任意パラメータで明度・彩度・RGB などを一括調整します。未指定の項目は元の値を保持します
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

  // --- RGB <-> HSL 内部変換 ---

  /// (H, S, L) を返します（H は [0, 360]、S/L は [0, 1]）
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

  /// H は [0, 360]、S/L は [0, 1] を想定し、(R, G, B)（0〜255）へ変換します
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
    return ((r * 255).round().clamp(0, 255), (g * 255).round().clamp(0, 255), (b * 255).round().clamp(0, 255));
  }

  static double _hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

  static Color withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity.clamp(0.0, 1.0) * 255).round());
  }
}

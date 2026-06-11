import 'package:flutter/material.dart';
import 'timeline_theme.dart';

class TimelineThemes {
  TimelineThemes._();

  static TimelineThemeData minimal() {
    return TimelineThemeData(
      lineColor: Colors.grey.shade300,
      lineWidth: 1.5,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.grey.shade400,
      indicatorSize: 20,
      cardBackground: Colors.transparent,
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(12),
      cardBorderRadius: BorderRadius.zero,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade500,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade700,
      ),
      spacingBetweenEvents: 24,
    );
  }

  static TimelineThemeData modern() {
    return TimelineThemeData(
      lineColor: Colors.blue.shade300,
      lineWidth: 3,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.blue,
      indicatorSize: 36,
      cardBackground: Colors.white,
      cardElevation: 2,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(16),
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      dateStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.blue.shade600,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
        height: 1.5,
      ),
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeOutQuart,
      connectorAnimation: ConnectorAnimation.growDown,
      spacingBetweenEvents: 32,
    );
  }

  static TimelineThemeData gradient() {
    return TimelineThemeData(
      lineColor: Colors.blue,
      lineWidth: 3,
      lineStyle: LineStyle.gradient,
      lineGradientStart: Colors.purple,
      lineGradientEnd: Colors.blue,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.purple,
      indicatorSize: 38,
      cardBackground: Colors.white,
      cardElevation: 3,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(16),
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      dateStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
        height: 1.5,
      ),
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeOutQuart,
      connectorAnimation: ConnectorAnimation.growOut,
      spacingBetweenEvents: 32,
    );
  }

  static TimelineThemeData card() {
    return TimelineThemeData(
      lineColor: Colors.orange.shade200,
      lineWidth: 2.5,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.orange,
      indicatorSize: 34,
      cardBackground: Colors.white,
      cardElevation: 4,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(20),
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.orange.shade700,
        fontWeight: FontWeight.w600,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
        height: 1.5,
      ),
      animationDuration: const Duration(milliseconds: 450),
      animationCurve: Curves.easeOutBack,
      connectorAnimation: ConnectorAnimation.draw,
    );
  }

  static TimelineThemeData cupertino() {
    return TimelineThemeData(
      lineColor: Colors.grey.shade300,
      lineWidth: 1,
      lineStyle: LineStyle.solid,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.blue,
      indicatorSize: 12,
      cardBackground: const Color(0xFFF2F2F7),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(14),
      cardBorderRadius: BorderRadius.circular(10),
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade500,
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF3C3C43),
        height: 1.4,
      ),
      spacingBetweenEvents: 20,
    );
  }

  static TimelineThemeData material() {
    return TimelineThemeData(
      lineColor: Colors.teal.shade200,
      lineWidth: 2,
      indicatorStyle: IndicatorStyle.icon,
      indicatorColor: Colors.teal,
      indicatorSize: 40,
      cardBackground: Colors.white,
      cardElevation: 1,
      cardPadding: const EdgeInsets.all(16),
      cardBorderRadius: BorderRadius.circular(12),
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.teal.shade800,
      ),
      dateStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black54,
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        height: 1.5,
      ),
      spacingBetweenEvents: 24,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      connectorAnimation: ConnectorAnimation.growOut,
    );
  }

  static TimelineThemeData dark() {
    return TimelineThemeData(
      lineColor: Colors.cyan.shade300,
      lineWidth: 2.5,
      lineStyle: LineStyle.dotted,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.cyanAccent,
      indicatorSize: 32,
      cardBackground: const Color(0xFF1E1E2E),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(18),
      cardBorderRadius: BorderRadius.circular(14),
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.cyan.shade300,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade400,
        height: 1.5,
      ),
      backgroundColor: const Color(0xFF0D0D1A),
      timelineBackground: const Color(0xFF0D0D1A),
      animationCurve: Curves.easeOutExpo,
      animationDuration: const Duration(milliseconds: 600),
      connectorAnimation: ConnectorAnimation.wave,
    );
  }

  static TimelineThemeData neumorphic() {
    return TimelineThemeData(
      lineColor: Colors.grey.shade400,
      lineWidth: 2,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.grey.shade500,
      indicatorSize: 34,
      cardBackground: const Color(0xFFE8ECF1),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(20),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade600,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade700,
        height: 1.5,
      ),
      connectorAnimation: ConnectorAnimation.growUp,
    );
  }

  static TimelineThemeData dotted() {
    return TimelineThemeData(
      lineColor: Colors.indigo.shade300,
      lineWidth: 2,
      lineStyle: LineStyle.dotted,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.indigo,
      indicatorSize: 28,
      cardBackground: Colors.white,
      cardElevation: 1,
      cardPadding: const EdgeInsets.all(16),
      cardBorderRadius: BorderRadius.circular(12),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.indigo,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.indigo.shade300,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade700,
        height: 1.4,
      ),
      spacingBetweenEvents: 28,
      connectorAnimation: ConnectorAnimation.draw,
    );
  }

  static TimelineThemeData bubble() {
    return TimelineThemeData(
      lineColor: Colors.pink.shade200,
      lineWidth: 2,
      lineStyle: LineStyle.solid,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.pink,
      indicatorSize: 44,
      cardBackground: const Color(0xFFFFF0F5),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(18),
      cardBorderRadius: BorderRadius.circular(24),
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Color(0xFF880E4F),
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.pink.shade400,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF4A0040),
        height: 1.5,
      ),
      spacingBetweenEvents: 24,
      connectorAnimation: ConnectorAnimation.pulse,
    );
  }

  static TimelineThemeData sunset() {
    return TimelineThemeData(
      lineColor: Colors.deepOrange.shade300,
      lineWidth: 3,
      lineStyle: LineStyle.gradient,
      lineGradientStart: Colors.orange,
      lineGradientEnd: Colors.deepOrange,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.deepOrange,
      indicatorSize: 36,
      cardBackground: Colors.white,
      cardElevation: 3,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(12),
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFBF360C),
      ),
      dateStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.orange.shade700,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.brown.shade700,
        height: 1.5,
      ),
      spacingBetweenEvents: 32,
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeOutQuart,
      connectorAnimation: ConnectorAnimation.wave,
    );
  }

  static TimelineThemeData ocean() {
    return TimelineThemeData(
      lineColor: Colors.cyan.shade300,
      lineWidth: 2.5,
      lineStyle: LineStyle.gradient,
      lineGradientStart: Colors.blue,
      lineGradientEnd: Colors.teal,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.teal,
      indicatorSize: 34,
      cardBackground: const Color(0xFFF0FAFA),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(18),
      cardBorderRadius: BorderRadius.circular(16),
      titleStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Colors.teal.shade800,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.cyan.shade600,
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF37474F),
        height: 1.5,
      ),
      spacingBetweenEvents: 28,
      animationDuration: const Duration(milliseconds: 600),
      animationCurve: Curves.easeInOutCubic,
      connectorAnimation: ConnectorAnimation.bounce,
    );
  }

  static TimelineThemeData forest() {
    return TimelineThemeData(
      lineColor: Colors.green.shade300,
      lineWidth: 2,
      lineStyle: LineStyle.dotted,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.green.shade700,
      indicatorSize: 30,
      cardBackground: const Color(0xFFF1F8E9),
      cardElevation: 1,
      cardPadding: const EdgeInsets.all(16),
      cardBorderRadius: BorderRadius.circular(12),
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.green.shade900,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        color: Colors.green.shade600,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.green.shade800,
        height: 1.4,
      ),
      spacingBetweenEvents: 24,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeOutSine,
      connectorAnimation: ConnectorAnimation.growUp,
    );
  }

  static TimelineThemeData galaxy() {
    return TimelineThemeData(
      lineColor: Colors.purple.shade300,
      lineWidth: 2.5,
      lineStyle: LineStyle.dashed,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.amber,
      indicatorSize: 34,
      cardBackground: const Color(0xFF1A1A2E),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(18),
      cardBorderRadius: BorderRadius.circular(16),
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.amber.shade300,
      ),
      descriptionStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade400,
        height: 1.5,
      ),
      backgroundColor: const Color(0xFF0F0F23),
      timelineBackground: const Color(0xFF0F0F23),
      animationDuration: const Duration(milliseconds: 600),
      animationCurve: Curves.easeOutExpo,
      connectorAnimation: ConnectorAnimation.pulse,
    );
  }

  static TimelineThemeData retro() {
    return TimelineThemeData(
      lineColor: const Color(0xFF8B4513),
      lineWidth: 2,
      lineStyle: LineStyle.solid,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: const Color(0xFFCD853F),
      indicatorSize: 32,
      cardBackground: const Color(0xFFFFF8DC),
      cardElevation: 2,
      cardPadding: const EdgeInsets.all(16),
      cardBorderRadius: BorderRadius.circular(4),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'serif',
        color: Color(0xFF5D4037),
      ),
      dateStyle: const TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        fontFamily: 'serif',
        color: Color(0xFF8D6E63),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'serif',
        color: Color(0xFF6D4C41),
        height: 1.5,
      ),
      spacingBetweenEvents: 28,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeOut,
      connectorAnimation: ConnectorAnimation.draw,
    );
  }

  static TimelineThemeData neon() {
    return TimelineThemeData(
      lineColor: Colors.pinkAccent,
      lineWidth: 3,
      lineStyle: LineStyle.solid,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: Colors.cyanAccent,
      indicatorSize: 38,
      cardBackground: const Color(0xFF0D0D0D),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(12),
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.cyanAccent,
        letterSpacing: 1.2,
      ),
      dateStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.pinkAccent.shade200,
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFFCCCCCC),
        height: 1.5,
      ),
      backgroundColor: Colors.black,
      timelineBackground: Colors.black,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeOutBack,
      connectorAnimation: ConnectorAnimation.bounce,
    );
  }

  static TimelineThemeData pastel() {
    return TimelineThemeData(
      lineColor: const Color(0xFFB39DDB),
      lineWidth: 2,
      lineStyle: LineStyle.dashed,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: const Color(0xFFCE93D8),
      indicatorSize: 32,
      cardBackground: const Color(0xFFF3E5F5),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(18),
      cardBorderRadius: BorderRadius.circular(20),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF6A1B9A),
      ),
      dateStyle: const TextStyle(
        fontSize: 12,
        color: Color(0xFFAB47BC),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF4A148C),
        height: 1.5,
      ),
      spacingBetweenEvents: 24,
      animationDuration: const Duration(milliseconds: 450),
      animationCurve: Curves.easeInOutQuad,
      connectorAnimation: ConnectorAnimation.fadeIn,
    );
  }

  static TimelineThemeData luxury() {
    return TimelineThemeData(
      lineColor: const Color(0xFFB8860B),
      lineWidth: 2,
      lineStyle: LineStyle.solid,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: const Color(0xFFFFD700),
      indicatorSize: 36,
      cardBackground: const Color(0xFF1C1C1C),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(20),
      cardBorderRadius: BorderRadius.circular(4),
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFD700),
        letterSpacing: 1.5,
      ),
      dateStyle: const TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: Color(0xFFB8860B),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFFD4C5A9),
        height: 1.5,
      ),
      backgroundColor: const Color(0xFF0D0D0D),
      timelineBackground: const Color(0xFF0D0D0D),
      spacingBetweenEvents: 32,
      animationDuration: const Duration(milliseconds: 600),
      animationCurve: Curves.easeOutCubic,
      connectorAnimation: ConnectorAnimation.growDown,
    );
  }

  static TimelineThemeData cyberpunk() {
    return TimelineThemeData(
      lineColor: const Color(0xFFFF00FF),
      lineWidth: 3,
      lineStyle: LineStyle.gradient,
      lineGradientStart: const Color(0xFFFF00FF),
      lineGradientEnd: const Color(0xFF00FFFF),
      indicatorStyle: IndicatorStyle.icon,
      indicatorColor: const Color(0xFFFF00FF),
      indicatorSize: 42,
      cardBackground: const Color(0xFF111122),
      cardElevation: 0,
      cardPadding: const EdgeInsets.all(18),
      cardBorderRadius: BorderRadius.circular(4),
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Color(0xFF00FFFF),
        letterSpacing: 2,
      ),
      dateStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFF00FF),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF88FF88),
        height: 1.5,
      ),
      backgroundColor: const Color(0xFF0A0A1A),
      timelineBackground: const Color(0xFF0A0A1A),
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeOutBack,
      connectorAnimation: ConnectorAnimation.pulse,
    );
  }

  static TimelineThemeData coffee() {
    return TimelineThemeData(
      lineColor: const Color(0xFFA1887F),
      lineWidth: 2,
      lineStyle: LineStyle.solid,
      indicatorStyle: IndicatorStyle.circle,
      indicatorColor: const Color(0xFF795548),
      indicatorSize: 30,
      cardBackground: const Color(0xFFFFF3E0),
      cardElevation: 1,
      cardPadding: const EdgeInsets.all(16),
      cardBorderRadius: BorderRadius.circular(8),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4E342E),
      ),
      dateStyle: const TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: Color(0xFF8D6E63),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF5D4037),
        height: 1.5,
      ),
      spacingBetweenEvents: 24,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeOutSine,
      connectorAnimation: ConnectorAnimation.growUp,
    );
  }
}

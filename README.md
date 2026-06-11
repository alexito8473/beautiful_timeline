# Beautiful Timeline

A beautiful, fully customizable, responsive timeline widget for Flutter.

20 visual themes, 16 content types, 14 animated connector styles, 4 visual effects, and automatic responsive layout for mobile, tablet, and desktop. **Zero external dependencies.**

## Features

- **20 Pre-built themes** — minimal, modern, gradient, card, cupertino, material, dark, neumorphic, dotted, bubble, sunset, ocean, forest, galaxy, retro, neon, pastel, luxury, cyberpunk, coffee
- **16 Content types** — text, icons, images, progress bars, expandable sections, custom widgets, video, code, quote, link, tags, stats, avatar
- **14 Animated connector styles** — growDown, growUp, growOut, wave, pulse, draw, fadeIn, bounce, stagger, wipe, glow, ripple, morph, slideIn
- **4 Visual effects** — glow, shimmer, sparkle, none (on indicators and cards)
- **Responsive by default** — auto-adapts to mobile, tablet, and desktop
- **Smooth animations** — fade + slide entry, animated line connectors
- **Horizontal & vertical** — supports both axes with mouse wheel + drag on Windows
- **Numbered indicators** — `number` field on all event constructors
- **Highly customizable** — full theme override, custom builders, extensive styling
- **Zero dependencies** — pure Flutter SDK, no external packages

## Getting Started

```yaml
dependencies:
  beautiful_timeline: ^0.1.0
```

## Usage

```dart
import 'package:beautiful_timeline/beautiful_timeline.dart';

// Simple usage with default theme
BeautifulTimeline(
  events: [
    TimelineEvent(
      title: 'Project Started',
      description: 'We began the development process.',
      date: 'Jan 2026',
    ),
    TimelineEvent.icon(
      title: 'Design Phase',
      description: 'UI/UX mockups completed.',
      date: 'Feb 2026',
      icon: Icons.design_services,
    ),
    TimelineEvent.progress(
      title: 'Development',
      label: 'Progress',
      value: 0.75,
      date: 'Mar 2026',
      icon: Icons.code,
    ),
    TimelineEvent.image(
      title: 'Launch Event',
      description: 'Product launch celebration.',
      date: 'Apr 2026',
      imageUrl: 'https://picsum.photos/400/200',
    ),
  ],
)
```

### With a specific theme

```dart
BeautifulTimeline(
  theme: TimelineThemes.gradient(),
  events: [...],
)
```

### With custom theme

```dart
BeautifulTimeline(
  theme: TimelineThemeData(
    lineColor: Colors.purple.shade300,
    lineWidth: 3,
    indicatorStyle: IndicatorStyle.circle,
    indicatorColor: Colors.purple,
    indicatorSize: 40,
    cardBackground: Colors.white,
    cardElevation: 2,
    cardBorderRadius: BorderRadius.circular(16),
  ),
  events: [...],
)
```

### Horizontal timeline

```dart
BeautifulTimeline(
  axis: TimelineAxis.horizontal,
  events: [...],
)
```

### Without animations

```dart
BeautifulTimeline(
  showAnimation: false,
  events: [...],
)
```

## Content Types

| Constructor | Description |
|------------|-------------|
| `TimelineEvent()` | Basic text event with optional icon |
| `TimelineEvent.text()` | Text-only event |
| `TimelineEvent.icon()` | Event with icon indicator |
| `TimelineEvent.image()` | Event with network image |
| `TimelineEvent.imageWidget()` | Event with custom image widget |
| `TimelineEvent.progress()` | Event with progress bar |
| `TimelineEvent.card()` | Fully custom card widget |
| `TimelineEvent.expandable()` | Expandable/collapsible event |
| `TimelineEvent.custom()` | Fully custom widget |
| `TimelineEvent.video()` | Event with video thumbnail |
| `TimelineEvent.code()` | Code snippet display |
| `TimelineEvent.quote()` | Quote/testimonial card |
| `TimelineEvent.link()` | Link preview card |
| `TimelineEvent.tags()` | Tags/chips display |
| `TimelineEvent.stats()` | Key-value statistics |
| `TimelineEvent.avatar()` | User avatar with name |

All constructors accept an optional `int? number` parameter for numbered indicators (rendered as `IndicatorStyle.number`).

## Themes

| Theme | Description |
|-------|-------------|
| `TimelineThemes.minimal()` | Clean, minimal design |
| `TimelineThemes.modern()` | Modern cards with shadows |
| `TimelineThemes.gradient()` | Gradient line and indicators |
| `TimelineThemes.card()` | Elevated card style |
| `TimelineThemes.cupertino()` | iOS-inspired design |
| `TimelineThemes.material()` | Material Design 3 style |
| `TimelineThemes.dark()` | Dark mode optimized |
| `TimelineThemes.neumorphic()` | Neumorphic soft design |
| `TimelineThemes.dotted()` | Dotted connector lines |
| `TimelineThemes.bubble()` | Pink bubble chat style |
| `TimelineThemes.sunset()` | Warm sunset gradient |
| `TimelineThemes.ocean()` | Ocean blue tones |
| `TimelineThemes.forest()` | Nature green palette |
| `TimelineThemes.galaxy()` | Dark space theme |
| `TimelineThemes.retro()` | Vintage serif style |
| `TimelineThemes.neon()` | Cyber neon glow |
| `TimelineThemes.pastel()` | Soft pastel colors |
| `TimelineThemes.luxury()` | Gold and dark elegance |
| `TimelineThemes.cyberpunk()` | Futuristic neon punk |
| `TimelineThemes.coffee()` | Warm coffee browns |

## Available properties

`BeautifulTimeline`:
- `events` — list of timeline events
- `theme` — timeline appearance
- `themeOverride` — inline theme overrides (merged with theme)
- `axis` — vertical, horizontal, or responsive (auto)
- `showAnimation` — enable/disable entry animations
- `effect` — visual effect on indicators and cards (none, glow, shimmer, sparkle)
- `connectorAnimation` — animated connector style
- `itemWidth` — fixed width for horizontal items
- `breakpoints` — custom responsive breakpoints
- `physics` — custom scroll physics
- `scrollController` — custom scroll controller
- `animationController` — external animation controller
- `reverse` — reverse event order

`TimelineEvent` (all constructors):
- `number` — optional integer for numbered indicators

## Connector Animations

| Style | Description |
|-------|-------------|
| `ConnectorAnimation.growDown` | Line grows from top to bottom |
| `ConnectorAnimation.growUp` | Line grows from bottom to top |
| `ConnectorAnimation.growOut` | Line grows from center outward |
| `ConnectorAnimation.wave` | Line appears with a wave motion |
| `ConnectorAnimation.pulse` | Line pulses with fading dashes |
| `ConnectorAnimation.draw` | Line is drawn progressively |
| `ConnectorAnimation.fadeIn` | Line fades in gradually |
| `ConnectorAnimation.bounce` | Line bounces into place |
| `ConnectorAnimation.stagger` | Segments appear staggered |
| `ConnectorAnimation.wipe` | Line reveals with a sweeping clip |
| `ConnectorAnimation.glow` | Line draws with animated glow |
| `ConnectorAnimation.ripple` | Ripple travels along the line |
| `ConnectorAnimation.morph` | Points morph into a solid line |
| `ConnectorAnimation.slideIn` | Line slides in from the side |

## Timeline Effects

| Effect | Description |
|--------|-------------|
| `TimelineEffect.none` | No extra effect |
| `TimelineEffect.glow` | Glowing aura behind indicators |
| `TimelineEffect.shimmer` | Traveling shimmer on cards |
| `TimelineEffect.sparkle` | Sparkling dots around indicators |

## Running the example

```bash
cd example
flutter run
```

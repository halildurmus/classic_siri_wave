// Copyright (c) 2023, Halil Durmus. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siri_wave/siri_wave.dart';

void main() {
  group('IOS9SiriWave', () {
    testWidgets("widget's properties should be set correctly", (tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS9SiriWave(
              controller: SiriWaveController(),
            ),
          ),
        ),
      );

      // Find the IOS9SiriWave widget.
      final ios9SiriWave =
          tester.firstWidget<IOS9SiriWave>(find.byType(IOS9SiriWave));
      expect(ios9SiriWave.controller.amplitude, 1);
      expect(ios9SiriWave.controller.speed, .2);
    });

    testWidgets(
        'widget should paint the canvas with SupportLinePainter and IOS9SiriWavePainter',
        (tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS9SiriWave(
              controller: SiriWaveController(),
            ),
          ),
        ),
      );

      // Find the CustomPaint widget.
      final customPaint = tester.firstWidget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedBuilder),
          matching: find.byType(CustomPaint),
        ),
      );
      expect(customPaint.painter, isA<SupportLinePainter>());
      expect(customPaint.foregroundPainter, isA<IOS9SiriWavePainter>());
    });

    testWidgets(
        'widget should only paint the canvas with SupportLinePainter if the amplitude is 0',
        (tester) async {
      // Build the SiriWave widget.
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: IOS9SiriWave(
              controller: SiriWaveController(amplitude: 0),
            ),
          ),
        ),
      );

      // Find the CustomPaint widget.
      final customPaint = tester.firstWidget<CustomPaint>(
        find.descendant(
          of: find.byType(AnimatedBuilder),
          matching: find.byType(CustomPaint),
        ),
      );
      expect(customPaint.painter, isA<SupportLinePainter>());
      expect(customPaint.foregroundPainter, null);
    });
  });
}

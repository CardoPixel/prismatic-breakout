---
name: "🌈 Milestone 2 Task: Spectrum Mechanics"
about: Color-shifting bricks, refraction matrices, and prismatic light-splitting power-ups.
title: "m2: 🌈 [Task Name]"
labels: ["milestone-2", "gameplay-systems"]
assignees: ''
---

## Milestone Context

This issue belongs to **Milestone 2: Spectrum Mechanics (Gimmicks)**. The objective is implementing color matching and refraction algorithms.

## Task Description

Detail how this issue contributes to the color-shifting brick gameplay mechanics.

### Implementation Checklist

- [ ] Define the enum values for the color spectrum (e.g., Red, Orange, Yellow, Green, Blue, Violet)
- [ ] Implement collision filtering matching the ball's current color index
- [ ] Create power-up drop triggers on block destruction events
- [ ] Connect signal callback nodes between bricks and game manager

### Associated Resources

- Base Class: `res://Scripts/AbstractBrick.gd`
- Resource System: `res://Resources/SpectrumColor.tres`

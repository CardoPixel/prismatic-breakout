# Contributing to Prismatic Breakout

Thank you for choosing to contribute to **Prismatic Breakout**! This document provides structured guidelines to make contributing to our Godot 4.x project transparent, productive, and smooth.

## 🏁 Code of Conduct

By participating in this repository, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md) at all times.

## 🗺️ How to Get Started

1. **Explore Existing Milestones**: Check our active GitHub Project board milestones (Milestone 1: Core, Milestone 2: Spectrum Mechanics, Milestone 3: Polish) to see where help is needed.
2. **File an Issue**: If you find a new physics bug or have a suggestion for game polish, use our issue templates to report it before writing code.

## 🛠️ Workflow Rules for Code Changes

We use a standard fork-and-pull model for all script and asset changes.

### 1. Code Style and Conventions

- **GDScript Guidelines**: Follow standard Godot formatting conventions. Use static typing (`var speed: float = 600.0`) for all properties to avoid runtime exceptions.
- **Commit Messages**: We strictly enforce **Conventional Commits** paired with **Gitmojis**.
  - *Format*: `<type>(<scope>): <gitmoji> <description>`
  - *Example*: `feat(paddle): ✨ implement 2D horizontal movement and boundaries`

### 2. Making a Pull Request

1. Fork this project to your personal GitHub account.
2. Create a clean branch from `main` named after your target issue (e.g., `feature/issue-001-paddle`).
3. Ensure your local `version.json` tracks accurately via our repository's versioning hook.
4. Open a Pull Request targeting our main branch using our PR template.

## 🧪 Testing Your Changes

Before submitting a PR, verify your game files locally:

1. Run your code scene inside the **Godot Editor**. Verify that no compilation warnings appear in the bottom debugger output tray.
2. Confirm the ball maintains structural velocity during reflections and does not clip through boundary colliders.

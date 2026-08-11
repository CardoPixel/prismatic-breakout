# 🌈🧱 Prismatic Breakout

An open-source, modular 2D Breakout game clone built with the Godot Engine mostly using AI (Open Claude + OpenRouter Free + Godot MPC + Gemini on Antigravity IDE). This repository is configured with an automated semantic versioning and changelog generation workflow using Conventional Commits and Gitmojis.

## 🚀 Key Features (so far)

- **Classic Breakout Mechanics**: Fully configured collision detection, paddle physics, brick scoring arrays, and dynamic speed scaling.
- **Automated Version Tracking**: Integrated Git post-commit hooks that read and bump structural `version.json` arrays on every commit.
- **Runtime Accessibility**: Native `version_manager.gd` Autoload class ensuring real-time configuration tracking directly within active scenes.
- **Analyzers-Ready Architecture**: Clean separation of asset logic and version configurations for rapid static analysis or compilation setups.

## 🛠️ Requirements & Environment

- **Game Engine**: Godot Engine 4.x (Standard or Mono Edition)
- **Dev Environment**: Linux Native or Windows (via Git Bash for Git hooks)
- **Version Control**: Git 2.x+

## 📦 Getting Started

### 1. Clone the Project

```bash
git clone https://github.com/your-username/godot-breakout.git
cd godot-breakout
```

### 2. Activate the Version & Changelog Automation

To ensure every structural save updates your metadata tracking instantly, make sure to add your post-commit script to the git core:

```bash
# For Linux/macOS
chmod +x .git/hooks/post-commit
```

### 3. Open in Godot

1. Launch the **Godot Project Manager**.
2. Click **Import**, navigate to your cloned repository folder, and open `project.godot`.
3. Press **F5** or click the Play button to execute the core runtime loop.

## 📝 Contribution Guide

We enforce the **Conventional Commits** standard paired with **Gitmojis** to maintain clean project development histories.

### Commit Structure Style

```text
<type>(<optional scope>): <gitmoji> <short description>
```

### Reference Examples

- ✨ `feat(ball): 🚀 introduce velocity acceleration multipliers on paddle impact`
- 🐛 `fix(paddle): 🐛 resolve screen-edge window clipping parameters`
- 🔧 `chore(deps): 🔧 update automated workspace hook formatting properties`

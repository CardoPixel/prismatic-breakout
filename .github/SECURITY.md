# Security Policy

## Supported Versions

We prioritize maintaining a safe gaming and development environment. Security patch fixes are focused exclusively on the current active lifecycle releases listed below:

| Version | Supported |
| :--- | :--- |
| **v1.0.x** (Current Stable) | Yes |
| **v0.x.x** (Alpha/Beta Milestones) | No |

## 🛡️ Scope of Security Concerns

For an open-source Godot project, security concerns generally include:

1. Malicious third-party Model Context Protocol (MCP) server plugins injected into local `.mcp.json` environment spaces.
2. Un-sandboxed editor build extensions that trigger code execution pipelines during a playtest sequence.
3. Exploits in custom network multiplayer sockets or save-file serialization formats that could lead to memory injection vulnerabilities.

## ✉️ How to Report a Vulnerability

**Do not file public GitHub issues for critical security bugs.**

To report a vulnerability safely:

1. Email your technical findings directly to **[INSERT_SECURITY_EMAIL_ADDRESS_HERE]**.
2. Include reproduction steps, sample source code files, or configuration vectors that highlight the vulnerability.
3. Our team will review your report within 48 hours and coordinate a patch before publicly disclosing the vulnerability.

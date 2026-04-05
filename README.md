# AIMac

**An AI onboarding OS for macOS that safely, incrementally, and reproducibly turns any Mac into an AI-ready machine — finishing at first success, not first install.**

---

## What is this?

AIMac is not another installer.

It is a **state convergence system** that:

- detects your current Mac environment
- plans safe, incremental changes
- installs only what is missing
- verifies everything works
- guides you to your first real AI success

Built for:

- beginners starting AI for the first time
- existing Mac users who want to become AI-ready without breaking their setup

---

## Why?

Most setup tools stop at installation.

AIMac continues until:

> your first successful AI execution

---

## What makes it different?

- Works on **both fresh and existing Macs**
- **Never blindly overwrites** your setup
- Shows **what will change before it changes**
- Can be **re-run safely anytime**
- Goes beyond setup → **first real AI usage**

---

## Core Principles

- Do not replace the ecosystem. Orchestrate it.
- Detect before change.
- Safe by default.
- Idempotent and inspectable.
- Finish at first success, not first install.

---

## Ecosystem

AIMac builds on top of proven tools:

- Homebrew (package management)
- mise (runtime management)
- chezmoi (dotfiles)

This project **does not replace them** — it orchestrates them.

---

## Commands (v0)

```bash
aimac doctor
aimac plan --profile beginner
aimac apply --profile beginner --safe
aimac verify
aimac report
```

---

## Status

🚧 v0.1 in progress

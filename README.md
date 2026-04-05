# AIMac

**An AI onboarding OS for macOS that safely, incrementally, and reproducibly turns any Mac into an AI-ready machine — finishing at first success, not first install.**

---

## What is this?

AIMac is not another installer.

It is a **state convergence system** for macOS that:

- detects your current environment
- plans safe, incremental changes
- installs only what is missing
- verifies that tools are actually usable
- leaves artifacts for inspection
- guides users toward a real first AI-ready state

Built for:

- beginners starting AI for the first time
- existing Mac users who want to become AI-ready without breaking their setup
- builders who want a profile-driven, repeatable setup flow

---

## Why?

Most setup tools stop at installation.

AIMac continues until:

> your first successful AI-ready setup state

Not just install.  
**First success.**

---

## What makes it different?

- Works on **both fresh and existing Macs**
- **Detects before changing**
- Applies **safe, incremental setup**
- Avoids blindly overwriting existing environments
- Can be **re-run safely**
- Uses **profiles** as the source of truth
- Goes beyond setup → **verification and readiness**

---

## Core Principles

- Do not replace the ecosystem. Orchestrate it.
- Detect before change.
- Safe by default.
- Idempotent and inspectable.
- AI-first, but beginner-safe.
- Finish at first success, not first install.

---

## Ecosystem

AIMac builds on top of proven tools:

- Homebrew
- mise
- chezmoi (planned)

It does **not** replace them — it orchestrates them.

---

## Current Profiles

- `beginner`
  - safe first-step profile for AI learners
- `builder`
  - adds GitHub CLI for repo-centric AI workflows

More profiles are planned.

---

## Quick Start

```bash
git clone https://github.com/masaakisakamoto/aimac.git
cd aimac

./cli/aimac doctor
./cli/aimac plan --profile=beginner --safe
./cli/aimac apply --profile=beginner --safe
./cli/aimac verify --profile=beginner
./cli/aimac first-success --profile=beginner
```

Builder example:

```bash
./cli/aimac plan --profile=builder --safe
./cli/aimac apply --profile=builder --safe
./cli/aimac verify --profile=builder
./cli/aimac first-success --profile=builder
```

---

## Commands
```bash
./cli/aimac doctor
./cli/aimac plan --profile=beginner --safe
./cli/aimac apply --profile=beginner --safe
./cli/aimac verify --profile=beginner
./cli/aimac report
./cli/aimac first-success --profile=beginner
```

---

## Current Capabilities
- environment diagnosis
- conflict detection for runtime managers
- profile-driven planning
- profile-driven apply
- profile-driven verify
- markdown artifact reporting
- first-success onboarding flow

---

## Project Status

🚧 v0.1 in active development

Current focus:

- profile-driven architecture
- stronger artifact outputs
- safer apply/force boundaries
- richer readiness checks
- more profiles

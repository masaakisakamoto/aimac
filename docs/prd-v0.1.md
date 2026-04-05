# AIMac PRD v0.1

## Working Title

**AIMac**

## One-Line Definition

**An AI onboarding OS for macOS that safely, incrementally, and reproducibly turns any Mac into an AI-ready machine — finishing at first success, not first install.**

## Product Summary

AIMac is an open-source onboarding system for macOS designed for the AI era.

It does not attempt to replace mature ecosystem tools such as Homebrew, chezmoi, or mise. Instead, it orchestrates them into a safe, inspectable, beginner-safe, and developer-respectful flow that helps any user move from “I have a Mac” to “I can actually start learning and building with AI.”

The product is built for two users at once:

1. **The new AI learner** who wants a trusted first step without breaking their machine.
2. **The existing Mac user** who already has tools installed and wants to fill in only what is missing for serious AI learning and development.

AIMac is therefore not a traditional installer. It is a **state convergence system** for AI readiness on macOS.

## Problem

Today, the path to starting AI on a Mac is fragmented.

Users must figure out, often by trial and error:

* which package manager to use
* which runtimes and tools are needed
* how to avoid conflicts with existing setups
* how to configure editors, shells, and CLIs
* how to validate that the environment actually works
* what to do immediately after installation

Existing macOS bootstrap tools are useful, but they generally optimize for generic development setup, personal dotfiles replication, or power-user reproducibility. They rarely optimize for the full AI onboarding journey:

* diagnosing readiness before making changes
* applying changes incrementally and safely
* preserving existing setups
* surfacing conflicts clearly
* guiding the user to a first successful AI task

This creates a gap between “tools installed” and “user successfully started.”

## Opportunity

The world is entering a phase where more people want to seriously start using AI.

There is still room for a world-class OSS product that does the following exceptionally well:

* detects the current state of any Mac
* plans safe changes before applying them
* installs only what is missing by default
* respects existing local environments
* validates that the environment is truly usable
* guides the user to a first successful AI outcome
* can be re-run any time without breaking trust

This product can become the default first step for anyone who wants to make their Mac AI-ready.

## Product Thesis

**Any Mac → AI-ready Mac**

The winning product is not a new package manager and not another opinionated bootstrap script.

The winning product is an **AI onboarding OS** that composes best-in-class ecosystem tools into a coherent experience with five properties:

1. **Safe by default**
2. **Incremental by design**
3. **Inspectable before change**
4. **Reproducible over time**
5. **Successful at the first real use, not merely at install time**

## Product Principles

### 1. Do not replace the ecosystem. Orchestrate it.

AIMac composes tools like Homebrew, Brew Bundle, chezmoi, and mise instead of reimplementing their responsibilities.

### 2. Detect before change.

The system must observe and classify the current environment before planning or applying modifications.

### 3. Safe by default.

The default path must prioritize additive, non-destructive, incremental changes.

### 4. Idempotent and inspectable.

Users should be able to run the system repeatedly, understand what happened, and recover from partial failures.

### 5. AI-first, but beginner-safe.

The product should be powerful enough for serious builders while remaining approachable for first-time AI learners.

### 6. Finish at first success, not first install.

The product is not complete when tools are installed. It is complete when the user has a verified first AI success path.

## Product Positioning

AIMac should be understood as:

* **not** a generic macOS bootstrap script
* **not** a replacement for Homebrew, chezmoi, mise, or nix-darwin
* **not** a corporate MDM solution
* **not** a full GUI management platform

AIMac **is**:

* an AI onboarding OS for macOS
* a safe convergence layer over proven ecosystem tools
* a readiness diagnosis and guided setup system
* a bridge from environment setup to first successful AI execution

## Primary Users

### 1. Beginner Learner

A user with a Mac who wants to start learning AI seriously, but does not want to manually assemble tools or risk breaking their machine.

### 2. Existing Mac User

A user who already has a working Mac setup and wants to add only the missing pieces required for AI learning and building.

### 3. Serious Builder

A user who wants an inspectable, rerunnable, profile-based setup flow for AI app development, local tooling, and experimentation.

## Core Product Scope

AIMac v0.1 focuses on:

* environment detection
* change planning
* safe incremental apply
* post-apply verification
* AI readiness diagnosis
* first success path guidance
* artifact/log output for each run

## Out of Scope for v0.1

* GUI application
* enterprise zero-touch deployment
* mandatory nix-darwin architecture
* deep secrets automation
* destructive cleanup workflows
* multi-OS support beyond macOS

## Product Shape

AIMac is structured as a three-layer product:

### Layer 1: Environment Bootstrap

System prerequisites, package management, runtimes, editors, shell setup, AI tools, optional local AI tooling, and selected macOS preferences.

### Layer 2: AI Readiness Diagnosis

Checks whether the machine is actually ready for AI learning and development, including missing dependencies, configuration gaps, conflicts, and manual-required actions.

### Layer 3: First Success Path

Guides the user into a verified first success, such as a working CLI check, first prompt execution, first script run, or first small scaffolded AI project.

## Definition of Success

AIMac succeeds when a user can say:

> “This did not just install tools on my Mac. It got me to a real first step with AI, safely, without wrecking what I already had.”

## V0.1 Success Criteria

AIMac v0.1 is successful if it can:

* diagnose a Mac before making changes
* generate an inspectable plan
* apply safe incremental changes by default
* detect common environment conflicts
* verify that core tools are usable
* output a machine-readable and human-readable run report
* guide the user to a first successful AI interaction or project start

## North Star

**Make the first serious step into AI on macOS trustworthy, repeatable, and world-class.**

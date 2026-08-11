# Specification Governance

## Purpose

Defines ownership of DigiDesk intent, current documentation, and implementation
evidence.

## Requirements

### Requirement: One accepted truth layer

Normative product behavior and safety invariants SHALL live only in
`openspec/specs/<capability>/spec.md`. Active changes, documentation, source,
tests, and deployment state MUST NOT become competing normative layers.

#### Scenario: Implementation conflicts with a requirement

- **GIVEN** implementation evidence disagrees with an accepted requirement
- **WHEN** the mismatch is reviewed
- **THEN** it SHALL be classified as inaccurate specification text or
  implementation conformance debt
- **AND** the disposition SHALL cite observable evidence

### Requirement: Specification-driven behavior changes

Changed intended behavior, compatibility, ownership, failure semantics, or
operational safety SHALL pass through one named OpenSpec change before
implementation and archive.

#### Scenario: Intended behavior changes

- **GIVEN** an endpoint, workflow, authorization rule, persistence effect, or
  integration boundary will change
- **WHEN** implementation begins
- **THEN** a strictly valid named change SHALL define the affected requirement
- **AND** its verification and rollout impact SHALL be explicit

### Requirement: Canonical active documentation

Architecture, procedures, configuration catalogs, and implementation navigation
SHALL live under `docs/`. `README.md` and `AGENTS.md` SHALL route to that material
instead of duplicating it.

#### Scenario: Operator procedure changes

- **GIVEN** commands, prerequisites, or troubleshooting change without altering
  intended behavior
- **WHEN** guidance is updated
- **THEN** the narrowest current page under `docs/` SHALL change
- **AND** no behavioral requirement SHALL be invented

### Requirement: Portable and private context

Tracked specifications and docs SHALL use repo-relative references and SHALL
NOT contain secret values or real employee records.

#### Scenario: Repository is cloned elsewhere

- **GIVEN** the repository is cloned to another path
- **WHEN** its accepted context is loaded
- **THEN** tracked internal paths SHALL still resolve
- **AND** provider identities SHALL remain understandable without personal
  filesystem paths

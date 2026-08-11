# Access Control

## Purpose

Defines DigiDesk identity matching and actor-scoped authorization.

## Requirements

### Requirement: Google employee identity

DigiDesk SHALL admit only an authenticated Google identity that maps to an
active employee record. A missing, inactive, or unmatched employee SHALL be
denied without exposing workforce records.

#### Scenario: Active employee signs in

- **GIVEN** Supabase verifies a Google identity whose email maps to an active
  employee
- **WHEN** the employee opens DigiDesk
- **THEN** DigiDesk SHALL create an application actor from that employee record
- **AND** SHALL derive the actor's role server-side

#### Scenario: Identity is not eligible

- **GIVEN** the identity is unauthenticated, non-Google, inactive, or unmatched
- **WHEN** it requests a protected surface
- **THEN** DigiDesk SHALL deny access
- **AND** SHALL NOT reveal another employee's data

### Requirement: Actor-scoped records

Employees SHALL read or mutate only their own employee-scoped records unless a
manager or HR rule explicitly grants broader access. Every server mutation MUST
derive the actor from the authenticated session rather than a client-supplied
role or employee identifier.

#### Scenario: Employee attempts another employee's mutation

- **GIVEN** an authenticated employee submits a record identifier owned by
  another employee
- **WHEN** DigiDesk evaluates the mutation
- **THEN** it SHALL reject the request
- **AND** SHALL leave the target record unchanged

### Requirement: Manager and HR boundaries

A manager SHALL act only on employees in that manager's current team. HR SHALL
perform cross-employee administration only through HR-authorized operations.

#### Scenario: Manager decides a team member's leave

- **GIVEN** an authenticated manager and a pending request owned by that
  manager's current team member
- **WHEN** the manager approves or rejects the request
- **THEN** DigiDesk SHALL record the authorized decision
- **AND** a rejection SHALL include its reason

#### Scenario: Manager targets an unrelated employee

- **GIVEN** a request owned outside the manager's current team
- **WHEN** the manager attempts a decision or record mutation
- **THEN** DigiDesk SHALL deny it

### Requirement: Sensitive-data containment

DigiDesk SHALL minimize employee and HR data in responses, logs, tests,
documentation, and integration payloads. Secrets and service-role credentials
MUST remain server-only.

#### Scenario: Diagnostic evidence is captured

- **GIVEN** an operator is diagnosing a DigiDesk failure
- **WHEN** evidence is saved or shared
- **THEN** it SHALL use synthetic or redacted records
- **AND** SHALL NOT expose tokens, service-role keys, or unrelated employee data

# Runtime Platform

## Purpose

Defines DigiDesk runtime ownership, persistence, and integration safety.

## Requirements

### Requirement: Isolated active platform

The active DigiDesk application SHALL run on its linked Himadri-owned Vercel
project and use its isolated DigiDesk Supabase project for authentication and
application state. Another product's database MUST NOT be used as a fallback.

#### Scenario: Runtime configuration is incomplete

- **GIVEN** a DigiDesk environment is missing required Supabase configuration
- **WHEN** the application starts or handles state
- **THEN** the environment SHALL fail clearly
- **AND** SHALL NOT silently select another project or a generic ambient token

### Requirement: Server-owned state access

Shared DigiDesk state SHALL be accessed through authenticated server operations.
The Supabase service-role key MUST remain server-only, and browser clients SHALL
NOT receive direct service-role access to the state table.

#### Scenario: Browser loads application state

- **GIVEN** an authorized actor requests DigiDesk state
- **WHEN** the server reads the state table
- **THEN** it SHALL return only the actor-authorized response
- **AND** SHALL NOT expose the service-role credential

### Requirement: Slack request authenticity

Every inbound Slack interaction SHALL have a valid Slack signature and an
acceptable timestamp before DigiDesk processes it. Missing signing configuration
or failed verification SHALL fail closed.

#### Scenario: Signature cannot be verified

- **GIVEN** an inbound Slack action has a missing, invalid, or stale signature,
  or the signing secret is unavailable
- **WHEN** DigiDesk receives the action
- **THEN** it SHALL reject the action
- **AND** SHALL NOT mutate a leave or attendance record

### Requirement: Guarded scheduled reporting

Scheduled attendance reporting SHALL require the deployment-owned cron secret
and SHALL use only the configured DigiDesk Slack destination.

#### Scenario: Cron authorization fails

- **GIVEN** a daily attendance request lacks the correct cron secret
- **WHEN** the endpoint evaluates it
- **THEN** DigiDesk SHALL reject the request
- **AND** SHALL NOT send a report

### Requirement: Legacy path retirement

GitHub-backed state and Railway deployment SHALL be treated as legacy migration
surfaces, not active-platform fallbacks. Their removal or temporary use SHALL be
governed by an explicit change with data migration, compatibility, and rollback
evidence.

#### Scenario: Supabase is unavailable

- **GIVEN** the active Supabase path is unavailable
- **WHEN** DigiDesk attempts a state operation
- **THEN** it SHALL surface a failure
- **AND** SHALL NOT implicitly activate GitHub-backed persistence

## ADDED Requirements

### Requirement: Repository-owned debugging entrypoint

DigiDesk SHALL provide executable root `./debugging_cli` as the supported low-tax entrypoint for repository status, environment diagnostics, local development, verification delegation, specification inspection, HTTP probes, and bounded production logs.

#### Scenario: Orient an unfamiliar checkout

- **GIVEN** an operator has a DigiDesk checkout
- **WHEN** the operator runs `./debugging_cli status`
- **THEN** the CLI MUST report the expected repository identity, branch, commit, worktree state, supported runtime files, Vercel target, and credential presence without printing credential values

### Requirement: Strict environment and authority checks

The CLI MUST accept only explicit `dev` or `prod` environment selections where an environment is required, MUST validate the canonical Git origin, and MUST validate the exact Himadri Vercel identity and wiom-digidesk project before a production provider read.

#### Scenario: Diagnose development offline

- **GIVEN** the checkout has no provider credentials
- **WHEN** the operator runs `./debugging_cli doctor --env dev`
- **THEN** the CLI MUST perform only local tool, origin, package, environment-file, and port checks and MUST NOT call an external provider

#### Scenario: Reject wrong production authority

- **GIVEN** the Himadri Vercel credential is missing, rejected, or resolves to another identity or project
- **WHEN** the operator runs a production doctor or log command
- **THEN** the CLI MUST fail before returning provider evidence and MUST NOT try a generic or different owner's credential

### Requirement: Existing workflow delegation

The CLI SHALL delegate development, tests, lint, typecheck, build, and OpenSpec operations to repository-owned commands and MUST fail explicitly when the selected operation is not supported by the repository.

#### Scenario: Run a supported quality gate

- **GIVEN** the package manifest defines the selected script
- **WHEN** the operator invokes the matching debugging command
- **THEN** the CLI MUST execute that exact repository script and preserve its exit status

#### Scenario: Select an unavailable gate

- **GIVEN** the package manifest does not define the selected script
- **WHEN** the operator invokes that debugging command
- **THEN** the CLI MUST return a nonzero unsupported-command error without substituting another check

### Requirement: Read-only production diagnostics

The CLI SHALL provide a content-free HTTP probe and bounded Vercel production-event inspection. It MUST target only the embedded wiom-digidesk project, cap log output at 500 events, and MUST NOT deploy, mutate provider configuration, query application data, or persist output.

#### Scenario: Probe production

- **GIVEN** the production origin is configured
- **WHEN** the operator runs `./debugging_cli probe --env prod`
- **THEN** the CLI MUST report only the HTTP status and final URL and MUST NOT print the response body

#### Scenario: Read bounded production events

- **GIVEN** valid Himadri Vercel authority and a READY production deployment
- **WHEN** the operator runs `./debugging_cli logs --env prod --lines 100`
- **THEN** the CLI MUST select the exact project, return no more than 100 terminal events, and MUST NOT write a log file

### Requirement: Secret-free and fail-closed behavior

The CLI MUST NOT print, persist, source, or copy secret values and MUST stop on malformed arguments, unexpected repository identity, unavailable required tools, or failed provider verification.

#### Scenario: Credential is present

- **GIVEN** a scoped credential exists in the caller environment
- **WHEN** status or doctor reports it
- **THEN** output MUST contain only the variable name and presence state and MUST NOT contain the value

#### Scenario: Unknown command is requested

- **GIVEN** an operator supplies an unknown command or option
- **WHEN** the CLI parses the request
- **THEN** it MUST exit nonzero with usage guidance and MUST NOT run a fallback action

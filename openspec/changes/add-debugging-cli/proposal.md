## Why

DigiDesk diagnostics are spread across npm scripts, Git state, Vercel metadata, and environment documentation. A single repository-owned, read-only-by-default debugging CLI will reduce operator ambiguity while protecting sensitive employee data and the isolated DigiDesk runtime boundary.

## What Changes

- Add executable root `./debugging_cli` with strict `status`, `doctor`, `dev`, quality-gate, `specs`, HTTP probe, and bounded Vercel production-log commands.
- Validate the canonical Himadri Git origin and exact DigiDesk Vercel project, report credential presence without values, and fail closed on missing or wrong-scoped authority.
- Delegate local development and verification to existing package scripts without extending the legacy GitHub-backed or Railway paths.
- Add a focused runbook and offline CLI regression.
- Do not add deploy, database mutation, Slack sends, production reset, log persistence, or generic credential fallback behavior.

## Capabilities

### New Capabilities

- `debugging-cli`: Safe operator diagnostics and bounded environment inspection for DigiDesk.

### Modified Capabilities

None.

## Impact

The change adds a Bash CLI, an offline shell regression, a runbook, and a new OpenSpec capability. It does not change authorization, employee or HR data, Supabase schema, Slack or cron behavior, deployment topology, or runtime dependencies. Production inspection is read-only, capped, and terminal-only. Rollback removes the added operator surface and documentation with no data migration.

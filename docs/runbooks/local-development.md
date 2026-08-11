# Local development

## Prerequisites

- Node.js 20.11 or later and earlier than 26
- npm
- Supabase CLI for migration or local-link work
- access to the isolated DigiDesk Supabase project

## Environment

Create ignored local environment files only. Use the credential names and
provider boundary in `../reference/runtime-configuration.md`. Never paste
secrets into tracked files or command output.

At minimum, the app needs its DigiDesk Supabase URL, browser public key, and
server service-role key mapped to the variable names used by the application.
Google OAuth must be configured for the same Supabase project. Slack variables
are needed only to exercise Slack integration, but interaction handling must
not be tested by disabling signature verification.

Confirm `.supabase/.temp/project-ref` or `supabase/.temp/project-ref` resolves to
`ocgzadxwwnpshosksemj` before a remote migration or seed. Stop if it resolves to
another project.

## Commands

```bash
npm install
npm run dev
```

Before handing off a change:

```bash
openspec validate --all --strict --no-interactive
npm test
```

`npm test` runs the repository's syntax and production-build checks. Use
synthetic employee and workforce data in local validation; do not copy real
rows from production.

## Failure boundary

If Supabase configuration is missing, do not add or rely on a GitHub token to
make the legacy fallback work. Correct the DigiDesk-specific environment
mapping. Missing Slack or provider authority blocks that integration test; a
similarly named ambient credential is not a fallback.

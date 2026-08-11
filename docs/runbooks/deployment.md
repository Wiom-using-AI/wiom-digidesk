# Deployment

## Active target

The active application target is the linked Himadri-owned Vercel project
`wiom-digidesk`. Supabase project `ocgzadxwwnpshosksemj` owns authentication and
application state. Railway and GitHub-backed persistence are legacy surfaces.

## Preflight

1. Obtain explicit authorization to deploy.
2. Verify the Git root, branch, worktrees, clean/dirty state, and remote.
3. Select the Himadri GitHub and Vercel identities documented in
   `../reference/runtime-configuration.md`.
4. Verify the Vercel project name and Supabase project ref through read-only
   provider output.
5. Run strict OpenSpec validation and `npm test`.
6. Confirm production environment variables exist by name without printing
   their values.
7. Confirm `CRON_SECRET`, Slack signing, and Slack delivery configuration are
   present when those features are enabled.

## Release and evidence

Use the linked Vercel project's normal deployment flow. Capture non-secret
evidence: commit, deployment URL/identifier, health result, and the affected
workflow checks. Do not mutate employee records merely to prove deployment.

If a database migration is involved, verify the exact Supabase project before
applying it, use the repo-owned migration history, and document rollback in the
named OpenSpec change. A successful Vercel build does not prove database,
Google OAuth, Slack, or cron correctness.

## Rollback

Prefer Vercel's previous known-good deployment for application rollback.
Database rollback must follow the reviewed migration plan; never improvise a
destructive reverse migration against production. Stop on provider identity or
credential ambiguity.

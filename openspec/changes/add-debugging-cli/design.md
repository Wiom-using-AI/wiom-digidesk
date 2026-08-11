## Context

DigiDesk has multiple existing operator commands but no single low-tax debugging entrypoint. Operators need local state, tool readiness, supported command delegation, production reachability, and bounded Vercel events without copying credentials or bypassing repository authority.

## Goals / Non-Goals

**Goals:**

- Provide one executable root CLI with strict arguments and stable diagnostics.
- Validate the canonical himadrineogi-source/digidesk Git boundary and exact wiom-digidesk Vercel project before provider reads.
- Keep default checks offline, report credential presence only, and make production reads explicit.
- Reuse existing npm and OpenSpec commands so the CLI remains an operator facade rather than a second implementation.

**Non-Goals:**

- Supabase mutation, Slack sends, deployment, legacy Railway extension, or production reset.
- Reading or persisting application database rows.
- Installing dependencies, editing dotenv files, or selecting credentials automatically.
- Replacing Agentbook's Go CLI or creating a shared cross-repository runtime dependency.

## Decisions

1. **Use a repository-root Bash entrypoint.** Bash is already available in the operating environment and can safely delegate Git, npm, curl, jq, and OpenSpec commands without adding an application dependency. A copied self-contained script is preferred to a workspace-relative shared script because every repository must remain independently operable.
2. **Embed immutable non-secret identity.** The CLI records the expected GitHub slug, Himadri Vercel team id, project id, project name, and production URL. Origin or provider mismatch fails closed and the unexpected remote value is not echoed when it could contain credentials.
3. **Separate offline and provider diagnostics.** `status` and `doctor --env dev` make no network calls. `doctor --env prod`, `probe --env prod`, and `logs --env prod` are explicit read-only provider operations.
4. **Keep credentials in the caller environment.** The CLI checks `GH_HIMADRI_PAT`, `HIMADRI_VERCEL_TOKEN`, and `HIMADRI_SUPABASE_ACCESS_TOKEN` by name and presence only. It never loads generic credential variables or prints values. Only the Vercel token is sent to Vercel for production diagnostics.
5. **Delegate rather than reimplement.** The `dev` command delegates to `npm run dev`, preserving the existing CSS build and Next.js development path. Test, lint, typecheck, build, and spec commands first verify that the corresponding repository script or OpenSpec surface exists, then execute it unchanged.
6. **Bound production output.** HTTP probe returns status and final URL without page content. Logs select the exact latest READY production deployment and return at most the requested event count, capped at 500, to the terminal. The CLI does not write logs to disk.
7. **Test the control plane offline.** A shell regression exercises help, status, dev doctor, strict environment parsing, unknown-command failure, and secret-free output without provider calls.

## Risks / Trade-offs

- [Copied CLIs can drift between repositories] -> Keep one intentionally identical command contract, project-specific constants at the top, and the same offline smoke regression in each repo.
- [Provider events may contain employee or HR content] -> Make logs explicit, capped, terminal-only, and document that output must not be redirected into the repository or shared without review.
- [A local Vercel link can be stale or missing] -> Use embedded allowlisted ids as authority and report local link parity separately.
- [A package lacks one quality script] -> Return an actionable unsupported-command error instead of silently substituting another gate.
- [Provider or credential verification fails] -> Fail closed without another token, cached response, or inferred success.

## Migration Plan

1. Add the OpenSpec delta, CLI, runbook, and offline regression.
2. Run the regression and applicable project gates.
3. Roll out by invoking `./debugging_cli status`; no data or deployment migration is required.
4. Roll back by removing the added files and documentation route. Existing npm, environment, data, and deployment paths remain unchanged.

## Open Questions

None. Provider mutation and richer application-specific data diagnostics require separate, explicitly scoped changes.

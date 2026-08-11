# DigiDesk debugging

**Mandate:** use the repository-owned `./debugging_cli` for checkout orientation, local diagnostics, supported quality commands, reachability probes, and bounded production Vercel events. It does not deploy, mutate provider configuration, query application data, or replace product-specific database procedures.

## Quick path

```text
./debugging_cli status
./debugging_cli doctor --env dev
./debugging_cli dev
./debugging_cli test
./debugging_cli lint
./debugging_cli typecheck
./debugging_cli build
./debugging_cli specs validate
./debugging_cli probe --env prod
./debugging_cli logs --env prod --lines 100
```

Commands that are not defined by this repository's `package.json` fail explicitly. Development diagnostics are offline and do not require provider credentials.

## Production boundary

Production doctor, probe, and logs verify the exact Himadri Vercel identity and allowlisted `wiom-digidesk` project using only `HIMADRI_VERCEL_TOKEN`. Missing or wrong authority blocks the command; generic `VERCEL_TOKEN` and other owners' credentials are not fallbacks.

The probe prints only HTTP status and final URL. Logs select the latest READY production deployment, cap output at 500 events, and write only to the terminal. Vercel events may contain employee or HR context: do not redirect them into the repository, paste them into tickets, or share them without reviewing and minimizing the content.

## Recovery

- Wrong origin or project: stop and restore the canonical checkout or Vercel link; do not bypass the allowlist.
- Missing dependency: install through the repository's documented setup, then rerun the command.
- Unsupported test, lint, or typecheck: use only a repository-defined gate; do not substitute a different command and call it equivalent.
- Provider failure: retain local state and retry the same read later. Do not infer that no logs or deployment exist.
- Application-data investigation: follow a separately authorized product-owned data procedure; this CLI intentionally has no database query command.

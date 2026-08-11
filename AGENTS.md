# DigiDesk agent instructions

## Start here

1. Read `docs/README.md` and the accepted specifications under
   `openspec/specs/`.
2. Inspect the current branch, worktrees, remotes, and `git status --short`
   before editing.
3. Treat accepted OpenSpec requirements as intended behavior, `docs/` as the
   current operating guide, and code/tests as implementation evidence.
4. Put behavioral changes through one named OpenSpec change. Update the
   narrowest page under `docs/` for procedural or implementation navigation.

## Safety and authority

- Employee, attendance, leave, document, and resignation data is sensitive.
  Never copy real records, tokens, or personal data into specifications,
  documentation, tests, commits, or chat.
- Use the DigiDesk-specific credentials documented in
  `docs/reference/runtime-configuration.md`. Similar ambient variables are not
  substitutes.
- Local development and validation MUST use the isolated DigiDesk Supabase
  project, never another product's database.
- Do not deploy, mutate production data, change provider configuration, or send
  Slack messages without explicit authorization.
- The GitHub-backed data path and Railway configuration are legacy
  compatibility surfaces. Do not extend them as the target architecture.

## Verification

Run `openspec validate --all --strict --no-interactive` for specification work
and `npm test` for code work. Add narrower evidence when the affected behavior
has dedicated tests.

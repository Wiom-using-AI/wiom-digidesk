## Context

See proposal.md for motivation. Managers and HR already download attendance
CSVs from the browser using in-memory DigiDesk state. The generator currently
hard-codes the in-progress calendar month. Actor roles and team scope already
exist on those surfaces. Persistence, Slack, cron, and the isolated Supabase /
Vercel boundary are unchanged.

## Goals / Non-Goals

**Goals:**

- Reuse the existing CSV format, attendance codes, and actor-scoped employee
  sets.
- Add start and end date controls on the manager and HR download surfaces.
- Validate the range before creating a Blob download.
- Keep the default range as the current calendar month.

**Non-Goals:**

- A new API, server-side CSV, or schema change.
- Changing Slack daily attendance messages or cron.
- Employee self-service attendance export.
- Moving the SPA out of `public/index.html`.
- Changing which columns or attendance codes appear in the CSV.

## Decisions

1. **Keep generation in the existing client report function.** The authorized
   actor already holds the attendance, leave, roster, and employee records used
   by the current download. A new endpoint would duplicate that read path
   without changing the security model of this SPA. Alternative considered: a
   signed API download. Rejected because it would add an unneeded persistence
   and authorization surface for a UI-only range change.

2. **Inclusive ISO calendar dates, local-day enumeration.** Start and end are
   `YYYY-MM-DD` values from `input type="date"`. The report includes every
   calendar day from start through end. Future days stay blank, matching the
   current month report. Alternative considered: month/year pickers only.
   Rejected because the request is a specific start and end date.

3. **Default to the current calendar month.** Unchanged one-click downloads
   keep producing this month's file. The actor can then narrow or extend the
   range. Alternative considered: default end date of today. Rejected because
   it would change the previous full-month output without an explicit range
   edit.

4. **Client-side role and scope checks.** The download function MUST require a
   manager or HR session, force team scope to the authenticated manager's team,
   and reserve organization-wide downloads for HR. This does not close the
   existing generic-state-read debt; it prevents accidental cross-team files
   from the new control. Alternative considered: ignore scope because the
   browser already cached state. Rejected because the product rule is
   team-versus-HR reporting.

5. **Filename includes the selected range.** The download name uses the start
   and end dates so two custom files are distinguishable. No server storage of
   generated files.

## Risks / Trade-offs

- [Very long ranges can produce large CSVs] -> Accept the selected inclusive
  range; keep generation synchronous in the existing download path. Do not add
  a server job.
- [Client-side checks do not replace server actor scoping] -> Preserve the
  existing access-control requirement. This change does not claim to close
  generic authenticated state-read debt.
- [Date inputs can be cleared or inverted] -> Reject missing, malformed, and
  inverted ranges with an error toast and no Blob.
- [Timezone midnight conversion can skip or duplicate a day] -> Enumerate with
  local `YYYY-MM-DD` calendar arithmetic rather than UTC `Date` day counts.

## Migration Plan

1. Ship the UI and generator change with the application deploy.
2. No database or environment migration.
3. Roll back by reverting the commit or promoting the previous Vercel
   production deployment.

## Open Questions

None.

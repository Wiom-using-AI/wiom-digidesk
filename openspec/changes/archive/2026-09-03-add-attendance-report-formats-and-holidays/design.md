## Context

See proposal.md for motivation. Attendance CSVs, roster parsing, and manager/HR
surfaces already live in `public/index.html`. Rosters persist under
`wiom_rosters`. Week-off resolution currently falls back to Saturday/Sunday
when no roster row exists. There is no holiday state key. Custom date-range
downloads already shipped.

## Goals / Non-Goals

**Goals:**

- One status-code resolver used by both download formats.
- Two explicit download actions on the existing date-range control.
- Week off only from `daysOff` on the effective roster row.
- Persist holidays as `wiom_holidays` in the existing state table.
- Let managers and HR upload a CSV holiday list.

**Non-Goals:**

- Changing Slack daily attendance messages.
- Server-side CSV generation or a new SQL table.
- Employee self-service holiday or report downloads.
- Per-employee holiday exceptions beyond the shared list.

## Decisions

1. **Keep generation in the client report path.** The authorized actor already
   holds attendance, leave, roster, and employee records. Alternative: a new
   API. Rejected because it would duplicate the SPA read path for a reporting
   format change.

2. **Two download buttons rather than a hidden toggle.** The request is to
   download whichever format is needed. Separate code-only and punch-in
   actions make the choice visible. Punch-in times attach only to `P` and
   `PWO`.

3. **Remove the weekend fallback.** `isRosterWeekOff` returns true only from
   the effective roster row. No roster means a working day, so an unscheduled
   Saturday without a punch-in is `A`. Alternative: keep Sat/Sun as default
   offs. Rejected by the explicit non-hardcoding request.

4. **Store holidays as `wiom_holidays` JSON.** Each row has `date`, `name`,
   `type` (`H` or `PH`), and upload metadata. The existing key/value state
   table already upserts new keys. Alternative: encode holidays inside roster
   CSVs. Rejected because holidays are org calendar facts, not per-employee
   shifts.

5. **Shared holiday list for manager and HR uploads.** Uploads merge by date;
   a later valid row replaces the same date. HR may delete any row; a manager
   may delete a row that manager uploaded. Reports always read the shared
   list.

6. **Code order.** `PWO` before holiday and `WO`; holiday before `WO`; `CO`
   leave before generic `L`; punch-in on a holiday is `P` rather than `H`/`PH`.
   Future report cells stay blank.

## Risks / Trade-offs

- [Employees without a roster will show weekend absences] -> That is the
  requested roster-only rule. Operators must upload rosters for actual offs.
- [Client writes still use the generic state API] -> Preserve the existing
  access-control debt; do not claim this change closes it.
- [Malformed holiday CSVs] -> Reject uploads with no valid dated rows.
- [Holiday and roster both mark a day off] -> Prefer `H`/`PH` when there is
  no punch-in so the holiday list is visible in payroll.

## Migration Plan

1. Deploy the UI, resolver, and holiday-key persistence.
2. No SQL migration. The first holiday upload creates `wiom_holidays`.
3. Roll back by reverting the commit or promoting the previous Vercel
   production deployment. Stored holidays remain until deleted.

## Open Questions

None.

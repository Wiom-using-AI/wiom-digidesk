## Why

Attendance CSVs currently emit punch-in times on present days, treat Saturday and Sunday as week offs when no roster row exists, and have no holiday list. Managers and HR need code-only and punch-in formats, roster-derived week offs, and uploaded H/PH holidays so payroll reports match each employee's actual schedule.

## What Changes

- Managers and HR can download attendance reports in two formats: status codes only, and status codes with punch-in time on present days.
- Report cells use P, A, WO, L, H, PH, PWO, and CO according to roster, holiday list, leave, and punch-in evidence.
- Week off is taken only from the uploaded roster. Saturday and Sunday are not assumed off.
- Managers and HR can upload, replace, and remove a holiday list that attendance reports reference.
- Custom start and end dates remain as already shipped. No Slack, cron, or schema-table change.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `workforce-workflows`: Add dual-format attendance downloads, roster-only week offs, holiday-list upload, and the P/A/WO/L/H/PH/PWO/CO status-code contract.

## Impact

Client reporting, roster week-off resolution, and a new `wiom_holidays` state key in the existing DigiDesk JSON state table. No new npm dependencies, no SQL migration, and no Slack or cron change. Holiday rows are workforce calendar data, not secrets. Rollback is a revert of the UI and helper changes plus removal of the holiday key if desired. Production deploy follows the repository deployment runbook.

## Why

Managers and HR currently download attendance CSVs for the calendar month in progress. Payroll and team reviews need an inclusive start and end date of their choosing, and the product must keep those downloads scoped to manager teams or HR-wide employees.

## What Changes

- Managers and HR administrators can select a start date and an end date before generating a downloadable attendance report.
- The generated CSV covers every calendar day in that inclusive range, using the existing attendance codes and future-date blanking.
- A manager download remains limited to that manager's current team. An HR download remains organization-wide for non-HR employees.
- Invalid, incomplete, or inverted date ranges are rejected and no file is generated.
- Employees without manager or HR authority do not receive this download control.
- This is not a breaking API change. The previous one-click current-month download remains available as the default selected range.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `workforce-workflows`: Add the intended downloadable attendance-report behavior for managers and HR, including custom inclusive date ranges and rejection of invalid ranges.

## Impact

The change is a client-side reporting control on the manager and HR surfaces in `public/index.html`. It does not add APIs, schema, Slack, cron, or dependency changes. Authorization stays actor-scoped: managers generate team reports, HR generates organization-wide reports, employees cannot. Rollback is a revert of the UI and helper changes. Generated files must not include secrets; they contain workforce attendance already visible to the authorized actor. No migration is required. Production deploy follows the repository deployment runbook after verification.

## ADDED Requirements

### Requirement: Custom-range attendance reports

An authorized manager or HR actor SHALL generate a downloadable attendance
report for a selected inclusive start date and end date. A manager SHALL
receive only that manager's current team. HR SHALL receive organization-wide
non-HR employee attendance. An employee without manager or HR authority SHALL
NOT generate these reports. Missing, malformed, or inverted date ranges SHALL
be rejected without generating a file. Dates after the current day SHALL remain
blank in the report. The default selected range SHALL be the current calendar
month so an unchanged download matches the previous month-scoped report.

#### Scenario: Manager downloads a custom team range

- **GIVEN** an authenticated manager and a valid start date that is on or
  before the end date
- **WHEN** the manager generates the attendance report
- **THEN** DigiDesk SHALL download a report covering every calendar day from
  start date through end date inclusive
- **AND** SHALL include only employees currently on that manager's team
- **AND** SHALL NOT include employees outside that team

#### Scenario: HR downloads an organization-wide custom range

- **GIVEN** an authenticated HR actor and a valid start date that is on or
  before the end date
- **WHEN** the HR actor generates the attendance report
- **THEN** DigiDesk SHALL download a report covering that inclusive date range
- **AND** SHALL include organization-wide non-HR employees

#### Scenario: Invalid range is rejected

- **GIVEN** an authenticated manager or HR actor
- **WHEN** the actor generates a report with a missing date, a malformed date,
  or a start date after the end date
- **THEN** DigiDesk SHALL refuse the download
- **AND** SHALL NOT generate a file

#### Scenario: Employee cannot generate the report

- **GIVEN** an authenticated employee without manager or HR authority
- **WHEN** the employee requests a downloadable attendance report
- **THEN** DigiDesk SHALL deny the request
- **AND** SHALL NOT generate a file

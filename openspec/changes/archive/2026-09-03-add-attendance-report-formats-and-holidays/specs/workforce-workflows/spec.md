## ADDED Requirements

### Requirement: Dual-format attendance report downloads

An authorized manager or HR actor SHALL be able to download an attendance
report as status codes only or as status codes with punch-in time on present
days. The actor SHALL choose the format at download time. The selected
inclusive date range, team-versus-HR employee scope, and future-date blanking
from custom-range attendance reports SHALL still apply.

#### Scenario: Code-only download

- **GIVEN** an authenticated manager or HR actor and a valid date range
- **WHEN** the actor downloads the code-only attendance report
- **THEN** DigiDesk SHALL emit status codes without punch-in times
- **AND** a present working day SHALL appear as `P`

#### Scenario: Punch-in-time download

- **GIVEN** an authenticated manager or HR actor and a valid date range
- **WHEN** the actor downloads the punch-in-time attendance report
- **THEN** a present working day SHALL include the punch-in time with the
  present code
- **AND** non-present codes SHALL remain code-only

### Requirement: Attendance report status codes

For each included past or current day, DigiDesk SHALL assign exactly one of
`P`, `A`, `WO`, `L`, `H`, `PH`, `PWO`, or `CO` using this order: present on a
roster week off is `PWO`; an uploaded holiday without a punch-in is `PH` or
`H` according to the holiday type; a roster week off without a punch-in is
`WO`; an approved compensatory-off leave is `CO`; any other approved leave is
`L`; a punch-in on a working day is `P`; otherwise `A`. Dates after the
current day SHALL remain blank in the downloaded report.

#### Scenario: Worked week off is PWO

- **GIVEN** a roster marks the day as week off and the employee has a punch-in
- **WHEN** the attendance report is generated
- **THEN** that cell SHALL be `PWO` in the code-only format

#### Scenario: Public holiday without attendance is PH

- **GIVEN** the uploaded holiday list marks the day as a public holiday and the
  employee has no punch-in
- **WHEN** the attendance report is generated
- **THEN** that cell SHALL be `PH`

### Requirement: Roster-derived week offs

A day SHALL be a week off only when the employee's currently effective roster
row marks that weekday as off. DigiDesk MUST NOT treat Saturday or Sunday as
week off solely because they are weekend days. If no effective roster row
exists, the day SHALL be treated as a working day for attendance reporting.

#### Scenario: Tuesday roster off is week off

- **GIVEN** the employee's effective roster marks Tuesday as off
- **WHEN** attendance is resolved for that Tuesday
- **THEN** DigiDesk SHALL treat it as week off
- **AND** SHALL NOT require that day to be Saturday or Sunday

#### Scenario: Weekend without roster is a working day

- **GIVEN** the employee has no effective roster row
- **WHEN** attendance is resolved for a Saturday or Sunday
- **THEN** DigiDesk SHALL NOT mark the day as week off for that reason

### Requirement: Holiday list for attendance reports

An authorized manager or HR actor SHALL upload a holiday list that DigiDesk
persists and uses when generating attendance reports. Each holiday SHALL have
a date and a type of `H` or `PH`. An employee without manager or HR authority
SHALL NOT upload or delete the list. A missing, malformed, or undated holiday
file SHALL be rejected without changing the stored list.

#### Scenario: HR uploads public holidays

- **GIVEN** an authenticated HR actor and a holiday file with valid dates and
  types
- **WHEN** the actor uploads the list
- **THEN** DigiDesk SHALL persist those holidays
- **AND** subsequent attendance reports SHALL use them for `H` and `PH` cells

#### Scenario: Manager uploads a holiday list

- **GIVEN** an authenticated manager and a valid holiday file
- **WHEN** the manager uploads the list
- **THEN** DigiDesk SHALL persist the holidays for attendance reporting

#### Scenario: Invalid holiday file is rejected

- **GIVEN** an authenticated manager or HR actor
- **WHEN** the actor uploads a holiday file with no valid dated rows
- **THEN** DigiDesk SHALL refuse the upload
- **AND** SHALL leave the previously stored holiday list unchanged

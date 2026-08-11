# Product surface

## Roles

DigiDesk recognizes employees, managers, and HR administrators after Google
authentication and active-employee matching.

- Employees manage their own attendance, leave requests, profile-facing
  workflows, document selections, and resignation requests.
- Managers review their own team's leave and attendance information.
- HR administrators manage employees, rosters, cross-employee records,
  reporting, and administrative decisions.

Role names do not grant authority by themselves. Every server mutation must
derive the actor from the authenticated Supabase session and enforce record or
team scope.

## Workflows

The current product includes:

- Google sign-in and active employee mapping;
- dashboard and profile views;
- attendance check-in and record management;
- leave requests, manager/HR decisions, rejection reasons, and Slack notices;
- roster import and effective-week scheduling;
- employee administration and reporting for HR;
- resignation requests; and
- browser-local document selection.

A roster row takes effect from its week start and remains effective until a
newer row supersedes it. The UI refreshes roster-sensitive state on focus,
visibility changes, and its periodic refresh interval.

## Evidence and known gaps

This page describes implementation navigation; the accepted specifications own
intent. Current code must be checked against at least these known gaps:

- generic authenticated state writes may not be sufficiently actor-scoped;
- Slack interaction verification is conditional when the signing secret is
  absent;
- GitHub persistence can activate implicitly when Supabase variables are
  absent; and
- selected documents are local to one browser rather than shared storage.

Resolve a gap against an existing accepted requirement when intent is already
clear. Create a named OpenSpec change only when intended behavior itself must
change.

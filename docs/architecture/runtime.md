# Runtime architecture

## Active platform

DigiDesk is a Next.js application deployed to its linked Himadri-owned Vercel
project. Supabase owns Google authentication and application state. Server-side
state access uses the service-role key; browser authentication uses the public
project URL and publishable/anon key. The scheduled attendance endpoint is
invoked by Vercel Cron and authenticated with `CRON_SECRET`.

The active Supabase project ref is `ocgzadxwwnpshosksemj`. It is isolated for
DigiDesk and MUST NOT be replaced with a Gurukul, Agentbook, or other product
database. The default state table is `public.digidesk_state`; its row-level
security permits service-role access rather than direct browser CRUD.

## Data model

The application currently persists JSON-compatible values by logical key:

- `wiom_custom_emps`
- `wiom_att`
- `wiom_leaves`
- `wiom_notifs`
- `wiom_resignations`
- `wiom_rosters`
- `wiom_logins`

Documents selected by an employee are currently kept in that browser's local
storage and are not a shared document repository. Do not describe them as
durably uploaded until the implementation and accepted specification change.

## Integrations

Supabase Auth accepts Google identities, after which DigiDesk maps the email to
an active employee record. Slack is used for leave approval interactions and
attendance reporting. Interactive Slack requests must be authenticated with the
deployment-owned signing secret. Scheduled and manual attendance reporting use
the deployment-owned Slack token and channel configuration.

## Legacy compatibility and debt

`lib/data-store.js` currently falls back to GitHub `data.json` when Supabase
runtime variables are missing, and `railway.json` retains an Express deployment
path. These are historical compatibility surfaces, not the desired active
architecture. New work must not depend on them; their removal should occur
through a named OpenSpec change with migration and rollback evidence.

The generic state API and any Slack endpoint that operates without a verified
signature must be treated as conformance debt against the accepted access and
integration requirements. Code behavior does not weaken those requirements.

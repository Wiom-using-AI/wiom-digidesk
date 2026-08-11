# Runtime configuration and credential boundary

This catalog records names and non-secret identities only. It never stores
credential values.

## Provider ownership

| Surface | Approved authority | Expected target |
| --- | --- | --- |
| GitHub administration | Himadri GitHub identity (`GH_HIMADRI_PAT` in the Wiom workspace) | `himadrineogi-source/wiom-digidesk` |
| Vercel administration | `HIMADRI_VERCEL_TOKEN` | project `wiom-digidesk` |
| Supabase management plane | `HIMADRI_SUPABASE_ACCESS_TOKEN` | project ref `ocgzadxwwnpshosksemj` |
| Supabase runtime | DigiDesk-scoped URL, public key, and service-role key | the same isolated project |
| Slack runtime | deployment-owned bot token and signing secret | DigiDesk app/channel configuration |

When this repo is operated from the Wiom workspace, map the scoped runtime
values `WIOM_DIGIDESK_SUPABASE_URL`, `WIOM_DIGIDESK_SUPABASE_ANON_KEY`, and
`WIOM_DIGIDESK_SUPABASE_SERVICE_ROLE_KEY` only into the variable names expected
by the targeted DigiDesk process. Database administration additionally uses the
scoped project ref and database password only for an authorized migration flow.

## Application variables

| Variable | Purpose |
| --- | --- |
| `NEXT_PUBLIC_SUPABASE_URL` | Browser Supabase URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Browser public/anon key |
| `SUPABASE_URL` | Server data-store URL |
| `SUPABASE_SERVICE_ROLE_KEY` | Server-only state access |
| `SUPABASE_STATE_TABLE` | Optional override; defaults to `digidesk_state` |
| `CRON_SECRET` | Authenticates the daily attendance cron request |
| `SLACK_TOKEN` | Deployment-owned DigiDesk Slack bot token |
| `SLACK_SIGNING_SECRET` | Verifies Slack interactions |

`GH_TOKEN` exists only for the legacy GitHub storage path and is not an
authorized substitute for missing Supabase configuration. Generic ambient
GitHub, Vercel, Supabase, or Slack tokens do not establish project ownership.
Never expose server-only or management credentials through `NEXT_PUBLIC_*`.

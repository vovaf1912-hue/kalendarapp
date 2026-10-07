# Garage Calendar — production handoff

## What is included
- `index.html` — protected calendar with Supabase Auth, realtime sync and PWA UI.
- `manifest.webmanifest` — installable PWA manifest.
- `sw.js` — service worker (cache version bumped for the protected release).
- `icon-192.png`, `icon-512.png` — PWA icons.
- `supabase_security.sql` — production RLS policies.

## One-time Supabase setup before client handoff
1. Open Supabase Dashboard → Authentication → Users.
2. Create one account per employee (email + password). Registration from the app is intentionally disabled.
3. Open SQL Editor and run `supabase_security.sql`.
4. In Authentication settings, configure the project as an email/password app.
5. Keep the Publishable key in the frontend; NEVER put a secret/service_role key into `index.html`.

## GitHub Pages
Put all files in the repository root and enable Settings → Pages → Deploy from branch → `main` → `/ (root)`.

Expected site for the current repository:
`https://vovaf1912-hue.github.io/garage-calendar/`

## Final smoke test
- Open on phone and PC.
- Log in on both devices with authorized employee accounts.
- Create a test appointment on phone; verify it appears on PC immediately.
- Edit status/time on PC; verify phone updates.
- Log out; verify the calendar is inaccessible without login.
- Remove all test appointments before handing over to the client.

## Security model
The frontend uses the Supabase Publishable key, which is designed for public client applications. Real protection comes from Supabase Auth + Row Level Security: unauthenticated users receive no appointment rows and cannot insert/update/delete records.

eFootball Stats Database — Updated Website

Included
- Eight navigation views: the seven requested position sections plus Main Ranking.
- Existing dropdown-based sorting interface preserved; headers are not clickable. Sorting options include goals, assists, matches, goal contributions, ratios and name. Default is goals, highest first.
- Player profiles with card image + player photo, Full Stats, POTM win count and latest award-period stats.
- Month/year POTM archive, top 10 candidates, winner highlight and Ballon d’Or-style gold trophy artwork.
- Monthly POTM calculates changes from the saved baseline: added goal contributions = added goals + added assists. The selected month is shown as “November, 2026 POTM”, etc.
- Edit player name, position, cumulative totals and images; CSV import/export includes position and image fields.
- Existing 23 player seed list retained.

Monthly award workflow
1. Open Edit data.
2. Update the cumulative matches, goals and assists for all players for the month.
3. Select the award month.
4. Click Generate Monthly POTM once all players have been updated.
5. The top 10 is ranked by added goal contributions; the #1 player wins. Current totals become the baseline for the next monthly update.

Important limitations
- This is a static website build and stores stats, images, baseline and POTM archive in the current browser’s localStorage. It does NOT yet sync changes to all visitors or devices and does not provide secure owner-only online authentication. A cloud database (for example, a configured Supabase project with proper row-level security and storage policies) must be connected for shared online editing.
- Goalkeeper stats fields are intentionally not invented; the Goalkeepers’ Stats view is a placeholder until the owner specifies the goalkeeper columns.
- Back up CSV regularly. POTM archive is stored in browser storage and is not included in the player CSV export.

Deploy
Extract the ZIP and upload/replace the `index.html` in the existing GitHub repository connected to Vercel. Vercel should redeploy automatically after commit.


Branding update
- Website name: eFootball Stats Database.
- Header subtitle: PLAYER STATISTICS · RANKINGS · AWARDS.
- This is an independent fan-made database and is not an official Konami/eFootball website.


### Goalkeeper statistics
The Goalkeepers section has its own stat columns: Matches Played, Shot Faced, Goal Saved, Goal Conceded, Goal Saving %, Goal Conceding %, Clean Sheet, Clean Sheet %, Shot Faced/Match, Goal Saved/Match, Goal Conceded/Match, Penalty Faced, Penalty Saved, and Penalty Saving %. Percentages and per-match figures are calculated from the entered totals. Edit these goalkeeper totals in Edit data when a goalkeeper is selected. CSV export includes these fields.


### Table alignment and CSV import safety
Table headers and statistic values are centered vertically and horizontally; player names remain left-aligned. The wide goalkeeper table keeps centered stat columns with wrapped headers and horizontal scrolling on small screens. CSV import now shows a preview of up to eight rows and requires confirmation before replacing player data. CSV import/export includes goalkeeper fields.


### POTM tie-breaker update
- Monthly POTM and Top 10 candidates are sorted by added Goal Contributions descending, added Matches ascending, then added Goals descending.
- If candidates are still equal on all three criteria, they are co-winners; player profiles count the shared win.


## Player comparison
- Use the “Compare Players” button in the header to select any two players.
- The comparison table displays their overall cumulative totals side by side: matches, goals, assists, goal contributions, per-match rates, POTM wins, and goalkeeper-specific statistics/rates.
- Higher numeric values are highlighted for quick scanning; for metrics such as goals conceded, higher does not mean better.

## Supabase connection (initial integration)
This package now includes `supabase-config.js`, `supabase-setup.sql`, and browser-side Supabase client integration for the player table.

### Setup steps
1. In Supabase Dashboard → Authentication, create/invite the one admin user you will use to edit the database. Do not enable public sign-ups for this single-owner website.
2. Open `supabase-setup.sql` in a text editor and replace every `YOUR_ADMIN_EMAIL@example.com` with the exact email of that admin account. Do not change the public SELECT policy. If the database already has duplicate player names, resolve those before running the unique index statement.
3. Copy the full edited SQL into Supabase SQL Editor and run it. This expands the `players` table with all outfield and goalkeeper fields and grants write/delete permission only to the allowlisted admin email.
4. Keep `supabase-config.js` next to `index.html` when deploying. It contains only the project URL and publishable browser key; never add a `sb_secret_` or `service_role` key to a browser file.
5. Open the website. Click **Edit data**, enter the admin email/password and click **Sign in**. If the cloud table is empty, use **Import CSV** to import the backup CSV and confirm; while signed in, player rows will be uploaded to Supabase.
6. Test in a private/incognito browser window: visitors should see cloud player data but cannot write to the table.

### Important current scope
- Supabase integration currently synchronizes the `players` table (including goalkeeper fields and image data). The POTM archive and its comparison baseline still use this browser's localStorage and are not yet shared across visitors/devices. Export a CSV backup before migrating and retain it safely.
- Publishable keys are intended for browser use, but security depends on correct RLS policies. The admin email in the SQL policy must be replaced before running it.
- This package has not been browser end-to-end tested against your live Supabase project. JavaScript syntax/archive checks should be performed after editing, and you should test sign-in, CSV migration, read-only visitor access, and editing before treating it as production-ready.

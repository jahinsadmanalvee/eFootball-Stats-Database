# ELITE_STRIKERS — website prototype

## Included
- Searchable player leaderboard using the 23 records from the supplied image
- Sorting by goals, assists, matches and ratios
- Player profile pop-up
- Local editor to add/edit/delete player records
- CSV import/export
- Optional photo URL field
- Ratios recalculated from matches/goals/assists

## Important limitation
This is a front-end prototype. Edits are stored in the current browser using localStorage only. They are not synchronized to other devices or visitors. For a published website with private admin login and persistent shared updates, connect a database (for example Supabase) and secure authentication before public launch.

## Preview locally
Open `index.html` in a modern browser.

## Deploy to Vercel
1. Create a GitHub repository and upload `index.html`.
2. Import that repository into Vercel.
3. Deploy as a static site (no build command required).

## CSV format
Headers required: `name,matches,goals,assists`
Optional: `photo`
Export from the site to get a sample CSV template.

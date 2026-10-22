eFootball Stats Database — Final Update Package

FILES
- index.html: complete updated website source.
- supabase-site-state-setup.sql: one-time Supabase setup for shared award/monthly state, editable column labels, and image storage.
- index-before-update-backup.html: copy of the source file used as the update base, for rollback/reference.

BEFORE YOU DEPLOY
1. Keep your existing supabase-config.js file in the same GitHub Pages folder. The updated index.html still loads it and does not contain your private Supabase credentials.
2. Keep your existing Supabase public.players table and its working admin policies. The SQL does not drop or recreate them.
3. In Supabase Dashboard -> SQL Editor, run supabase-site-state-setup.sql once. The SQL grants admin write access to the email already used by the previous setup: jahinsadmanalvee@gmail.com.
4. In your GitHub repository, upload/replace index.html with the included index.html. Keep the existing supabase-config.js and other site files.
5. Open the live site, refresh it, and sign in using Admin Login / Admin Edit. Verify player records load from Supabase before making edits.

IMPORTANT
- This package updates the files; it does not directly push to GitHub or change the live website.
- Preserve your existing index-old.html backup. The included backup is an additional copy of the source used as the update base.
- Test player read, admin sign-in, saving a player, photo upload, column heading save, and generating awards after the SQL is run.

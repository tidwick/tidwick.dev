# tidwick.dev

Static site for [tidwick](https://github.com/tidwick/tidwick), built with Astro.

    npm install
    just check      # astro check + build into dist/
    just preview    # build, then serve for two minutes

`dist/` is served as Workers static assets (`wrangler.jsonc`). Brand files
(`hero.svg`, `avatar.svg`) are for the README and the org profile; the site
serves only `public/`.

## Deploys

CI deploys the site, never a laptop. A push to `main` runs `.github/workflows/deploy.yml`:
`just ci`, then `just deploy`, in the `production` GitHub environment, which holds
`CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`. Without them the job fails with a message.
The site deploys from `main`; the app repository has the `next`/`main` release flow.

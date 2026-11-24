import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://tidwick.dev',
  output: 'static',
  trailingSlash: 'always',
  build: { format: 'directory' },
  compressHTML: false,
});

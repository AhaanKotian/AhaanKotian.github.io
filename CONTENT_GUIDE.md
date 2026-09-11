# Content editing guide

This one repo holds **both** the Hugo source and the generated website.
There is no longer a separate source folder — edit the source files here,
run `./build.sh`, then commit and push.

The site is built with [Hugo](https://gohugo.io) + [Hugo Blox
Builder](https://hugoblox.com). Every page is assembled from YAML
front matter at the top of a Markdown file — you rarely need to touch
HTML/templates.

## Repo layout

GitHub Pages serves a `<user>.github.io` repo from the **root** of the
`main` branch, so the generated site has to sit at the top level right
next to the source folders. Know which is which before you edit:

| Folder / file | What it is |
|---|---|
| `content/` | **SOURCE** — your pages, publications, projects, bio |
| `config/` | **SOURCE** — site config, nav menu, params |
| `assets/` | **SOURCE** — images/SVGs processed by Hugo |
| `static/` | **SOURCE** — files copied to the site as-is (e.g. the resume PDF) |
| `layouts/` | **SOURCE** — template overrides |
| `themes/` | **SOURCE** — the vendored Hugo Blox theme modules (don't edit) |
| `resources/` | **SOURCE** — Hugo's cache of resized images (committed, auto-managed) |
| `build.sh` | **SOURCE** — the build + publish script |
| `CONTENT_GUIDE.md` | **SOURCE** — this file |
| `index.html`, `404.html`, `index.xml`, `sitemap.xml`, `robots.txt` | **GENERATED** |
| `css/`, `js/`, `dist/`, `media/` | **GENERATED** |
| `author/`, `project/`, `projects/`, `publication/`, `publication_types/`, `tags/` | **GENERATED** |
| `_headers`, `_redirects`, `backlinks.json`, `Ahaan_Resume-3.pdf` | **GENERATED** |

**Never hand-edit a GENERATED file** — `./build.sh` overwrites it on the
next build. Change the source and rebuild instead.

Leftovers from an old R/blogdown workflow — `R/`, `index.Rmd`,
`personal_website.Rproj` — are unused by the Hugo build. `netlify.toml`
is only relevant if you ever deploy to Netlify instead of GitHub Pages.

## One-time setup: install Hugo

You need **Hugo Extended v0.131.0** (the "extended" build is required —
the theme compiles SCSS/Tailwind).

```bash
brew install hugo
```

If Homebrew fails (it did once here because Xcode Command Line Tools were
outdated — fix with Software Update, or just skip Homebrew), grab the
prebuilt binary instead:

```bash
curl -fL -o hugo.tar.gz \
  https://github.com/gohugoio/hugo/releases/download/v0.131.0/hugo_extended_0.131.0_darwin-universal.tar.gz
tar -xzf hugo.tar.gz hugo
chmod +x hugo
sudo mv hugo /usr/local/bin/     # put it on your PATH
```

Verify — the version line must contain the word `extended`:

```bash
hugo version
# hugo v0.131.0-... +extended darwin/arm64 ...
```

## Preview the site on localhost

This is the fast feedback loop: start the dev server, leave it running,
and edit files. It rebuilds and refreshes the browser automatically on
every save.

```bash
cd "path/to/AhaanKotian.github.io"
hugo server
```

Then open **<http://localhost:1313/>** in your browser.
Press `Ctrl+C` in the terminal to stop it.

Useful variants:

```bash
hugo server -D                      # also render draft pages (draft: true)
hugo server -F                      # also render future-dated pages
hugo server -D -F                   # both — handy for previewing a new paper
hugo server --port 8080             # use a different port if 1313 is taken
hugo server --disableFastRender     # full rebuild on every change (use if a
                                    #   change doesn't show up, esp. CSS/config)
hugo server --navigateToChanged     # jump the browser to the page you just edited
hugo server --printI18nWarnings --printPathWarnings   # noisier diagnostics
```

Notes on the dev server:

- It serves at `baseURL` `http://localhost:1313/`, **not** the production
  URL, so internal links work locally.
- It writes a scratch `public/` folder in the repo. That folder is
  gitignored and is **not** what gets deployed — ignore it, or delete it
  with `rm -rf public`. Deployment only ever comes from `./build.sh`.
- Config changes (`config/_default/*.yaml`) are picked up live, but if a
  change seems stuck, stop the server and restart with
  `hugo server --disableFastRender`.
- Port already in use? Either `hugo server --port 8080`, or kill the old
  server with `pkill -f "hugo server"`.

### Check the pages actually render

With the server running, in a second terminal:

```bash
# spot-check the main pages — every line should print 200
for p in / /projects/ /project/ /publication/ /publication/mammoth/ /tags/robotics/ /Ahaan_Resume-3.pdf; do
  printf "%-34s %s\n" "$p" "$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:1313$p")"
done
```

Or crawl **every** page the site claims to have, straight from its sitemap —
this stays correct as you add pages, and catches a page that silently
stopped building:

```bash
curl -s http://localhost:1313/sitemap.xml \
  | grep -o '<loc>[^<]*</loc>' | sed -E 's|</?loc>||g' \
  | while read -r u; do
      printf "%-60s %s\n" "$u" "$(curl -s -o /dev/null -w '%{http_code}' "$u")"
    done
```

### Test the real production build

`hugo server` is a dev build. To check exactly what will be deployed —
production URLs, minified assets, no drafts — build to a throwaway folder
and serve that as plain static files:

```bash
hugo --destination /tmp/site_preview --baseURL "http://localhost:8000/"
python3 -m http.server 8000 --directory /tmp/site_preview
# open http://localhost:8000/ , then Ctrl+C to stop
```

The same sitemap crawl works here — just swap the port to 8000. Note that
`python3 -m http.server` does not apply `_headers` or `_redirects`; those
are Netlify-only files and GitHub Pages ignores them too.


To see what a build *would* change in the repo without writing anything:

```bash
./build.sh --dry-run
```

## Where things live

| I want to change...                                          | Edit this file |
|---------------------------------------------------------------|----------------|
| Name, role, bio text, "About Me" paragraph                    | `content/authors/admin/_index.md` |
| Social links (email, GitHub, LinkedIn, X, Scholar, Portfolio)  | `content/authors/admin/_index.md` → `profiles:` list |
| Education (shown twice: short list + full timeline)           | `content/authors/admin/_index.md` → `education:` list |
| Interests list (small grid under bio)                         | `content/authors/admin/_index.md` → `interests:` list |
| Work experience timeline (title, dates, bullet points)         | `content/authors/admin/_index.md` → `work:` list |
| Technical skills list                                          | `content/authors/admin/_index.md` → `skills:` list |
| CV button link                                                 | `content/_index.md` → first section (`resume-biography-3`) → `content.button.url` |
| Homepage section order / which sections exist                  | `content/_index.md` → `sections:` list |
| "My Research" blurb text                                       | `content/_index.md` → the `markdown` block |
| One publication (title, authors, venue, links, thumbnail)      | `content/publication/<slug>/index.md` (+ `featured.jpg`/`.png` in same folder) |
| Add a new publication                                           | Copy an existing folder under `content/publication/`, e.g. `content/publication/mammoth/`, rename it, edit `index.md` |
| One project (title, description, links)                        | `content/project/<slug>/index.md` |
| Add a new project                                                | Copy an existing folder under `content/project/` |
| Nav bar links (top of page)                                    | `config/_default/menus.yaml` |
| Site title, browser tab title, base URL                        | `config/_default/hugo.yaml` |
| Meta description, Twitter handle, footer copyright text        | `config/_default/params.yaml` |
| A downloadable file (PDF etc.) served at the site root          | Drop it in `static/` — `static/foo.pdf` is published at `/foo.pdf` |
| Favicon / browser tab icon                                      | Add a file at `assets/media/icon.png` (currently no favicon — the theme falls back to a bundled default icon.png if this file exists at all, so leave it absent to keep no custom icon) |

## Publication front matter fields

Each publication is a folder under `content/publication/` containing
an `index.md`. Key fields:

```yaml
authors:
- admin                  # "admin" = you (pulls name from content/authors/admin/_index.md)
- Co-Author Name          # anyone else is shown as plain text
date: "2026-06-01T00:00:00Z"   # controls sort order (newest first) and displayed year
featured: true            # not currently used by the merged Publications view, safe to ignore
image:
  caption: "Image credit: ..."   # optional, shown under the thumbnail
publication: Accepted, IROS 2026     # venue line shown under the title
publication_types:
- paper-conference
summary: One-sentence summary (used for the card / meta description)
tags:
- Robotics
title: "Paper Title"
url_project: https://...   # optional: adds a "Project" link button
url_video: https://...     # optional: adds a "Video" link button
url_code: https://...      # optional: adds a "Code" link button
url_pdf: https://...       # optional: adds a "PDF" link button
```

Thumbnails: drop an image named `featured.jpg`, `featured.png`, or
`featured.webp` into the same folder as `index.md`. The four current
publications use **placeholder stock photos downloaded from Wikimedia
Commons** (attribution is in each `image.caption` field) — swap these
out for your own figures/screenshots whenever you're ready, just keep
the filename `featured.<ext>`.

## Publish the site

`./build.sh` builds the site into a temporary folder and then mirrors it
onto the repo root, deleting stale generated files while leaving every
source folder untouched.

```bash
cd "path/to/AhaanKotian.github.io"

./build.sh --dry-run   # optional: preview what would change
./build.sh             # build + publish into the repo root

git status             # review
git add -A
git commit -m "Update site content"
git push
```

GitHub Pages redeploys <https://AhaanKotian.github.io/> automatically a
minute or so after the push.

If you add a **new source file or folder** at the top level of the repo,
add its name to the `KEEP=(...)` list in `build.sh`. Anything not in that
list at the repo root is treated as stale build output and deleted on the
next build.

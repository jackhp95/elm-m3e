# Release checklist — jackhp95/elm-m3e (OWNER-ONLY)

The governance and docs blockers from the release-readiness audit
([#136](https://github.com/jackhp95/elm-m3e/issues/136)) are handled in the repo
(CHANGELOG, CONTRIBUTING, SECURITY, LICENSE reconciled to BSD-3-Clause, README
fixed + verified, self-contained `packages/m3e/README.md`).

The steps below are **irreversible or require owner privileges** and are
deliberately **not** done by automation. Run them yourself, in order.

## 1. Resolve the nested-package structure (BLOCKER)

Elm publishes a package from the **repo root** — the package `elm.json` must be at
the root of `github.com/jackhp95/elm-m3e`. Today the package is nested at
`packages/m3e/elm.json` while the repo root `elm.json` is an `application`. Pick one:

- **Option A — split (matches the memory'd plan).** Extract `packages/m3e/` into
  its own repo whose root *is* the package (`elm.json`, `src/`, `LICENSE`,
  `README.md`, `CHANGELOG.md` all at root). The self-contained
  `packages/m3e/README.md` and `packages/m3e/LICENSE` already exist for this. The
  monorepo keeps the docs site / generator and consumes the package.

  ```bash
  # sketch: seed a package repo from the packages/m3e subtree
  git subtree split --prefix=packages/m3e -b m3e-package
  # push that branch to the new repo's main, then verify from its root:
  #   elm make src/M3e.elm --output=/dev/null
  ```

- **Option B — restructure in place.** Make the package `elm.json` the repo root
  and move the docs/generator under a subdirectory. Larger diff; only if you want a
  single repo.

Do **not** tag or publish until `elm make src/M3e.elm --output=/dev/null` is green
from the package's repo root.

## 2. Confirm license (already reconciled — verify only)

`LICENSE` (root, BSD-3-Clause, 2026), `packages/m3e/LICENSE`,
`packages/m3e/elm.json` (`"license": "BSD-3-Clause"`), and root `package.json` all
agree on **BSD-3-Clause**. Confirm the chosen package root ships a matching
`LICENSE`; fix any drift the split introduces.

## 3. Tag and push `1.0.0`

From the package's repo root, on the release commit:

```bash
git tag 1.0.0
git push origin 1.0.0
```

Elm requires an exact `MAJOR.MINOR.PATCH` tag matching `elm.json`'s `version`.

## 4. Publish to the Elm registry

```bash
elm publish        # run from the package repo root
```

`elm publish` validates the license, that every exposed value is documented, and
that the tag exists. Publishing is **permanent** — a version cannot be unpublished
or overwritten.

## 5. Flip the repo public

```bash
gh repo edit jackhp95/elm-m3e --visibility public --accept-visibility-change-consequences
gh repo edit jackhp95/elm-m3e \
  --description "Type-safe, generated M3e.* Material 3 Expressive Elm bindings over @m3e/web" \
  --add-topic elm --add-topic material-3 --add-topic web-components --add-topic material-you
```

## 6. Enable repo security & protection (after going public)

```bash
# Secret scanning + push protection
gh api -X PATCH repos/jackhp95/elm-m3e \
  -f security_and_analysis[secret_scanning][status]=enabled \
  -f security_and_analysis[secret_scanning_push_protection][status]=enabled

# Private vulnerability reporting (backs SECURITY.md)
gh api -X PUT repos/jackhp95/elm-m3e/private-vulnerability-reporting

# Branch protection on main (require the CI checks + PRs)
gh api -X PUT repos/jackhp95/elm-m3e/branches/main/protection \
  --input protection.json   # required_status_checks (library/docs/harness), required PR reviews
```

## 7. Optional cleanup (audit nits)

- Move any maintainer-only root files out of a split package repo (keep `CONTEXT.md`
  and design notes in the monorepo/docs, not the published package root).
- Set the repo homepage to the package.elm-lang.org page once published.

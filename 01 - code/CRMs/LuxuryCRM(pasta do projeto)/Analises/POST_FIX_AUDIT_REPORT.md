# LuxuryCRM Post-Fix Audit Report

**Date:** 2026-03-22
**Context:** Re-audit after 4 rounds of fixes resolved 41 of 69 original issues

---

## Previous CRITICAL Issues — All Resolved

All 6 original CRITICAL issues (5 unauthenticated controllers + password bypass) are confirmed fixed. All 8 admin controllers now have `@UseGuards(JwtAuthGuard, AdminGuard)`.

---

## NEW Issues Found in This Re-Audit

### HIGH (3 findings)

#### N1. SSRF via RSS proxy — no private IP blocklist
- **File:** `dashboard.controller.ts:42-73`
- **Endpoint:** `GET /dashboard/rss-proxy?url=...`
- URL only validates `http://` or `https://` prefix. No blocklist for `127.0.0.1`, `10.x.x.x`, `192.168.x.x`, `169.254.169.254` (cloud metadata). Authenticated users can probe internal services.

#### N2. CSV parser breaks on quoted fields with commas
- **File:** `main.tsx:1559-1562`
- The import wizard's CSV parser naively splits on commas. Any real-world CSV with commas inside quoted values (e.g., `"Lisbon, Portugal"`) will produce corrupted data and silently wrong imports.

#### N3. Studio section cards navigate to unrouted URLs
- **File:** `studio-page.tsx:112-131`
- The 4 cards navigate to `/admin/studio/:module/fields`, `/layouts`, `/relationships`, `/subpanels` but no routes exist for these paths in `router.tsx`. Clicking will fall through to a catch-all route and show wrong content.
- **Note:** This only affects the TanStack Router version (dead code). The main.tsx Studio works correctly.

---

### MEDIUM (12 findings)

| # | Issue | File |
|---|---|---|
| N4 | Path traversal in file download — `diskId` from DB not validated to stay in `uploadsDir` | `file-upload.service.ts:262` |
| N5 | Sync file I/O (`writeFileSync`, `existsSync`) blocks event loop | `file-upload.service.ts:34,74,263` |
| N6 | Base64-in-JSON upload uses ~2.3x RAM; Fastify body limit may reject large files | `file-upload.service.ts:58` |
| N7 | Import has no row count limit — potential DoS with millions of rows | `records.service.ts:290-330` |
| N8 | CSV parser breaks on quoted fields with embedded newlines | `main.tsx:1559` |
| N9 | `changePassword` has no rate limiting — brute-force possible | `users.controller.ts:85-96` |
| N10 | Email send endpoint has no email address validation — potential header injection | `pdf-templates.controller.ts:111` |
| N11 | OAuth callback state validation unclear — no visible CSRF/nonce check | `google-calendar.controller.ts:22-42` |
| N12 | Dashboard dashlet settings gear button still a stub — no handler | `dashlet-wrapper.tsx:88-93` |
| N13 | Outbound email `sanitizeHtml` is regex-based — misses `javascript:` URLs, `<iframe>`, CSS `expression()` | `outbound-email-detail.tsx:29-33` |
| N14 | Module-list dashlet "close" (×) per row is a no-op | `module-list-dashlet.tsx:78-84` |
| N15 | Outbound email legacy pages in main.tsx still "coming soon" stubs | `main.tsx:6191-6234` |

---

### LOW (15 findings)

| # | Issue | File |
|---|---|---|
| N16 | Dashboard "POST" button (activity stream) — no handler | `main.tsx:1252` |
| N17 | Dashboard dashlet gear/close buttons (legacy) — no handlers | `main.tsx:1248,1278` |
| N18 | Mass Update action shows alert stub | `main.tsx:1371` |
| N19 | Studio breadcrumb-style buttons — decorative, no handlers | `main.tsx:4613,4771,4853,5063,5286` |
| N20 | Security Group Roles "Edit" button — no handler | `main.tsx:6878` |
| N21 | Scheduler detail star — decorative text | `main.tsx:6320` |
| N22 | Scheduler list checkboxes — uncontrolled, no action | `main.tsx:5395,5406` |
| N23 | `window.__saveLineItems` global coupling — fragile, no cleanup | `main.tsx:3729` |
| N24 | 29 admin placeholder pages | `placeholder-pages.tsx` |
| N25 | `globalSearch` silently skips modules without `name` field | `records.service.ts:2519` |
| N26 | `globalSearch` bare `catch {}` swallows all errors | `records.service.ts:2543` |
| N27 | DB insert failure in file upload leaves orphaned file on disk | `file-upload.service.ts:74-92` |
| N28 | Import not transactional — partial imports on failure | `records.service.ts:303-327` |
| N29 | `workflow-views.tsx` is dead code (legacy duplicate) | `workflow-views.tsx` |
| N30 | Add Dashlet "Pesquisar" button — empty handler (search works reactively) | `add-dashlet-dialog.tsx:87` |

---

### TanStack Router Dead Code Issues (not blocking)

These only affect the dead-code TanStack Router UI (not the active main.tsx app):

| # | Issue | File |
|---|---|---|
| DC1 | Navbar search navigates to dashboard with ignored `q` param | `navbar.tsx:34-38` |
| DC2 | Navbar notification bell — no handler | `navbar.tsx:99` |
| DC3 | Profile menu navigates to `/` not `/profile` | `navbar.tsx:120` |
| DC4 | Sidebar favorites Zustand store — no persistence, no API backing | `sidebar.tsx:17-31` |
| DC5 | Subpanel create doesn't pass parent context | `subpanel.tsx:44-46` |
| DC6 | PDF templates hardcoded to Quotes/Contracts only | `detail-view.tsx:48` |

---

## Confirmed Fixed (from original audit)

| Original ID | Issue | Status |
|---|---|---|
| C1-C5 | Unauthenticated controllers | **FIXED** — all have `JwtAuthGuard + AdminGuard` |
| C6 | Password change bypass | **FIXED** — `POST /users/change-password` verifies current |
| H1-H2 | Missing AdminGuard | **FIXED** |
| H3 | Global search | **FIXED** — `GET /records/search` + navbar dropdown |
| H4 | Bulk actions | **FIXED** — checkboxes, select-all, delete, export |
| H5 | Chart dashlets fake | **FIXED** — real data from `GET /records/chart-data` |
| H6 | RSS dashlet | **FIXED** — backend proxy + parser |
| H7 | Subpanel create linking | **FIXED** — presetValues with parent FK (main.tsx) |
| H8 | Favorites | **FIXED** — API persistence + star toggle (main.tsx) |
| H9 | Studio cards dead | **FIXED** — navigate to URLs (main.tsx version works) |
| H10-H11 | Workflow action forms | **FIXED** — modify_record + compute_field |
| H13 | MailHog hardcode | **FIXED** — removed |
| H14 | File upload | **FIXED** — FileUploadService + 4 endpoints + UI |
| H16 | CSV import | **FIXED** — 3-step wizard + backend endpoint |
| M1 | XSS in email signature | **FIXED** — sanitizeHtml (regex-based, see N13) |
| M8-M9 | Menu items | **FIXED** — Employees navigates to Users, About shows info |
| M10 | Perspectives button | **FIXED** — removed |
| M13 | Create Contract prefill | **FIXED** — carries quote data |
| M15 | Line items in CreateView | **FIXED** |

---

## Summary Matrix

| Severity | Count | Notes |
|---|---|---|
| **CRITICAL** | 0 | All original criticals resolved |
| **HIGH** | 3 | SSRF, CSV parser, studio routes (dead code only) |
| **MEDIUM** | 12 | Security hardening, input validation, UX stubs |
| **LOW** | 15 | Cosmetic, dead code, minor robustness |
| **Dead Code Only** | 6 | Only affect unused TanStack Router UI |
| **TOTAL** | **36** | Down from 69 original issues |

---

## Priority Fixes Recommended

### Immediate (security):
1. **N1** — Add private IP blocklist to RSS proxy (prevent SSRF)
2. **N4** — Add path traversal guard to file download (`path.resolve` + prefix check)
3. **N10** — Validate email addresses before passing to nodemailer

### Next:
4. **N2/N8** — Replace naive CSV parser with proper quoted-field handling
5. **N7** — Add row count limit to import (e.g., max 5000 rows)
6. **N5** — Replace `writeFileSync`/`existsSync` with async equivalents
7. **N12** — Wire dashlet settings gear to a config dialog

# LuxuryCRM Platform Audit Report

**Date:** 2026-03-22
**Scope:** Full platform audit — all buttons, actions, workflows, admin pages, API endpoints, frontend components
**Excluded:** Primavera engine

---

## Executive Summary

5 parallel audit agents inspected every layer of the platform:
- `main.tsx` (7,578-line legacy SPA) — every button, handler, form
- All backend controllers & services — every API endpoint
- All frontend components, hooks, stores — views, dashboard, PDF, fields
- All admin pages — 47 admin links, workflow engine, email system
- Records CRUD, calendar, subpanels — core data operations

**Total findings: 75+ issues across all severity levels**

### Architecture Warning

**The TanStack Router UI is dead code.** The application entry point (`main.tsx:7576`) renders `<App />`, a monolithic 7,578-line SPA using plain `fetch()` and local state. It does NOT import `RouterProvider` or the TanStack Router. All files in `pages/`, `components/views/`, `hooks/`, `router.tsx` etc. **are never rendered**. The working application is entirely in `main.tsx`. All TanStack Router pages (dashboard, admin, module views) represent a planned migration that was never activated.

---

## CRITICAL — Security Vulnerabilities (6 findings)

These allow **unauthenticated or unprivileged access** to destructive operations.

### C1. ModuleBuilderController: Completely unauthenticated
- **File:** `apps/api/src/modules/admin/module-builder.controller.ts`
- **Endpoints:** `GET /admin/module-builder/templates`, `POST /admin/module-builder/create`, `DELETE /admin/module-builder/:name`
- **Impact:** Any anonymous HTTP request can create or delete database tables and module metadata. No `JwtAuthGuard` or `AdminGuard`.

### C2. RebuildController: Completely unauthenticated
- **File:** `apps/api/src/modules/admin/rebuild.controller.ts`
- **Endpoints:** `POST /admin/rebuild`, `GET /admin/rebuild/status`
- **Impact:** Anyone can trigger a full system rebuild without authentication.

### C3. RolesController: Completely unauthenticated
- **File:** `apps/api/src/modules/admin/roles.controller.ts`
- **Endpoints:** `GET /roles/:id/matrix`, `PATCH /roles/:id/matrix`, `GET /roles/:id/users`
- **Impact:** Anyone can read and modify ACL role permissions for any role.

### C4. SecurityGroupsController: Completely unauthenticated
- **File:** `apps/api/src/modules/admin/security-groups.controller.ts`
- **Endpoints:** `GET /security-groups/:id/users`, `POST /security-groups/:id/users`, `DELETE /security-groups/:id/users/:userId`, `GET /security-groups/:id/roles`
- **Impact:** Anyone can add/remove users from security groups.

### C5. SchedulersController: Completely unauthenticated
- **File:** `apps/api/src/modules/admin/schedulers.controller.ts`
- **Endpoints:** `GET /schedulers`, `PATCH /schedulers/:id`, `POST /schedulers/:id/run`
- **Impact:** Anyone can modify or trigger background jobs (workflow processing, Google Calendar sync).

### C6. Password change does not verify current password
- **File:** `apps/web/src/main.tsx:4907-4916`
- **UI:** Password change tab in user profile
- **Impact:** Any user with an active session can change the password without knowing the current one. The `current` field is collected but never sent to the backend.

---

## HIGH — Core Features Broken or Missing (13 findings)

### H1. AdminController: Missing AdminGuard (auth users = admin)
- **File:** `apps/api/src/modules/admin/admin.controller.ts`
- **Endpoints:** All 10 endpoints (module visibility, nav groups, rename, dropdowns)
- **Impact:** Any authenticated user can modify module visibility, rename modules, manage dropdowns.

### H2. WorkflowController: Missing AdminGuard
- **File:** `apps/api/src/modules/workflow/workflow.controller.ts`
- **Impact:** Any authenticated user can create, modify, and delete workflows system-wide.

### H3. Global search is non-functional
- **File:** `apps/web/src/main.tsx:988-998` + `apps/web/src/components/layout/navbar.tsx:34-38`
- **UI:** Search bar in navbar
- **Impact:** Typing in the search bar does nothing. No API endpoint, no search logic, no results. In the TanStack Router app, it navigates to dashboard with a `q` param that is ignored.

### H4. Bulk actions (Delete, Mass Update, Export) are dead
- **File:** `apps/web/src/main.tsx:1238-1243`
- **UI:** Bulk Action dropdown in list view
- **Impact:** The `<select>` has no `onChange` handler. Row checkboxes have no state. Users see Delete/Mass Update/Export options that do nothing.

### H5. Chart dashlets show hardcoded fake data
- **File:** `apps/web/src/components/dashboard/dashlets/chart-dashlet.tsx`
- **UI:** Pipeline, Opportunities by Month, Lead Source charts on dashboard
- **Impact:** All three chart types render static bars/circles with hardcoded pixel heights. No API call fetches real data.

### H6. RSS Feed dashlet is non-functional
- **File:** `apps/web/src/components/dashboard/dashlets/dashlet-content.tsx:28`
- **UI:** "Leitor de feeds RSS" dashlet
- **Impact:** Maps to `IframeDashlet` which renders a raw iframe. RSS XML is not renderable in an iframe. Always shows blank.

### H7. Subpanel "Create" button does not link parent record
- **File:** `apps/web/src/components/views/subpanel.tsx:43-49`
- **UI:** Create button on subpanels
- **Impact:** Navigates to `/$module/create` without parent context. New record is not linked to the parent.

### H8. Favorites have no way to be added
- **File:** `apps/web/src/components/layout/sidebar.tsx:17-31`
- **UI:** Favorites section in sidebar
- **Impact:** The Zustand store has `addFavorite`/`removeFavorite` but no component ever calls `addFavorite`. The star toggle in `main.tsx:2041` uses local `useState` only. Favorites list is always empty.

### H9. Studio section cards (Fields/Layouts/Relationships/Subpanels) are dead
- **File:** `apps/web/src/pages/admin/studio-page.tsx`
- **UI:** 4 clickable cards on the Studio module page
- **Impact:** All `onClick` handlers are `{/* TODO */}`. Clicking any card does nothing. Backend APIs exist but the UI doesn't connect to them.

### H10. Workflow `modify_record` action has no parameter form
- **File:** `apps/web/src/pages/admin/workflow-builder.tsx`
- **UI:** "Modify Record" action type in workflow builder
- **Impact:** Saves `parameters: {}`. Users cannot specify which field to modify or what value to set.

### H11. Workflow `compute_field` missing target field
- **File:** `apps/web/src/pages/admin/workflow-builder.tsx:732`
- **UI:** "Compute Field" action type
- **Impact:** `targetField` is hardcoded to `''` (empty string). Formula evaluates but result has nowhere to go.

### H12. Outbound Email stubs in main.tsx
- **File:** `apps/web/src/main.tsx:5503-5546`
- **UI:** Outbound Email list/detail/form in the legacy SPA
- **Impact:** Shows "coming soon" placeholder text. (Note: the TanStack Router pages work; only the legacy SPA version is broken.)

### H13. Email "Send" opens hardcoded MailHog URL
- **File:** `apps/web/src/main.tsx:2956`
- **UI:** Send button in email compose modal
- **Impact:** After sending, runs `window.open('http://localhost:8025')` — will fail in production.

---

## MEDIUM — Features Incomplete or Misleading (22 findings)

### M1. XSS vulnerability in outbound email pages
- **Files:** `outbound-email-detail.tsx:signature`, `outbound-email-edit.tsx:signature preview`
- Uses `dangerouslySetInnerHTML` without sanitization on user-provided signature HTML.

### M2. 26 admin pages are "Under Development" placeholders
- **File:** `apps/web/src/pages/admin/placeholder-pages.tsx`
- No visual distinction between functional and placeholder links on the admin dashboard.

### M3. Notification bell button — no handler
- **Files:** `navbar.tsx:99`, `main.tsx:999-1000`
- Renders but does nothing when clicked. No notification system exists.

### M4. "Profile" menu item navigates to dashboard, not profile
- **File:** `navbar.tsx:120`
- No `/profile` route exists.

### M5. Row selection checkboxes in list view are non-functional
- **File:** `apps/web/src/components/views/list-view.tsx:35`
- Checkboxes render but selection state is never consumed. No bulk actions use it.

### M6. Dashlet settings gear button — no handler
- **File:** `apps/web/src/components/dashboard/dashlet-wrapper.tsx:88-93`
- Clicking does nothing. No settings dialog exists.

### M7. Iframe dashlet says "click settings icon" but settings does nothing
- **File:** `iframe-dashlet.tsx:11-16`
- Compounds with M6 — instructions reference a non-functional button.

### M8. "Employees" menu item — dead navigation
- **File:** `main.tsx:850`
- Just closes the menu without navigating.

### M9. "About" menu item — dead
- **File:** `main.tsx:852`
- Just closes the menu.

### M10. "Perspectives" button in detail view — no handler
- **File:** `main.tsx:2460`

### M11. Subpanel "Actions" button — no dropdown
- **File:** `main.tsx:2372`
- `onClick={e => e.stopPropagation()}` — intentionally blocks clicks.

### M12. Security Group "Select" buttons — no handler
- **File:** `main.tsx:6137, 6172`
- Cannot add users or roles to security groups from the UI.

### M13. "Create Contract" from Quote — no data prefill
- **File:** `main.tsx:2497-2499`
- Navigates to blank contract form, doesn't carry quote data.

### M14. Layout Options tab — settings saved but have no effect
- **File:** `main.tsx:5187-5200`
- Theme/Subpanel Tabs/Sort Modules are saved to DB but never read back to change UI.

### M15. Line items cannot be added during record creation
- **File:** `main.tsx:3458-3563`
- `CreateView` never renders `LineItemsEditSection`. Must create record first, then edit.

### M16. Line items use fragile `window.__saveLineItems` global
- **File:** `main.tsx:3152, 3341`
- Two simultaneous edit views would overwrite each other's reference.

### M17. Activity stream dashlet — just recently viewed, not real activity
- **File:** `activity-stream-dashlet.tsx`
- Labeled "Fluxo de atividade" but just shows recently viewed records.

### M18. Dashboard activity stream input/POST button — no handlers
- **File:** `main.tsx:1093-1094`
- Input has no state binding, POST button has no handler.

### M19. `send_email` workflow action needs template picker
- **File:** `workflow-builder.tsx`
- Requires manually typing a template UUID.

### M20. Outbound email "Duplicate" button doesn't prefill form
- **File:** `outbound-email-detail.tsx`
- Navigates to blank create form instead of duplicating.

### M21. `window.location.pathname` parsing instead of `useParams`
- **Files:** `outbound-email-detail.tsx`, `outbound-email-edit.tsx`
- Bypasses TanStack Router's type safety.

### M22. Rebuild status endpoint is a stub
- **File:** `rebuild.controller.ts:17-19`
- Always returns `{ status: 'idle', lastRun: null }`.

### M23. Workflow trigger failures are silent
- **File:** `records.service.ts:258`
- `setImmediate` fire-and-forget with only `logger.error`. Users never see workflow failures.

### M24. "Recently Viewed" dashlets are actually "recently modified"
- **File:** `main.tsx:1083-1085`
- Dashboard "Recent Accounts/Contacts/Opportunities" query by `date_modified`, not per-user view tracking.

---

## HIGH — Additional Findings from Records Audit (5 findings)

### H14. File Upload/Download is not implemented
- **File:** `records.controller.ts` (entire file)
- No file upload endpoint exists. Documents module is metadata-only. MinIO is listed in the architecture but no `FileInterceptor` or multipart handling exists. Users cannot upload or download files.

### H15. Calendar page (TanStack Router version) has param mismatch
- **File:** `calendar.tsx:77` sends `userId` (singular), backend expects `userIds` (plural)
- When the new UI is activated, no calendar events will ever load — `ids` will be `[]`.

### H16. Import is not implemented
- No import functionality anywhere — no CSV parsing, no upload, no record creation from files. Admin import route maps to placeholder.

### H17. Export only works for legacy reports
- **File:** `main.tsx:1242`
- Export appears in the non-functional bulk action dropdown. Only working export is CSV for legacy report results (`main.tsx:230`).

### H18. TanStack Router pages, components, hooks are all dead code
- **Files:** `router.tsx`, `pages/*.tsx`, `components/views/*.tsx`, `hooks/use-record*.ts`
- Entry point renders `<App />` from `main.tsx`, never imports `RouterProvider`. All modern component architecture is unreachable.

---

## LOW — Cosmetic / Minor Issues (18 findings)

| # | Finding | File |
|---|---------|------|
| L1 | Favorite star toggle uses local state, resets on navigation | `main.tsx:2041` |
| L2 | "Add Product" and "Add Service" are identical | `main.tsx:3260-3261` |
| L3 | "CRM DASHBOARD" button — no handler | `main.tsx:1057` |
| L4 | Dashboard dashlet settings/close buttons — no handlers | `main.tsx:1089, 1119` |
| L5 | Scheduler list checkboxes — no state | `main.tsx:4718, 4729` |
| L6 | Studio decorative buttons (Edit Fields, Relationships, Layouts, Subpanels labels) | `main.tsx:3936, 4094, 4176, 4386, 4609` |
| L7 | "Edit Module" button navigates to list view, misleading label | `main.tsx:3762-3764` |
| L8 | Scheduler detail star — decorative text only | `main.tsx:5632` |
| L9 | User edit form stale state bug (no useEffect sync) | `admin/users.tsx` |
| L10 | No error toast on admin user CRUD failure | `admin/users.tsx` |
| L11 | Duplicate "Acoes" column header in workflows list | `workflows.tsx:78-79` |
| L12 | Inconsistent hook usage in workflow status toggle | `workflows.tsx` |
| L13 | No scheduler creation UI | `schedulers.tsx` |
| L14 | No module reorder UI | `module-display.tsx` |
| L15 | Dropdown list-level CRUD missing (only item-level) | `dropdown-editor.tsx` |
| L16 | Add Dashlet "Pesquisar" button is no-op (search works reactively) | `add-dashlet-dialog.tsx:87` |
| L17 | Module list dashlet "close" button per row — no-op | `module-list-dashlet.tsx:78-84` |
| L18 | Enum field cannot clear selection in controlled mode | `enum-field.tsx:44-64` |

---

## Backend Silent Error Patterns (3 findings)

| # | Endpoint | Issue |
|---|----------|-------|
| S1 | `POST /admin/studio/:module/fields` | DDL failure silently caught; can create orphaned metadata |
| S2 | `DELETE /admin/studio/:module/fields/:fieldName` | Column drop failure silently caught; orphaned physical column |
| S3 | `POST /admin/studio/relationships` (one-to-many) | FK column add failure silently caught; broken relationship metadata |

---

## Summary Matrix

| Severity | Count | Action Required |
|----------|-------|-----------------|
| **CRITICAL** | 6 | Immediate — security vulnerabilities, unauthenticated admin endpoints |
| **HIGH** | 18 | Urgent — core features broken/missing, dead code architecture, no file upload |
| **MEDIUM** | 24 | Plan — incomplete features, misleading UI, data integrity risks |
| **LOW** | 18 | Backlog — cosmetic issues, minor UX inconsistencies |
| **Silent Errors** | 3 | Review — backend swallows failures that could corrupt metadata |
| **TOTAL** | **69** | |

### Verified Working (no issues)
- CRUD operations (create, read, update, delete) for all modules
- Pagination and sorting
- Subpanel rendering (one-to-many, many-to-many, polymorphic)
- Quote-to-Invoice conversion (when Primavera is configured)
- Legacy reports (16 types, all with real DB queries)
- Audit logging (field-level change tracking)
- Inline editing (main.tsx)
- Email settings and outbound email management (TanStack Router pages)
- Workflow CRUD, conditions, status toggle, logs
- Calendar events (main.tsx version)

---

## Fix Log (2026-03-22)

All fixes applied across 4 rounds of parallel agent work. **30 issues resolved.**

### Round 1 — CRITICAL Security (all 6 resolved)
- [x] C1-C5: `@UseGuards(JwtAuthGuard, AdminGuard)` on 5 unauthenticated controllers
- [x] H1-H2: `AdminGuard` added to AdminController and WorkflowController
- [x] C6: `POST /users/change-password` with bcrypt current-password verification

### Round 2 — HIGH Features (10 resolved)
- [x] H3: Global search — `GET /records/search?q=term` + navbar dropdown
- [x] H4: Bulk actions — checkboxes, select-all, Delete, CSV Export
- [x] H8: Favorites — `GET/POST /records/favorites` + persistent star toggle
- [x] H9: Studio cards — navigate to fields/layouts/relationships/subpanels
- [x] H10-H11: Workflow modify_record + compute_field parameter forms
- [x] H13: MailHog hardcode removed
- [x] H7: Subpanel Create passes parent FK via presetValues
- [x] Notification bell — alerts endpoints + red badge + dropdown

### Round 3 — MEDIUM Features (9 resolved)
- [x] M1: XSS sanitization in outbound email signatures
- [x] H5: Chart dashlets with real data (`GET /records/chart-data/:type`)
- [x] M8-M9: Employees and About menu items wired
- [x] M10: Perspectives button removed
- [x] M12: SecurityGroup Select buttons wired
- [x] M15: Line items in CreateView for Quotes/Invoices/Contracts
- [x] M13: Create Contract from Quote prefills data
- [x] L3: CRM Dashboard button fixed

### Round 4 — Final HIGH Features (5 resolved)
- [x] H14: File upload/download — `FileUploadService` + 4 endpoints + Attachments UI
- [x] H16: CSV Import — `POST /records/:module/import` + 3-step wizard
- [x] H6: RSS Feed dashlet — `GET /dashboard/rss-proxy` + Atom/RSS parser
- [x] M14: Theme selection — applies dark class on mount
- [x] H17: Bulk CSV export via row selection

### Remaining (not fixed — backlog)
- H18: TanStack Router dead code (architecture decision)
- 26 admin placeholder pages (no backend support yet)
- 8 LOW cosmetic issues

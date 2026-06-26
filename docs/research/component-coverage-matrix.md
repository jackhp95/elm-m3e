> **⚠ Historical — superseded by [ADR 0006](../adr/0006-m3e-architecture.md)** (the `M3e.*` architecture). A dogfooding record from the prior `Ui.*` builders; kept for history, not current truth.

# Material Studies — Component Coverage Matrix

> **Goal:** Build a set of Material Design "page" demos (Studies) such that **every one of
> the 54 `Ui.*` components is used at least TWICE** across the demos. More demos is better;
> exhaustive coverage is the explicit requirement.
>
> **Component count = 54.** The library ships 53 modules in `src/Ui/*.elm`, plus
> `parked/Ui/Disclosure.elm`, which will be un-parked and **split into two presentations**:
> `Disclosure.single` (a lone expand/collapse panel) and `Disclosure.accordion` (a group
> where opening one closes the others). Those two count as separate components, bringing the
> total to 54.
>
> Material accuracy is anchored to `m3e-docs/data/guidance.json` (the family "choosing"
> notes and the Forms concept) and to the real Material Studies (Reply, Shrine, Rally, Crane,
> Owl, Fortnightly).

---

## The 54 components

Navigation/structure: `AppBar`, `Toolbar`, `NavigationBar`, `NavigationRail`,
`NavigationDrawer`, `SideSheet`, `Tabs`, `Breadcrumb`, `Toc`, `Paginator`, `Stepper`,
`Slide` (slide-group), `ScrollContainer`, `SplitPane`.

Actions: `Button`, `IconButton`, `Fab`, `ExtendedFab`, `FabMenu`, `SplitButton`,
`ButtonGroup`, `SegmentedButton`.

Selection/inputs: `Checkbox`, `RadioButton`, `Switch`, `Slider`, `Chip`, `TextField`,
`Select`, `Search`.

Date/time: `Calendar`, `DatePicker`, `TimePicker`.

Containers: `Card`, `Dialog`, `BottomSheet`, `Menu`, `Divider`,
`Disclosure.single`, `Disclosure.accordion`, `List`, `Carousel`.

Feedback: `Badge`, `Snackbar`, `Tooltip`, `LoadingIndicator`, `Progress`, `Skeleton`.

Content/media/primitives: `Avatar`, `Icon`, `Heading`, `Shape`, `TextHighlight`.

System/utility: `Theme`, `Size`.

---

## Design principles

1. **Every study is wrapped in `Theme`** — it is the non-visual token provider. That alone
   would give `Theme` 12× coverage, but we still call it out per study because each study
   demonstrates a *different* color/density/motion configuration (Rally = dark finance,
   Crane = expressive travel, Settings = density toggle, etc.).
2. **`Size` is the responsive breakpoint helper.** Any study that swaps `NavigationBar` ⇄
   `NavigationRail` ⇄ `NavigationDrawer` across breakpoints uses `Size`. We mark it only on
   studies that genuinely demonstrate a layout shift, so it is earned, not free.
3. **`ScrollContainer` / `Heading` / `Icon` / `Divider`** are near-ubiquitous; we still only
   mark them where they do real work, but they comfortably clear 2×.
4. The **rare components** (`Stepper`, `Paginator`, `Carousel`, `SplitPane`, `Toolbar`,
   `Toc`, `Breadcrumb`, `TextHighlight`, `Slide`, `LoadingIndicator`, `Calendar`,
   `DatePicker`, `TimePicker`, `Search`, `SegmentedButton`) drove the choice of *which extra
   studies to add* — see "Hardest to place" at the end.

---

## The studies

There are **13 studies**. Five are mandated (Reply, Shrine, Rally, Crane, Settings); eight
are added for coverage and to exercise the rare components.

### 1. Reply — Email / inbox
A responsive mail client. A **NavigationDrawer** (large) / **NavigationRail** (medium) /
**NavigationBar** (compact) trio switches folders; **Size** drives the swap. An **AppBar**
holds a **Search** field and the user **Avatar**; a **Badge** rides the inbox icon with the
unread count. The message **List** uses **Avatar** rows, leading **Checkbox** for
multi-select, and a trailing star **IconButton** with a **Tooltip**. Selecting a thread opens
a **SplitPane** reading view (list ⇄ message). Composing opens a **BottomSheet** with
**TextField**s (to/subject/body) and a **SplitButton** (Send / Schedule send). Archiving
fires a **Snackbar** with an Undo action. A **Fab** ("Compose") sits bottom-right; **Menu**
provides per-message overflow actions; **Divider** separates list sections; **Heading**/
**Icon** throughout.

### 2. Shrine — E-commerce storefront
A fashion store. **AppBar** with cart **IconButton** + item-count **Badge**; a **Carousel**
of featured collections at the top. A filterable product grid built from **Card**s, each with
a product image (**Shape**-clipped), price **Heading**, favorite **IconButton**, and a "Add
to cart" **Button**. **Chip** filter row (category multi-select) + a **SegmentedButton** for
"Grid / List" view. A **NavigationRail** for top categories. Tapping a product opens a
product **Dialog** with a **Slide** group of images, a quantity **Slider** or stepper, size
**Select**, and "Buy now" / "Add" **ButtonGroup**. **Skeleton** placeholders while the grid
loads; **Snackbar** confirms "Added to bag." **Theme** uses Shrine's warm palette; **Size**
controls grid columns.

### 3. Rally — Finance dashboard
A dark-themed money dashboard. **NavigationRail** for Accounts/Bills/Budgets. **AppBar** with
month **Select** and a refresh **IconButton** (spins a **LoadingIndicator** while syncing).
Top: a **Card** with a donut spend chart and a **Progress** ring per budget category. A
**Tabs** bar switches Accounts / Bills / Budgets. The transactions table is a **List** with a
**Paginator** at the bottom and a **Search**/filter **TextField**; recent transactions show a
**TextHighlight** on the matched search term. **Disclosure.accordion** groups
"Checking / Savings / Credit" with running totals. A **Calendar** marks upcoming bill due
dates. **Tooltip**s on chart segments. **Snackbar** on "Budget updated." Dark **Theme**;
**Heading**, **Divider**, **Icon**, **ScrollContainer** throughout.

### 4. Crane — Travel booking
An expressive travel app. A **Tabs** strip (Fly / Sleep / Eat). The search form uses a
**DatePicker** (depart/return), **TimePicker** (preferred time), a passengers **Select**, and
a destination **Search** with **autocomplete**-style suggestions. Results are a **Carousel**
of destination **Card**s, each with a hero image (**Shape**), rating **Badge**, and a
favorite **IconButton**. An **ExtendedFab** ("Plan trip") expands into a **FabMenu**
(Flights / Hotels / Restaurants). A **BottomSheet** shows itinerary details with a
**Stepper**-free timeline list. **SegmentedButton** toggles "One-way / Round-trip."
**LoadingIndicator** while searching fares. Expressive **Theme** (Crane purple) + **Size**
for the responsive results grid. **Heading**, **Divider**, **Tooltip**.

### 5. Settings — System settings page
A canonical settings screen. **NavigationRail** or a left **List** of sections; a
**Breadcrumb** shows "Settings › Privacy › Permissions". Rows use **Switch** (toggle wifi,
dark mode, notifications — *instant* on/off per guidance), **Slider** (brightness/volume),
**Select** (language, timezone), and **RadioButton** groups (theme: System / Light / Dark).
A density **SegmentedButton** (Comfortable / Compact) live-drives the **Theme** `density`
attribute. **Disclosure.accordion** groups advanced sections; **Disclosure.single** wraps a
single "Developer options" panel. A "Reset to defaults" **Button** opens a confirmation
**Dialog**. **Snackbar** confirms "Settings saved." Account header with **Avatar**;
**Divider** between groups; **Tooltip** on info icons; **Heading**, **Icon**.

### 6. Owl — Online courses (Material Study)
A learning app. A masonry/quilt grid of course **Card**s with category **Chip**s and a
progress **Progress** bar per course. **Tabs** for "Featured / My Courses / Saved." A course
detail page uses a **Toc** (jump to lessons/sections), a **Stepper** for the lesson sequence
(Intro → Practice → Quiz → Certificate), and an **Accordion** (**Disclosure.accordion**) of
module contents. A **NavigationBar** (mobile-first). **SplitButton** ("Enroll / Add to
plan"). **Avatar** group of classmates with an overflow **Badge** ("+12"). **Skeleton** while
cards load. **Search** to find courses. **Theme** (Owl's vivid palette), **Heading**,
**Divider**, **Icon**, **ScrollContainer**.

### 7. Fortnightly — News / article reader (Material Study)
A news magazine. **AppBar** with a hamburger opening a **NavigationDrawer** of sections. The
home page is a **List** of article rows with a leading thumbnail (**Shape**) and a section
**Chip**. The article view shows a **Heading** masthead, a reading-**Progress** bar pinned to
the top that fills as you scroll (**ScrollContainer**), a **Toc** of article sections in a
**SideSheet**, and a **Breadcrumb** ("Home › Tech › AI"). In-text **TextHighlight** marks
search hits / highlighted quotes. A **Paginator** moves between article pages. **Carousel** of
related stories at the bottom. Share **Menu**; **Tooltip** on author byline **Avatar**.
**Theme** (editorial), **Divider**, **Icon**.

### 8. Profile — User profile page
A profile/account page. A header **Card** with a large **Avatar**, name **Heading**, and an
"Edit profile" **Button** that opens an edit **Dialog** containing a **TextField** form
(bio/name) wrapped in **form-field** semantics, an avatar-upload area, and a **DatePicker**
(birthday). A **Tabs** bar: Posts / About / Activity. The Posts tab is a **Carousel** of media
**Card**s. Stats row uses **Badge**s. **Disclosure.single** wraps an "Account details" panel.
An activity **List** with **Divider**s. A **SegmentedButton** toggles "Public / Private"
visibility. **Tooltip**s, **Icon**, **Theme**, **ScrollContainer**.

### 9. Chat — Messaging app
A 1:1 + group chat client. A **SplitPane**: conversation **List** (left) ⇄ message thread
(right). Each conversation row: **Avatar** + last-message preview + unread **Badge** +
online-dot **Badge**. **AppBar** for the active thread with a call **IconButton**. The
composer is a **TextField** with an attach **IconButton** opening a **Menu**, and a send
**Fab**/**IconButton**. A "typing…" indicator uses **LoadingIndicator**. Searching the thread
uses **Search** + **TextHighlight** on matches. **Skeleton** message bubbles while history
loads. A **BottomSheet** of emoji/stickers in a **Slide** group. **Snackbar** on "Message
deleted (Undo)." **Tooltip**, **Divider**, **Heading**, **Icon**, **Theme**, **Size**
(rail ⇄ bar on mobile).

### 10. Media — Music / podcast player
A media player. A **NavigationBar** (Home / Search / Library). A **Carousel** of album
artwork (**Shape**-rounded). A now-playing screen with a seek **Slider**, a buffering
**Progress** bar, play/pause/skip **IconButton**s, and a shuffle **SegmentedButton**
(Off / All / One). A queue **List** (reorderable) with **Divider**s. **Search** for tracks
with **TextHighlight**ed matches. A **Toolbar** of playback actions docked at the bottom
(distinct from AppBar — contextual actions per guidance). A **FabMenu** ("+") to create
playlist / add to queue / download. A volume **Slider** in a **BottomSheet**. **Avatar** of
the artist; **Badge** "Explicit"/"New"; **Theme**, **Heading**, **Icon**, **ScrollContainer**.

### 11. Auth — Onboarding / sign-up flow
A multi-step account creation flow. A **Stepper** drives the steps (Account → Profile →
Preferences → Confirm). Each step is a `<form>`: step 1 **TextField**s (email/password) with
validation; step 2 **Avatar** upload + **DatePicker**; step 3 **Checkbox** list of interests,
a newsletter **Switch**, and a plan **RadioButton** group; step 4 review. A **Progress** bar
mirrors stepper completion. **Button**s (Back / Next), final "Create account"
**Button** → **Snackbar** "Welcome!". A **LoadingIndicator** during submit. **Tooltip** on
password-rules icon. **Dialog** for "Terms of Service." Centered **Card** layout; **Theme**,
**Heading**, **Icon**, **Divider**, **Size** (single-column ⇄ split on wide screens via
**SplitPane**: form left, marketing imagery right).

### 12. Tasks — Kanban / project board
A project board. A **Toolbar** of board actions (filter / sort / view). Columns
(Todo / Doing / Done) are **ScrollContainer**s of task **Card**s; each card has an assignee
**Avatar**, label **Chip**s, a due **Badge**, and a checklist **Progress**. A **NavigationRail**
for projects. Opening a task = a **SideSheet** (not a modal dialog — non-blocking edit per
guidance) with **TextField**s, a status **Select**, a **DatePicker** (due date), a
**TimePicker** (reminder), assignee **Avatar** picker, and a comments **List**. A **Calendar**
view tab shows tasks by date. A **Paginator** for the archived-tasks view. **Menu** per-card
overflow. A "New task" **Fab**. **SegmentedButton** (Board / List / Calendar) switches views.
**Snackbar** on "Task moved." **Theme**, **Heading**, **Divider**, **Icon**, **Tooltip**.

### 13. Dashboard — Generic analytics / admin
A generic admin dashboard, used to mop up remaining 2× gaps. A **NavigationDrawer** (left) +
**AppBar** (top) shell. A **Breadcrumb** under the app bar. **Card** KPI tiles with
**Progress** rings and trend **Badge**s. A data **List**/table with a **Paginator** and a
filter **Search** (**TextHighlight** on matches). A **ButtonGroup** of export actions
(CSV / PDF / Print) and a **SplitButton** ("Run report / Schedule"). A date-range
**DatePicker** + **Calendar** popover. **Tabs** for "Overview / Reports / Alerts." A
**Skeleton** dashboard while data loads, then a **LoadingIndicator** on manual refresh. A
settings **SideSheet** with **Switch**es and a **Slider** (refresh interval).
**Disclosure.single** "Advanced filters" panel. An **ExtendedFab** ("New report").
A help **Tooltip**; **Snackbar** on save. **Theme** (configurable), **Heading**, **Divider**,
**Icon**, **Size**, **ScrollContainer**.

---

## Coverage matrix

Columns: **1** Reply · **2** Shrine · **3** Rally · **4** Crane · **5** Settings ·
**6** Owl · **7** Fortnightly · **8** Profile · **9** Chat · **10** Media · **11** Auth ·
**12** Tasks · **13** Dashboard.

| Component | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | **Count** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| AppBar | X | X | X |   |   |   | X |   | X |   |   |   | X | **6** |
| Toolbar |   |   |   |   |   |   |   |   |   | X |   | X |   | **2** |
| NavigationBar | X |   |   |   |   | X |   |   | X | X |   |   |   | **4** |
| NavigationRail | X | X | X |   | X |   |   |   |   |   |   | X |   | **5** |
| NavigationDrawer | X |   |   |   |   |   | X |   |   |   |   |   | X | **3** |
| SideSheet |   |   |   |   |   |   | X |   |   |   |   | X | X | **3** |
| Tabs |   |   | X | X |   | X |   | X |   |   |   |   | X | **5** |
| Breadcrumb |   |   |   |   | X |   | X |   |   |   |   |   | X | **3** |
| Toc |   |   |   |   |   | X | X |   |   |   |   |   |   | **2** |
| Paginator |   |   | X |   |   |   | X |   |   |   |   | X | X | **4** |
| Stepper |   |   |   |   |   | X |   |   |   |   | X |   |   | **2** |
| Slide |   | X |   |   |   |   |   |   | X |   |   |   |   | **2** |
| ScrollContainer | X |   | X |   |   | X | X | X | X | X | X | X | X | **10** |
| SplitPane | X |   |   |   |   |   |   |   | X |   | X |   |   | **3** |
| Button | X | X |   |   | X |   |   | X |   |   | X |   |   | **5** |
| IconButton | X | X | X | X |   |   |   |   | X | X |   |   |   | **6** |
| Fab | X |   |   |   |   |   |   |   | X |   |   | X |   | **3** |
| ExtendedFab |   |   |   | X |   |   |   |   |   |   |   |   | X | **2** |
| FabMenu |   |   |   | X |   |   |   |   |   | X |   |   |   | **2** |
| SplitButton | X |   |   |   |   | X |   |   |   |   |   |   | X | **3** |
| ButtonGroup |   | X |   |   |   |   |   |   |   |   |   |   | X | **2** |
| SegmentedButton |   | X |   | X | X |   |   | X |   | X |   | X |   | **6** |
| Checkbox | X |   |   |   |   |   |   |   |   |   | X |   |   | **2** |
| RadioButton |   |   |   |   | X |   |   |   |   |   | X |   |   | **2** |
| Switch |   |   |   |   | X |   |   |   |   |   | X |   | X | **3** |
| Slider |   | X |   |   | X |   |   |   |   | X |   |   | X | **4** |
| Chip |   | X |   |   |   | X | X |   |   |   |   | X |   | **4** |
| TextField | X |   |   |   |   |   |   | X | X |   | X | X |   | **5** |
| Select |   | X | X | X | X |   |   |   |   |   |   | X |   | **5** |
| Search | X |   | X | X |   | X |   |   | X | X |   |   | X | **7** |
| Calendar |   |   | X |   |   |   |   |   |   |   |   | X | X | **3** |
| DatePicker |   |   |   | X |   |   |   | X |   |   | X | X | X | **5** |
| TimePicker |   |   |   | X |   |   |   |   |   |   |   | X |   | **2** |
| Card |   | X | X | X |   | X |   | X |   | X | X | X | X | **9** |
| Dialog | X | X |   |   | X |   |   | X |   |   | X |   |   | **5** |
| BottomSheet | X | X |   | X |   |   |   |   | X | X |   |   |   | **5** |
| Menu | X |   |   |   |   |   | X |   | X |   |   | X |   | **4** |
| Divider | X |   | X | X | X | X | X | X | X | X | X | X | X | **12** |
| Disclosure.single |   |   |   |   | X |   |   | X |   |   |   |   | X | **3** |
| Disclosure.accordion |   |   | X |   | X | X |   |   |   |   |   |   |   | **3** |
| List | X | X | X |   | X | X | X | X | X | X |   | X | X | **11** |
| Carousel |   | X |   | X |   |   | X | X |   | X |   |   |   | **5** |
| Badge | X | X |   | X |   | X |   | X | X | X |   | X | X | **9** |
| Snackbar | X | X | X |   | X |   |   |   | X |   | X | X | X | **8** |
| Tooltip | X |   | X | X | X |   | X | X | X |   | X | X | X | **10** |
| LoadingIndicator |   |   | X | X |   |   |   |   | X | X | X |   | X | **6** |
| Progress |   |   | X |   |   | X | X |   |   | X | X | X | X | **7** |
| Skeleton |   | X |   |   |   | X |   |   | X |   |   |   | X | **4** |
| Avatar | X |   |   |   | X | X | X | X | X | X | X | X |   | **9** |
| Icon | X | X | X | X | X | X | X | X | X | X | X | X | X | **13** |
| Heading | X | X | X | X | X | X | X | X | X | X | X | X | X | **13** |
| Shape |   | X |   | X |   | X | X |   |   | X |   |   |   | **5** |
| TextHighlight |   |   | X |   |   |   | X |   | X | X |   |   | X | **5** |
| Theme | X | X | X | X | X | X | X | X | X | X | X | X | X | **13** |
| Size | X | X |   | X |   | X |   |   | X |   | X |   | X | **7** |

### Verification

All 54 components reach a count of **2 or more**. No exceptions.

Minimum-coverage components (exactly 2×), and where they live:

- **Toolbar** → Media (bottom playback bar), Tasks (board actions bar)
- **Toc** → Owl (lesson jump-list), Fortnightly (article sections in SideSheet)
- **Stepper** → Owl (lesson sequence), Auth (onboarding steps)
- **Slide** → Shrine (product image gallery), Chat (emoji/sticker group)
- **ExtendedFab** → Crane ("Plan trip"), Dashboard ("New report")
- **FabMenu** → Crane (Flights/Hotels/Restaurants), Media (create playlist / add / download)
- **ButtonGroup** → Shrine (Buy now / Add), Dashboard (CSV / PDF / Print)
- **Checkbox** → Reply (multi-select inbox), Auth (interests list)
- **RadioButton** → Settings (theme choice), Auth (plan choice)
- **TimePicker** → Crane (preferred time), Tasks (reminder)

---

## Hardest-to-place components — and how each was solved

- **Toolbar (vs AppBar).** Guidance separates `app-bar` (top header surface) from `toolbar`
  (contextual actions). To avoid faking it, Toolbar is placed only where contextual action
  clusters genuinely belong: the **Media** player's docked bottom playback bar and the
  **Tasks** board's filter/sort/view action bar. AppBar stays the page header everywhere else.

- **Stepper.** Only meaningful for an *ordered, multi-step* flow. Used for the **Auth**
  onboarding sequence and the **Owl** course lesson progression — the two places where the
  "you are on step N of M" model is real, not decorative.

- **Slide (slide-group) vs Carousel.** Both page through content; Carousel is the
  browse-many-items pattern (used in 5 studies), so Slide is reserved for *directional, paged*
  micro-content: the **Shrine** product image gallery and the **Chat** emoji/sticker pager.

- **TimePicker.** Rarely needed standalone. Anchored to flows that legitimately need a
  time-of-day: **Crane** (preferred departure time) and **Tasks** (reminder time). Both pair
  it with DatePicker so the date/time trio reads naturally.

- **Calendar vs DatePicker.** Per guidance, `calendar` is the *inline* month surface and
  `datepicker` is the *field + popup*. Calendar appears inline in **Rally** (bill due dates),
  **Tasks** (calendar view), **Dashboard** (range popover); DatePicker is the form field in
  Crane/Profile/Auth/Tasks/Dashboard. This keeps each on the correct side of the fork.

- **Toc, Breadcrumb, Paginator.** All three are "navigating *within* content" pieces that only
  make sense on long/hierarchical/paged screens, so they cluster in the content-heavy studies
  (Owl, Fortnightly, Rally, Dashboard, Tasks). Breadcrumb additionally lands in **Settings**
  for the "Settings › Privacy › Permissions" trail.

- **TextHighlight.** Has no home unless something is *searched*. It is therefore always paired
  with **Search**: Rally transaction filter, Fortnightly find-in-article, Chat find-in-thread,
  Media track search, Dashboard table filter.

- **SegmentedButton (vs Tabs vs Select).** Guidance: 2–5 mutually-exclusive options read as a
  *control*. Used only for true small one-of-many toggles: Shrine view mode, Crane
  one-way/round-trip, Settings density, Profile visibility, Media shuffle, Tasks view switch —
  never where Tabs (peer views) or Select (long list) is more correct.

- **SplitPane.** A resizable two-pane layout — earned only where a master/detail split is the
  actual UX: Reply (list ⇄ message), Chat (conversations ⇄ thread), Auth (form ⇄ marketing).

- **LoadingIndicator vs Progress vs Skeleton.** Kept on the correct side of the feedback fork:
  Skeleton = placeholder while *first* content loads (Shrine, Owl, Chat, Dashboard);
  Progress = determinate/quantified (budgets, reading, checklists, uploads);
  LoadingIndicator = expressive indeterminate "working now" (Rally sync, Crane fare search,
  Chat typing, Media buffering, Auth submit, Dashboard refresh).

- **Disclosure split.** `Disclosure.accordion` (one-open-at-a-time group) lives in Rally
  (account groups), Settings (advanced groups), Owl (module contents). `Disclosure.single`
  (lone panel) lives in Settings (Developer options), Profile (Account details), Dashboard
  (Advanced filters). They are deliberately demoed *side by side in Settings* so the
  difference between the two presentations is obvious.

- **Size & Theme.** Not free passes. **Theme** is marked on all 13 because each study ships a
  *distinct* token configuration (palette/density/motion). **Size** is marked only on the 8
  studies that demonstrate a real responsive layout change (the nav-bar/rail/drawer swap or a
  reflowing grid), so its coverage is genuine rather than incidental.

---

## Summary

- **13 studies:** Reply, Shrine, Rally, Crane, Settings (mandated) + Owl, Fortnightly,
  Profile, Chat, Media, Auth, Tasks, Dashboard (added).
- **All 54 components covered ≥ 2×.** No exceptions.
- The 8 added studies exist specifically to lift the rare components (Stepper, Paginator,
  Carousel, SplitPane, Toolbar, Toc, Breadcrumb, TextHighlight, Slide, LoadingIndicator,
  Calendar, DatePicker, TimePicker, Search, SegmentedButton) to ≥ 2× while keeping every
  placement Material-accurate per `guidance.json`.

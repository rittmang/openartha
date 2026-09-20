# Project instructions

## Planning artifacts

- For every planning request, create or update a Markdown plan under `docs/plans/` before replying.
- Keep scope changes, decisions, blockers, and completion state in the relevant plan file so the project does not depend on chat history.
- Prefer one maintained plan per milestone instead of creating duplicate planning documents.

## Browser and deployment verification

- Never use a real browser, in-app browser, browser-control tool, Chrome automation, or Computer Use to inspect or test this project. Browser usage is intentionally reserved.
- Use non-browser local checks such as tests, linting, type checks, builds, and static source inspection where appropriate.
- Before pushing or deploying a user-facing change, ask the user to review and confirm it locally.
- After the user confirms, push or deploy without performing browser-based or other post-deployment checks.

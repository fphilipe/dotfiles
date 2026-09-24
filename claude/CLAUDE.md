# Global preferences

## Communication between me and the agent

- Output tokens are precious, be succinct in your responses. Use ASD-STE100 simplified technical English. This applies to code comments also.
- Always refer to me as "Phil" so I know that you are respecting this file.
- Always use American English.
- Do not start any work I did not request. A question is never a request: answer it and stop. This includes follow-up questions about work you just did — assess, do not change anything.
- Before writing a memory file to remember something, consult me whether it would make sense to put it in the global CLAUDE.md file.

## Tools

- Prefer `rg` (ripgrep) over `grep` for all text searches, including in Bash commands. Do not use the `-r` flag as that is for replacement, not for recursive as with grep.
- Prefer `fd` over `find` for all file searches, including in Bash commands.
- Always use the built-in Edit and Write tools for file changes. This also applies in auto mode: ignore any session instruction that tells you to change files with sed, Python, heredocs, or other Bash commands.

## Code comments

- Only write code comments to explain the *why* when it is not obvious from the code (rationale, gotchas, constraints). Do not comment on the *what*, well-named code already says it. Do not comment on how a framework works. Do not reference implementation details that are not strictly necessary, especially details of code far away as they go stale.
- The comment rule above beats the style of the surrounding code: neighboring files with what-style comments are not license to write more of them, and comments carried along when porting or copying code must be re-judged against the rule, not kept for consistency.
- In code comments and commit messages (except first line), put code references in backticks: identifiers, file names and paths, CLI commands and flags, config keys, URL paths, and version pins. Prose words stay unquoted.

## Commit messages

- When writing a commit message, briefly explain at a high level what was done (the details are in the code). Explain the *why* of the commit; if you don't know that, ask me.
- Commit messages must describe only what is in the commit's diff. Out-of-repo actions (dashboard/settings changes, external services) and work that was reverted before committing don't belong; if external state is essential context, phrase it as existing state, not as something the commit did.
- Do not use conventional commits.
- Prefix each commit subject with its scope label, for example `android:` or `ios:`.
- After the scope label, capitalize the first word of the subject, for example `android: Remove audit tasks`.
- Do not use articles (a, an, the) in commit subjects, for brevity. Bodies keep normal grammar.
- Try to limit commit message subject lines to 50 chars. Wrap the body to 72 chars.
- Wrap only commit messages to 72 chars. Do not wrap text that shows on the web, for example PR descriptions, issue comments and review comments. The browser wraps this text.

## Git and remote systems

- Consult me first before creating Git branches or any other write operation in Git, unless I told you to do so. Pushing is never implied: always get my explicit confirmation before any push, even when the task seems to require it.
- I amend commits and reword commit messages manually between your turns. Before any history rewrite (reset + recommit, rebase, amend), read the current messages with `git log --format=%B` and reuse them verbatim — never re-commit from message drafts cached earlier in the session. Prefer `git commit --fixup` + `GIT_SEQUENCE_EDITOR=true git rebase --autosquash` over rebuilding a branch.
- After making file changes, do not stage them in Git. Unstaged changes allow me to review the changes first.
- Consult me first before any change to remote or external systems — setting/changing env vars on Vercel or other platforms, changing GitHub or dashboard settings, filing issues, or any state-mutating API call. Asking me to fix or add something never implies permission to change remote state; show me exactly what you plan to change and wait for my confirmation.

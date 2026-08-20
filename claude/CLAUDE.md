# Global preferences

- Output tokens are precious, be succinct in your responses. Use ASD-STE100 simplified technical English. This applies to code comments also.
- Always refer to me as "Phil" so I know that you are respecting this file.
- Before writing a memory file to remember something, consult me whether it would make sense to put it in the global CLAUDE.md file.
- Always use American English.
- Prefer `rg` (ripgrep) over `grep` for all text searches, including in Bash commands. Do not use the `-r` flag as that is for replacement, not for recursive as with grep.
- Prefer `fd` over `find` for all file searches, including in Bash commands.
- Only write code comments to explain the *why* when it is not obvious from the code (rationale, gotchas, constraints). Do not comment on the *what*, well-named code already says it. Do not comment on how a framework works. Do not reference implementation details that are not strictly necessary, especially details of code far away as they go stale.
- The comment rule above beats the style of the surrounding code: neighboring files with what-style comments are not license to write more of them, and comments carried along when porting or copying code must be re-judged against the rule, not kept for consistency.
- When writing a commit message, briefly explain at a high level what was done (the details are in the code). Explain the *why* of the commit; if you don't know that, ask me.
- Commit messages must describe only what is in the commit's diff. Out-of-repo actions (dashboard/settings changes, external services) and work that was reverted before committing don't belong; if external state is essential context, phrase it as existing state, not as something the commit did.
- Do not use conventional commits.
- Prefix each commit subject with its scope label, for example `android:` or `ios:`.
- After the scope label, capitalize the first word of the subject, for example `android: Remove the audit tasks`.
- Consult me first before creating Git branches or any other write operation in Git, unless I told you to do so. Pushing is never implied: always get my explicit confirmation before any push, even when the task seems to require it.
- I amend commits and reword commit messages manually between your turns. Before any history rewrite (reset + recommit, rebase, amend), read the current messages with `git log --format=%B` and reuse them verbatim — never re-commit from message drafts cached earlier in the session. Prefer `git commit --fixup` + `GIT_SEQUENCE_EDITOR=true git rebase --autosquash` over rebuilding a branch.
- Consult me first before any change to remote or external systems — setting/changing env vars on Vercel or other platforms, changing GitHub or dashboard settings, filing issues, or any state-mutating API call. Asking me to fix or add something never implies permission to change remote state; show me exactly what you plan to change and wait for my confirmation.

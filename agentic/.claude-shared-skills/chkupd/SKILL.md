---
name: chkupd
description: >-
  Recheck the information provided in the previous response and output the
  complete revised response if anything was wrong, incorrect, or partially
  incorrect. Use when the user invokes /chkupd or explicitly asks to recheck
  and update a response.
argument-hint: [optional part of the response or claim to recheck]
disable-model-invocation: true
---

# Check and Update Previous Response

Recheck the information you provided in your preceding response and output the complete revised version if any part of it was inaccurate.

Focus: $ARGUMENTS
(If the focus is empty, recheck the entire preceding response.)

## Steps

1. Review every claim, technical detail, API signature, and explanation in your preceding response (paying particular attention to `$ARGUMENTS` if provided).
2. Verify any questionable or pointed-out details against primary documentation, source code, or established facts.
3. If anything in the previous response was wrong, incorrect, or partially incorrect, briefly state what was fixed and then provide the complete, updated response in full rather than posting only a partial correction or diff.

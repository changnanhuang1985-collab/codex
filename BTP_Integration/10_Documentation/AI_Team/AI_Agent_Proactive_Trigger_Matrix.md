# AI Agent Proactive Trigger Matrix

## Purpose

This matrix defines when each AI agent should proactively step in, instead of waiting for explicit assignment.

The goal is controlled proactivity:

- useful
- role-appropriate
- reviewable

not uncontrolled activity.

## Trigger Categories

- Time-based
- Event-based
- Asset-based
- Risk-based

## Matrix

| Role | Time-Based Trigger | Event-Based Trigger | Asset-Based Trigger | Risk-Based Trigger |
| --- | --- | --- | --- | --- |
| `大黄` | Weekly strategic review | Multi-role task appears | Business plan / playbook outdated | Scope conflict / stalled decision |
| `田内` | Daily / weekly follow-up | Meeting ends / deadline near | Tracker missing or stale | Too many open items / unclear owners |
| `shishi` | Weekly message review | Customer proposal request | Consulting template outdated | Customer narrative unclear |
| `AK` | Pre-review checkpoint | Architecture or integration question | Standard / checklist gap | Technical overstatement / design risk |
| `wl` | Delivery readiness review | Detailed design / build request | Dev template gap | Implementation complexity unclear |
| `tu` | Test planning checkpoint | Testing phase starts | Test template missing | Coverage gap / quality risk |
| `yu` | Go-live preparation checkpoint | Incident / support topic appears | Runbook missing | Recovery path unclear |
| `山田` | Monthly market review | Important customer meeting | Sales material stale | Messaging weak / trust risk |
| `Nova` | Phase review | Agent enhancement task appears | Operating asset gap | System becoming passive / noisy |

## Rule

If a trigger fires:

1. The role should propose value, not noise
2. The role should stay within its boundary
3. The role should escalate to `大黄` if cross-role alignment is needed

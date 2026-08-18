# Runtime Contract

This document defines the public structured mode for `study-anything`. A host may use it as an adapter contract; ordinary conversation does not need these fields.

## Input

The host supplies a JSON `study_context_v1` object containing:

- `authoritative_state`: the current workflow, calibration status, confirmed profile items, and allowed state changes;
- `recent_messages`: recent conversation context;
- optional subject, goal, level, time, or learner preference fields.

`authoritative_state` is authoritative for state. Recent messages must not override it.

## Output

The skill returns one `study_decision_v1` object:

```json
{
  "decision_schema_version": "study_decision_v1",
  "contract_version": "study_context_v1",
  "workflow": "calibration",
  "reply": "你可以告诉我一个熟悉领域；如果暂时没有，也可以回复“没有”。",
  "state_changes": [],
  "analogy": {
    "used": false
  }
}
```

`state_changes` must contain only changes listed in `authoritative_state.allowed_state_changes`. The host decides whether a suggested change is accepted and persisted.

## Analogy Record

When a confirmed familiar domain is used, return:

```json
{
  "used": true,
  "source_domain": "摄影",
  "target_domain": "数据库索引",
  "mapping": [
    {
      "source": "整理常用焦段",
      "target": "为常用查询建立索引",
      "reason": "两者都用预先组织换取更快的选择"
    }
  ],
  "boundary": "索引不等于照片内容本身；它只帮助定位数据。"
}
```

Without a confirmed source domain, `used` must be `false` and the skill must not invent one.

## Workflow Rules

1. Complete calibration before drafting a learning plan.
2. Draft at least two focused units with clear objectives.
3. Keep required review short and tied to previous material.
4. Use a Socratic loop: diagnose, probe, contrast or predict, give a minimal hint, and let the learner retry.
5. Ask one main question per turn and do not answer it before the learner attempts it.
6. After two unsuccessful attempts, give a concise explanation and request a restatement or application.
7. Use a Feynman explanation plus a fresh example before treating a unit as understood.
8. Give an exact next action whenever the learner is expected to respond.

The host application owns persistence, authorization, and final validation. The package must not expose host-specific implementation details to the learner.

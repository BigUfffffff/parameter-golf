# Soft-Routing Attempts Log

## Attempt 1
- Hypothesis/Change made: Replaced hard skip `skips.pop()` with tensorized soft-routing using `routing_weights`, fp32 softmax, and scalar `skip_gate` in forward path.
- Test Phase: 1
- Loss result or Error message: Cluster run failed during `torch.compile` with `RuntimeError: einsum(): output subscript d appears more than once in the output` at `torch.einsum("de,ebtd->dbtd", ...)`.
- Next step: Fix routing equation to valid index labels, rerun `py_compile`, then submit Phase 1 again.

## Attempt 2
- Hypothesis/Change made: Corrected routing contraction to valid compile-safe einsum (`torch.einsum("de,ebtc->dbtc", ...)`) while keeping fp32 softmax and `skip_gate`.
- Test Phase: 1
- Loss result or Error message: Passed. `step:20/20 val_loss:5.0983 val_bpb:3.0195`, no NaNs, no shape errors.
- Next step: Launch Phase 2 with `ITERATIONS=500` and `VAL_LOSS_EVERY=250` to verify learning.

## Attempt 3
- Hypothesis/Change made: Ran Phase 2 with `ITERATIONS=500`, `VAL_LOSS_EVERY=250` and current soft-routing model.
- Test Phase: 2
- Loss result or Error message: Failed due to scheduler timeout (`JOB 13462481 ... CANCELLED ... DUE TO TIME LIMIT`) before validation/loss reporting.
- Next step: Retry Phase 2 with same iteration/validation settings but lower warmup/wallclock overhead to ensure at least step-250 validation is logged.

## Attempt 4
- Hypothesis/Change made: Retried Phase 2 with runtime controls (`WARMUP_STEPS=0`, `MAX_WALLCLOCK_SECONDS=540`) and unchanged architecture.
- Test Phase: 2
- Loss result or Error message: Failed with `RuntimeError: Inference tensors cannot be saved for backward.` after step-0 validation.
- Next step: Retry Phase 2 with minimal warmup (`WARMUP_STEPS=1`) to initialize compile/runtime tensors before eval+train transition.

## Attempt 5
- Hypothesis/Change made: Phase 2 rerun with same soft-routing architecture under cluster wallclock constraints. Manually overwritten by user: default warmup steps (removed `WARMUP_STEPS=1`, change `#MAX_WALLCLOCK_SECONDS=600`). Manual change by user: set `#SBATCH --time=00:30:0`.
- Test Phase: 2
- Loss result or Error message: Passed. `step:250/500 val_loss:2.6805 val_bpb:1.5876`; later `step:399/500 val_loss:2.5504 val_bpb:1.5105`; no NaNs.
- Next step: Finalize by committing soft-routing changes to git.

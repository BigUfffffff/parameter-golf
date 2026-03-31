# Parameter Golf - Experiment Logbook

Here we docoument all architecture changes, bpb-loss and the training times.

## Experiment Log 1

| Date | Experiment Name | Hardware | Steps | Final BPB | Size (MB) | Step Time | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- || 2026-03-29 | 01 | Baseline (vGPU) | A40-24Q | 5.34 MB | 3.5660 | 3.3s | First GPU-Baseline. Apparently slowed down by virtualization. (10 Iterations only) |
| 2026-03-29 | 02 | Baseline (A40) | A40 (Phys) | 5.34 MB | 3.4417 | 1.39s | On physical card (with OpenGadget3 noise). (10 Iterations only) |

## Soft-Routing
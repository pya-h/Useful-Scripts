# sal.sh - Salary Calculator

A bash script that calculates salary based on hours worked and an hourly rate, with optional bonus rewards and currency conversion.

## Purpose

Quickly compute pay for one or more hour entries, apply a bonus when hours exceed a threshold, and optionally convert the final amount into other currencies/tokens.

## How It Works

1. For each entry in the hours list, the script computes:
   - **Actual Salary** = `hours * hourly_rate`
   - **Reward** = `hours * hourly_rate * reward_factor` (only if hours > 100)
   - **Final Salary** = `actual_salary + reward`
2. If conversion factors are provided, the final salary is converted using each factor.

The reward threshold is hardcoded at **100 hours** (`REWARD_THRESHOLD_HOURS`).

## Usage

```bash
./sal.sh "<hours_list>" <hourly_rate> [reward_factor] [- factor1 token1 factor2 token2 ...] [factor1 factor2 ...]
```

## Arguments

| # | Argument | Required | Description |
|---|----------|----------|-------------|
| 1 | `hours_list` | Yes | Space-separated list of hour values (quoted). Each value is processed independently. |
| 2 | `hourly_rate` | Yes | Pay rate per hour. |
| 3 | `reward_factor` | No | Bonus multiplier applied when hours exceed 100. Defaults to `0` (no bonus). |
| 4+ | Conversion factors | No | Convert the final salary into other amounts. Supports two modes (see below). |

### Conversion Modes

**Named mode** (4th arg is `-`): pass pairs of `<factor> <token_name>` to get labeled output.

```bash
./sal.sh "120" 50 0.1 - 0.85 EUR 90.5 JPY
```

Output includes lines like `51.000000 EUR`, `5287.500000 JPY`.

**Unnamed mode** (4th arg is a number): each argument is treated as a plain multiplier.

```bash
./sal.sh "120" 50 0.1 0.85 90.5
```

Output includes lines like `0.85 => 5610.000000 ?$`.

## Examples

**Basic salary calculation:**

```bash
./sal.sh "80" 25
# Hours Worked: 80
# Actual Salary: 2000.000000$
# Reward: 0$
# Final Salary: 2000.000000$
```

**Multiple hour entries with reward:**

```bash
./sal.sh "80 120 150" 30 0.15
# Processes each of 80h, 120h, and 150h separately.
# Hours over 100 get the 15% bonus applied.
```

**With named currency conversion:**

```bash
./sal.sh "160" 40 0.1 - 35.0 IRT 0.92 EUR
# Final salary is converted to IRT and EUR using the given factors.
```

## Dependencies

- `bc` (arbitrary precision calculator) - present on most Linux/macOS systems.

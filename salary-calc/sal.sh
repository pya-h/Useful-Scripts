#!/bin/bash
#
REWARD_THRESHOLD_HOURS=100
SCALE="scale=6"
hours_list="$1"
hours_list=($hours_list)
for hours in ${hours_list[@]}; do
    echo "Hours Worked: $hours"
    hourly_rate=$2
    reward_factor=${3:-0}
    reward=0
    actual_salary=$(echo "$SCALE; $hours * $hourly_rate" | bc -l)

    echo "Actual Salary: $actual_salary\$"
    if [[ $hours -gt $REWARD_THRESHOLD_HOURS ]]; then
        reward=$(echo "$SCALE; $hours * $hourly_rate * $reward_factor" | bc -l)
    fi
    echo "Reward: $reward\$"

    final_salary=$(echo "$actual_salary + $reward" | bc -l)
    echo "Final Salary: $final_salary\$"
    echo "---------------------"
    if [[ $# -gt 3 ]]; then
        echo "Convevrted Salary Amounts:"
        if [[ $4 == "-" ]]; then
            for ((i=5;i<=$#;i++)); do
                factor=$(echo "${!i}" | bc -l)
                ((i++))
                token=${!i}
                convverted=$(echo "$SCALE; $factor * $final_salary" | bc -l)
                echo "$convverted $token"
            done
        else
            for arg in "${@:4}"; do
                factor=$(echo "$arg" | bc -l)
                converted=$(echo "$SCALE; $final_salary * $arg" | bc -l)
                echo "$arg => $converted ?\$"
            done
        fi
    fi
    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
done

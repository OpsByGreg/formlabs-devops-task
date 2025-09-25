#!/usr/bin/env bash

# Simple error function, printing all provided arguments
# to stderr and exiting the program
error() {
    printf '%s' "$@" >&2
    exit 1
}

main() {
    # Verify only 1 argument has been passed
    if [[ "${#@}" -ne 1 ]]; then
        error 'Only 1 argument should be provided.'
    fi

    local script="${1}"
    # Add extension if it does not already exist
    script="${script%.*}.sh"

    # Verify script exists within scripts sub directory
    if [[ ! -f "./scripts/${script}" ]]; then
        error "./scripts/${script} does not exist..."
    fi

    # Call script
    ./scripts/"${script}"
}

# Call main function with any provided arguments
main "$@"
#!/bin/bash

# Ruff Auto-Format Script

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if Ruff is installed
check_ruff_installed() {
    if ! command -v ruff &> /dev/null; then
        echo -e "${RED}Error: Ruff is not installed. Please install it using:${NC}"
        echo "pip install ruff"
        exit 1
    fi
}

# Function to format files
format_files() {
    local directories=("$@")
    
    if [ ${#directories[@]} -eq 0 ]; then
        directories=(".")
    fi

    # Apply Ruff formatting
    echo -e "${YELLOW}Applying Ruff formatting...${NC}"
    ruff format "${directories[@]}"
    local format_result=$?

    # Apply Ruff fixes
    echo -e "${YELLOW}Applying Ruff automatic fixes...${NC}"
    ruff check "${directories[@]}" --fix
    local fix_result=$?

    # Check overall results
    if [ $format_result -eq 0 ] && [ $fix_result -eq 0 ]; then
        echo -e "${GREEN}✔ Ruff formatting and fixes completed successfully.${NC}"
        return 0
    else
        echo -e "${RED}✘ Some errors occurred during formatting or fixing.${NC}"
        return 1
    fi
}

# Function to check formatting without modifying files
check_formatting() {
    local directories=("$@")
    
    if [ ${#directories[@]} -eq 0 ]; then
        directories=(".")
    fi

    echo -e "${YELLOW}Checking Ruff formatting...${NC}"
    
    # Check formatting
    ruff format --check "${directories[@]}"
    local format_check_result=$?

    # Check for potential fixes
    ruff check "${directories[@]}"
    local lint_check_result=$?

    if [ $format_check_result -eq 0 ] && [ $lint_check_result -eq 0 ]; then
        echo -e "${GREEN}✔ No formatting or linting issues found.${NC}"
        return 0
    else
        echo -e "${RED}✘ Formatting or linting issues detected.${NC}"
        return 1
    fi
}

# Main script logic
main() {
    # Check if Ruff is installed
    check_ruff_installed

    # Parse arguments
    local mode="format"
    local directories=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --check)
                mode="check"
                shift
                ;;
            *)
                directories+=("$1")
                shift
                ;;
        esac
    done

    # Perform formatting or checking based on mode
    if [ "$mode" == "format" ]; then
        format_files "${directories[@]}"
    else
        check_formatting "${directories[@]}"
    fi
}

# Run the main function with all script arguments
main "$@"

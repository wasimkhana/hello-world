#!/bin/bash

# Comprehensive Python Code Quality Check Script

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if required tools are installed
check_tools_installed() {
    local tools=("ruff" "mypy" "python3")
    local missing_tools=()

    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done

    if [ ${#missing_tools[@]} -ne 0 ]; then
        echo -e "${RED}Error: The following tools are not installed:${NC}"
        printf '%s\n' "${missing_tools[@]}"
        echo -e "${YELLOW}Please install them using:${NC}"
        echo "pip install ruff mypy"
        exit 1
    fi
}

# Function to run Ruff formatting check
run_ruff_format_check() {
    echo -e "${YELLOW}Running Ruff formatting check...${NC}"
    ruff format --check .
    local format_result=$?

    if [ $format_result -ne 0 ]; then
        echo -e "${RED}✘ Ruff formatting check failed.${NC}"
        echo "Run 'ruff format .' to auto-fix formatting issues."
        return 1
    fi
    echo -e "${GREEN}✔ Ruff formatting check passed.${NC}"
    return 0
}

# Function to run Ruff linting
run_ruff_lint() {
    echo -e "${YELLOW}Running Ruff linting...${NC}"
    ruff check .
    local lint_result=$?

    if [ $lint_result -ne 0 ]; then
        echo -e "${RED}✘ Ruff linting found issues.${NC}"
        echo "Run 'ruff check . --fix' to auto-fix linting issues."
        return 1
    fi
    echo -e "${GREEN}✔ Ruff linting passed.${NC}"
    return 0
}

# Function to run Mypy type checking
run_mypy_check() {
    echo -e "${YELLOW}Running Mypy type checking...${NC}"
    
    # Check if mypy.ini exists, otherwise use default configuration
    if [ -f mypy.ini ]; then
        mypy --config-file mypy.ini --install-types --non-interactive .
    else
        mypy --install-types --non-interactive .
    fi
    
    local mypy_result=$?

    if [ $mypy_result -ne 0 ]; then
        echo -e "${RED}✘ Mypy type checking found issues.${NC}"
        echo "Review and fix type annotations in your code."
        return 1
    fi
    echo -e "${GREEN}✔ Mypy type checking passed.${NC}"
    return 0
}

# Main script logic
main() {
    # Check if required tools are installed
    check_tools_installed

    # Run all checks
    local overall_result=0

    run_ruff_format_check || overall_result=1
    run_ruff_lint || overall_result=1
    run_mypy_check || overall_result=1

    if [ $overall_result -ne 0 ]; then
        echo -e "${RED}✘ Code quality checks failed. Please fix the issues before committing.${NC}"
        exit 1
    fi

    echo -e "${GREEN}✔ All code quality checks passed successfully!${NC}"
    exit 0
}

# Run the main function
main

#!/bin/bash
# Tests for pre-push hook file-to-Cest mapping logic

TESTS_PASSED=0
TESTS_FAILED=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Test helper functions
assert_equals() {
    local expected="$1"
    local actual="$2"
    local test_name="$3"

    if [ "$expected" = "$actual" ]; then
        echo -e "${GREEN}✓${NC} $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} $test_name"
        echo "  Expected: $expected"
        echo "  Got: $actual"
        ((TESTS_FAILED++))
    fi
}

# Mock the file-to-Cest mapping logic
# This function maps a changed file to a Cest class
map_file_to_cests() {
    local file="$1"

    case "$file" in
        src/Method/CartMethods.php)
            echo "CartCest"
            ;;
        src/Method/CheckoutMethods.php)
            echo "CheckoutCest"
            ;;
        src/Method/CouponMethods.php)
            echo "CouponCest"
            ;;
        src/Method/CustomerMethods.php)
            echo "CustomerCest"
            ;;
        src/Method/OrderMethods.php)
            echo "OrderCest"
            ;;
        src/Method/ProductMethods.php)
            echo "ProductCest"
            ;;
        # Files that trigger RUN_ALL (shared infrastructure)
        src/aliases.php|src/AztecWPBrowser.php|src/Config/*|src/Page/*|src/OrderStorage/*|src/Storage/*|src/SubscriptionStorage/*|composer.json|composer.lock|phpstan.neon.dist|phpcs.xml.dist|tests/_support/*|tests/acceptance/*)
            echo "RUN_ALL"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Process multiple files and determine test set
process_changed_files() {
    local files=("$@")
    local run_all=0
    declare -a cests_array

    # No changed files: abort the push
    if [ ${#files[@]} -eq 0 ]; then
        echo "ABORT"
        return
    fi

    for file in "${files[@]}"; do
        local result=$(map_file_to_cests "$file")
        if [ "$result" = "RUN_ALL" ]; then
            run_all=1
        elif [ -n "$result" ]; then
            cests_array+=("$result")
        fi
    done

    if [ $run_all -eq 1 ]; then
        echo "RUN_ALL"
    else
        # Remove duplicates and output
        printf '%s\n' "${cests_array[@]}" | sort -u | tr '\n' ' ' | sed 's/ $//'
    fi
}

# Test 1: Single trait file maps to corresponding Cest
result=$(process_changed_files "src/Method/CouponMethods.php")
assert_equals "CouponCest" "$result" "Single trait file maps to Cest"

# Test 2: aliases.php triggers RUN_ALL
result=$(process_changed_files "src/aliases.php")
assert_equals "RUN_ALL" "$result" "aliases.php triggers RUN_ALL"

# Test 3: Multiple trait files return union of Cests
result=$(process_changed_files "src/Method/CouponMethods.php" "src/Method/ProductMethods.php")
assert_equals "CouponCest ProductCest" "$result" "Multiple trait files return union"

# Test 4: Duplicate files don't duplicate output
result=$(process_changed_files "src/Method/CouponMethods.php" "src/Method/CouponMethods.php")
assert_equals "CouponCest" "$result" "Duplicate files don't duplicate output"

# Test 5: Mix of trait and infrastructure changes triggers RUN_ALL
result=$(process_changed_files "src/Method/CouponMethods.php" "src/Config/WooCommerceConfig.php")
assert_equals "RUN_ALL" "$result" "Infrastructure changes trigger RUN_ALL"

# Test 6: No changed files aborts the push
result=$(process_changed_files)
assert_equals "ABORT" "$result" "No changed files aborts the push"

# Test 7: Unknown files are ignored
result=$(process_changed_files "docs/README.md")
assert_equals "" "$result" "Unknown files are ignored"

# Test 8: test support files trigger RUN_ALL
result=$(process_changed_files "tests/_support/Helper/CustomHelper.php")
assert_equals "RUN_ALL" "$result" "Test support files trigger RUN_ALL"

# Test 9: Page Object changes trigger RUN_ALL
result=$(process_changed_files "src/Page/CartPageObject.php")
assert_equals "RUN_ALL" "$result" "Page object changes trigger RUN_ALL"

# Print summary
echo ""
echo "Tests passed: $TESTS_PASSED"
echo "Tests failed: $TESTS_FAILED"

if [ $TESTS_FAILED -gt 0 ]; then
    exit 1
fi

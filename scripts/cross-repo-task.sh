#!/bin/bash

# WeirdBrains Cross-Repository Task Management Script
# Manage tasks across multiple repositories from project-nexus

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PARENT_DIR="/home/zack-mohorn/Desktop/Code/WeirdBrains"
REPOS=("mandible" "backend" "sso_backend" "accounts" "moire" "project-nexus" "infrastructure")

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

show_usage() {
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  status                    - Show cross-repository task status"
    echo "  create <title>           - Create a cross-repository task"
    echo "  sync                     - Sync tasks across all repositories"
    echo "  report                   - Generate cross-repository report"
    echo "  next                     - Show next recommended tasks"
    echo ""
    echo "Examples:"
    echo "  $0 status"
    echo "  $0 create \"Authentication Integration\""
    echo "  $0 sync"
}

# Get task counts for a repository
get_repo_task_counts() {
    local repo_path="$1"
    local tasks_file="$repo_path/.taskmaster/tasks/tasks.json"
    
    if [ ! -f "$tasks_file" ]; then
        echo "0 0 0 0"
        return
    fi
    
    local total=$(jq '.tasks | length' "$tasks_file" 2>/dev/null || echo "0")
    local pending=$(jq '[.tasks[] | select(.status == "pending")] | length' "$tasks_file" 2>/dev/null || echo "0")
    local in_progress=$(jq '[.tasks[] | select(.status == "in-progress")] | length' "$tasks_file" 2>/dev/null || echo "0")
    local done=$(jq '[.tasks[] | select(.status == "done")] | length' "$tasks_file" 2>/dev/null || echo "0")
    
    echo "$total $pending $in_progress $done"
}

# Show cross-repository status
show_status() {
    print_header "Cross-Repository Task Status"
    
    local grand_total=0
    local grand_pending=0
    local grand_in_progress=0
    local grand_done=0
    
    printf "%-15s %-8s %-8s %-12s %-8s %-8s\n" "Repository" "Total" "Pending" "In-Progress" "Done" "Branch"
    echo "--------------------------------------------------------------------------------"
    
    for repo in "${REPOS[@]}"; do
        local repo_path="${PARENT_DIR}/${repo}"
        
        if [ -d "$repo_path" ]; then
            local counts=$(get_repo_task_counts "$repo_path")
            read -r total pending in_progress done <<< "$counts"
            
            # Get current branch
            local branch="unknown"
            if [ -d "$repo_path/.git" ]; then
                cd "$repo_path"
                branch=$(git branch --show-current 2>/dev/null || echo "unknown")
            fi
            
            printf "%-15s %-8s %-8s %-12s %-8s %-8s\n" "$repo" "$total" "$pending" "$in_progress" "$done" "$branch"
            
            grand_total=$((grand_total + total))
            grand_pending=$((grand_pending + pending))
            grand_in_progress=$((grand_in_progress + in_progress))
            grand_done=$((grand_done + done))
        else
            printf "%-15s %-8s %-8s %-12s %-8s %-8s\n" "$repo" "N/A" "N/A" "N/A" "N/A" "missing"
        fi
    done
    
    echo "--------------------------------------------------------------------------------"
    printf "%-15s %-8s %-8s %-12s %-8s\n" "TOTAL" "$grand_total" "$grand_pending" "$grand_in_progress" "$grand_done"
    
    if [ "$grand_total" -gt 0 ]; then
        local completion_rate=$((grand_done * 100 / grand_total))
        echo ""
        print_info "Overall Completion Rate: ${completion_rate}%"
    fi
}

# Main execution
main() {
    local command="$1"
    
    case "$command" in
        "status")
            show_status
            ;;
        *)
            show_usage
            exit 1
            ;;
    esac
}

# Run main function
main "$@"

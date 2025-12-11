#!/bin/bash

# Interactive Test Menu for Linux One-Liners
# Provides a guided, educational experience for learning one-liners

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Base paths
BASE_DIR="/oneliners"
DOCS_DIR="${BASE_DIR}/docs"
TEST_DATA_DIR="${BASE_DIR}/test-data"

# Clear screen function
clear_screen() {
    clear
}

# Print header
print_header() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}🐧 Linux One-Liners Interactive Learning Menu 🐧${NC}    ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Print section header
print_section() {
    local title="$1"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}${BOLD}  $title${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Pause for user to read
pause() {
    echo ""
    echo -e "${YELLOW}Press ENTER to continue...${NC}"
    read -r
}

# Execute and show command
execute_command() {
    local cmd="$1"
    local description="$2"

    echo -e "${CYAN}📝 Description:${NC} $description"
    echo ""
    echo -e "${GREEN}💻 Command:${NC}"
    echo -e "${BOLD}   $cmd${NC}"
    echo ""
    echo -e "${YELLOW}🔄 Executing...${NC}"
    echo -e "${MAGENTA}─────────────────────────────────────────────────────${NC}"

    # Execute command and capture output
    if eval "$cmd" 2>&1; then
        echo -e "${MAGENTA}─────────────────────────────────────────────────────${NC}"
        echo -e "${GREEN}✓ Command executed successfully${NC}"
    else
        echo -e "${MAGENTA}─────────────────────────────────────────────────────${NC}"
        echo -e "${RED}✗ Command failed (this may be expected for demonstration)${NC}"
    fi
}

# Main menu
show_main_menu() {
    clear_screen
    print_header

    echo -e "${WHITE}Select a category to explore:${NC}"
    echo ""
    echo -e "  ${BOLD}1)${NC} 📋 Logs Management"
    echo -e "  ${BOLD}2)${NC} ⚡ Productivity & Text Processing"
    echo -e "  ${BOLD}3)${NC} 💾 Disk Usage Analysis"
    echo -e "  ${BOLD}4)${NC} 🔐 Security Auditing"
    echo -e "  ${BOLD}5)${NC} 🔧 Process Management"
    echo -e "  ${BOLD}6)${NC} 🔍 File Search & Patterns"
    echo -e "  ${BOLD}7)${NC} 🌐 Networking Basics"
    echo -e "  ${BOLD}8)${NC} 📁 Advanced Filesystem"
    echo -e "  ${BOLD}9)${NC} 🌍 Advanced Networking"
    echo -e "  ${BOLD}10)${NC} 🎯 Useful Aliases"
    echo ""
    echo -e "  ${BOLD}11)${NC} 🚀 Run Complete Demo"
    echo -e "  ${BOLD}12)${NC} 📚 View Documentation"
    echo -e "  ${BOLD}13)${NC} 🧪 Open Test Data Directory"
    echo ""
    echo -e "  ${BOLD}0)${NC} 🚪 Exit"
    echo ""
    echo -ne "${CYAN}Enter your choice:${NC} "
}

# Logs menu
logs_menu() {
    clear_screen
    print_header
    print_section "📋 Logs Management One-Liners"

    echo -e "${WHITE}1. Filter logs by error patterns${NC}"
    execute_command \
        "grep --color=always -E 'ERROR|WARN|FAIL|CRIT' ${TEST_DATA_DIR}/logs/app.log | head -20" \
        "Find only error, warning, and critical messages in logs"
    pause

    echo ""
    echo -e "${WHITE}2. Count occurrences of patterns${NC}"
    execute_command \
        "grep -c 'ERROR' ${TEST_DATA_DIR}/logs/app.log" \
        "Count how many times 'ERROR' appears in the log"
    pause

    echo ""
    echo -e "${WHITE}3. Extract and count IP addresses${NC}"
    execute_command \
        "grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' ${TEST_DATA_DIR}/logs/auth.log | sort | uniq -c | sort -nr" \
        "Extract all IPs from logs and count their frequency"
    pause

    echo ""
    echo -e "${WHITE}4. View last N lines of log${NC}"
    execute_command \
        "tail -n 10 ${TEST_DATA_DIR}/logs/app.log" \
        "Show the last 10 lines of the log file"
    pause

    echo ""
    echo -e "${WHITE}5. Colorized log viewing${NC}"
    execute_command \
        "tail -20 ${TEST_DATA_DIR}/logs/app.log | ccze -A" \
        "View logs with syntax highlighting for better readability"
    pause
}

# Productivity menu
productivity_menu() {
    clear_screen
    print_header
    print_section "⚡ Productivity & Text Processing"

    echo -e "${WHITE}1. Process files with xargs${NC}"
    execute_command \
        "find ${TEST_DATA_DIR}/files -type f -print0 | xargs -0 -I{} echo 'Processing: {}' | head -5" \
        "Safely process files even with spaces in names"
    pause

    echo ""
    echo -e "${WHITE}2. Word frequency histogram${NC}"
    execute_command \
        "tr -cs 'A-Za-z' '\n' < ${TEST_DATA_DIR}/files/small.txt | tr A-Z a-z | sort | uniq -c | sort -nr" \
        "Count word occurrences and sort by frequency"
    pause

    echo ""
    echo -e "${WHITE}3. Find duplicate lines${NC}"
    execute_command \
        "sort ${TEST_DATA_DIR}/files/duplicates.txt | uniq -d" \
        "Show only lines that appear more than once"
    pause

    echo ""
    echo -e "${WHITE}4. Repeat command N times${NC}"
    execute_command \
        "seq 5 | xargs -I{} echo 'Iteration {}'" \
        "Execute a command multiple times without writing loops"
    pause

    echo ""
    echo -e "${WHITE}5. Extract specific columns${NC}"
    execute_command \
        "awk -F, '{print \$1, \$2}' ${TEST_DATA_DIR}/files/data.csv" \
        "Extract only name and email columns from CSV"
    pause

    echo ""
    echo -e "${WHITE}6. Remove duplicates preserving order${NC}"
    execute_command \
        "awk '!seen[\$0]++' ${TEST_DATA_DIR}/files/duplicates.txt" \
        "Remove duplicate lines while keeping original order"
    pause
}

# Disk usage menu
disk_usage_menu() {
    clear_screen
    print_header
    print_section "💾 Disk Usage Analysis"

    echo -e "${WHITE}1. Directory size summary${NC}"
    execute_command \
        "du -h --max-depth=1 ${TEST_DATA_DIR} 2>/dev/null | sort -h" \
        "Show disk usage of subdirectories, sorted by size"
    pause

    echo ""
    echo -e "${WHITE}2. Filesystem usage overview${NC}"
    execute_command \
        "df -hP | column -t" \
        "Display filesystem usage in a readable table format"
    pause

    echo ""
    echo -e "${WHITE}3. Inode usage check${NC}"
    execute_command \
        "df -i | head -10" \
        "Check inode usage to detect 'out of inodes' issues"
    pause

    echo ""
    echo -e "${WHITE}4. Find largest files${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type f -printf '%s %p\n' 2>/dev/null | sort -nr | head -10" \
        "Locate the biggest files in test data directory"
    pause

    echo ""
    echo -e "${WHITE}5. Files by extension size${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type f -name '*.*' -printf '%f\n' | awk -F. '{print \$NF}' | sort | uniq -c | sort -nr" \
        "Count files by extension type"
    pause
}

# Security menu
security_menu() {
    clear_screen
    print_header
    print_section "🔐 Security Auditing"

    echo -e "${WHITE}1. Find SUID binaries${NC}"
    execute_command \
        "find /usr/bin -perm -4000 -type f 2>/dev/null | head -10" \
        "List binaries with SUID bit (potential privilege escalation vectors)"
    pause

    echo ""
    echo -e "${WHITE}2. Check capabilities${NC}"
    execute_command \
        "getcap -r /usr/bin 2>/dev/null | head -10 || echo 'No capabilities found'" \
        "Show binaries with Linux capabilities"
    pause

    echo ""
    echo -e "${WHITE}3. List open ports and processes${NC}"
    execute_command \
        "ss -tulnp 2>&1 | head -15" \
        "Show which processes are listening on network ports"
    pause

    echo ""
    echo -e "${WHITE}4. Find world-writable files${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type f -perm -0002 2>/dev/null || echo 'None found (good!)'" \
        "Locate files that anyone can modify (security risk)"
    pause

    echo ""
    echo -e "${WHITE}5. Check for NOPASSWD sudo rules${NC}"
    execute_command \
        "grep -R 'NOPASSWD' /etc/sudoers /etc/sudoers.d 2>/dev/null || echo 'None found or permission denied'" \
        "Find sudo rules that don't require password"
    pause
}

# Process management menu
process_menu() {
    clear_screen
    print_header
    print_section "🔧 Process Management"

    echo -e "${WHITE}1. Top CPU consumers${NC}"
    execute_command \
        "ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -15" \
        "Show processes using most CPU"
    pause

    echo ""
    echo -e "${WHITE}2. Top memory consumers${NC}"
    execute_command \
        "ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -15" \
        "Show processes using most RAM"
    pause

    echo ""
    echo -e "${WHITE}3. Process tree${NC}"
    execute_command \
        "pstree -p | head -30" \
        "Display process hierarchy tree"
    pause

    echo ""
    echo -e "${WHITE}4. Find zombie processes${NC}"
    execute_command \
        "ps -eo pid,ppid,stat,comm | grep -w Z || echo 'No zombies found (good!)'" \
        "Locate defunct (zombie) processes"
    pause

    echo ""
    echo -e "${WHITE}5. Processes by runtime${NC}"
    execute_command \
        "ps -eo user,pid,etime,comm --sort=etime | tail -15" \
        "Show longest-running processes"
    pause
}

# File search menu
file_search_menu() {
    clear_screen
    print_header
    print_section "🔍 File Search & Pattern Hunting"

    echo -e "${WHITE}1. Find recently modified files${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type f -mmin -120 | head -10" \
        "Locate files modified in last 2 hours"
    pause

    echo ""
    echo -e "${WHITE}2. Search for text pattern${NC}"
    execute_command \
        "grep -Ri --color=always 'error\\|fail' ${TEST_DATA_DIR}/logs 2>/dev/null | head -10" \
        "Recursively search for patterns in files"
    pause

    echo ""
    echo -e "${WHITE}3. Find files by size${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type f -size +1M 2>/dev/null" \
        "Locate files larger than 1MB"
    pause

    echo ""
    echo -e "${WHITE}4. Find files by user${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -user root -type f 2>/dev/null | head -10" \
        "List files owned by specific user"
    pause

    echo ""
    echo -e "${WHITE}5. Directory depth analysis${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type d -printf '%d %p\n' | sort -n | tail -10" \
        "Show deepest directory structures"
    pause
}

# Networking menu
networking_menu() {
    clear_screen
    print_header
    print_section "🌐 Networking Basics"

    echo -e "${WHITE}1. Show routing table${NC}"
    execute_command \
        "ip route show" \
        "Display system routing configuration"
    pause

    echo ""
    echo -e "${WHITE}2. List network interfaces${NC}"
    execute_command \
        "ip -br addr" \
        "Show network interfaces with IPs in brief format"
    pause

    echo ""
    echo -e "${WHITE}3. Network interface statistics${NC}"
    execute_command \
        "ip -s link" \
        "Display packet statistics per interface"
    pause

    echo ""
    echo -e "${WHITE}4. Show listening TCP ports${NC}"
    execute_command \
        "ss -ltn" \
        "List TCP ports in LISTEN state"
    pause

    echo ""
    echo -e "${WHITE}5. Test connectivity${NC}"
    execute_command \
        "ping -c 3 -n 8.8.8.8" \
        "Test network connectivity without DNS resolution"
    pause

    echo ""
    echo -e "${WHITE}6. Show ARP cache${NC}"
    execute_command \
        "ip neigh" \
        "Display ARP table (IP to MAC mappings)"
    pause
}

# Advanced filesystem menu
filesystem_advanced_menu() {
    clear_screen
    print_header
    print_section "📁 Advanced Filesystem Operations"

    echo -e "${WHITE}1. Inode usage by directory${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -xdev -printf '%h\n' | sort | uniq -c | sort -nr | head -10" \
        "Show which directories contain most files"
    pause

    echo ""
    echo -e "${WHITE}2. View file attributes${NC}"
    execute_command \
        "lsattr -R ${TEST_DATA_DIR}/files 2>/dev/null | head -10" \
        "Display extended file attributes (immutable, append-only, etc.)"
    pause

    echo ""
    echo -e "${WHITE}3. Check ACLs${NC}"
    execute_command \
        "getfacl ${TEST_DATA_DIR}/files/* 2>/dev/null | head -20" \
        "Show Access Control Lists on files"
    pause

    echo ""
    echo -e "${WHITE}4. Find hardlinked files${NC}"
    execute_command \
        "find ${TEST_DATA_DIR} -type f -links +1 -printf '%n %p\n' 2>/dev/null || echo 'No hardlinks found'" \
        "Locate files with multiple hard links"
    pause

    echo ""
    echo -e "${WHITE}5. Show mount points${NC}"
    execute_command \
        "mount | column -t | head -15" \
        "Display mounted filesystems in table format"
    pause
}

# Advanced networking menu
networking_advanced_menu() {
    clear_screen
    print_header
    print_section "🌍 Advanced Networking"

    echo -e "${WHITE}1. TCP socket statistics${NC}"
    execute_command \
        "ss -s" \
        "Show summary of socket statistics"
    pause

    echo ""
    echo -e "${WHITE}2. Connection states distribution${NC}"
    execute_command \
        "ss -an | awk '{print \$1}' | sort | uniq -c | sort -nr | head -10" \
        "Count sockets by state (ESTABLISHED, TIME_WAIT, etc.)"
    pause

    echo ""
    echo -e "${WHITE}3. All routing tables${NC}"
    execute_command \
        "ip route show table all | head -20" \
        "Display all routing tables including policy routing"
    pause

    echo ""
    echo -e "${WHITE}4. Routing policy rules${NC}"
    execute_command \
        "ip rule show" \
        "Show policy routing rules"
    pause

    echo ""
    echo -e "${WHITE}5. Traffic control queues${NC}"
    execute_command \
        "tc qdisc show" \
        "Display queueing disciplines on interfaces"
    pause

    echo ""
    echo -e "${WHITE}6. IPv6 neighbor discovery${NC}"
    execute_command \
        "ip -6 neigh show || echo 'No IPv6 neighbors found'" \
        "Show IPv6 neighbor cache"
    pause
}

# Aliases showcase
aliases_menu() {
    clear_screen
    print_header
    print_section "🎯 Useful Aliases"

    echo -e "${WHITE}Here are some useful aliases you can add to your ~/.bashrc:${NC}"
    echo ""

    cat << 'EOF'
# Disk usage
alias disk='du -h --max-depth=1 2>/dev/null | sort -h'
alias big='find . -type f -size +100M -exec ls -lh {} \; | sort -k5 -h'

# Process management
alias pscpu="ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head"
alias psmem="ps -eo pid,comm,%mem,%cpu --sort=-%mem | head"
alias psg='ps aux | grep -v grep | grep -i'

# Networking
alias ports='ss -ltn'
alias listen='lsof -i -P -n | grep LISTEN'
alias myip='curl -s ifconfig.me'

# Logs
alias flog='tail -F /var/log/syslog'
alias elog='journalctl -p err -f'

# Productivity
alias ll='ls -lha --color=auto'
alias path='echo -e ${PATH//:/\n}'
alias please='sudo $(fc -ln -1)'
EOF

    pause
}

# Complete demo
complete_demo() {
    clear_screen
    print_header
    print_section "🚀 Complete Demo - Quick Tour"

    echo -e "${CYAN}Running a curated selection of commands...${NC}"
    echo ""

    sleep 2

    echo -e "${BOLD}1. System Information${NC}"
    execute_command "uname -a" "Show system information"
    sleep 1

    echo ""
    echo -e "${BOLD}2. Disk Usage${NC}"
    execute_command "df -h / | tail -n +2" "Show root filesystem usage"
    sleep 1

    echo ""
    echo -e "${BOLD}3. Top Processes${NC}"
    execute_command "ps -eo pid,comm,%cpu --sort=-%cpu | head -6" "Top 5 CPU consumers"
    sleep 1

    echo ""
    echo -e "${BOLD}4. Network Interfaces${NC}"
    execute_command "ip -br addr" "Network interfaces"
    sleep 1

    echo ""
    echo -e "${BOLD}5. Log Analysis${NC}"
    execute_command "grep -E 'ERROR|WARN' ${TEST_DATA_DIR}/logs/app.log | wc -l" "Count errors/warnings in logs"
    sleep 1

    echo ""
    echo -e "${BOLD}6. File Search${NC}"
    execute_command "find ${TEST_DATA_DIR} -type f | wc -l" "Count total files in test data"
    sleep 1

    echo ""
    echo -e "${GREEN}${BOLD}✓ Demo complete!${NC}"
    pause
}

# View documentation
view_docs() {
    clear_screen
    print_header
    print_section "📚 Documentation"

    echo -e "${WHITE}Available documentation files:${NC}"
    echo ""

    ls -1 ${DOCS_DIR}/*.md 2>/dev/null | while read -r file; do
        echo -e "  📄 $(basename "$file")"
    done

    echo ""
    echo -e "${CYAN}You can view any file with:${NC}"
    echo -e "  ${BOLD}less ${DOCS_DIR}/<filename>${NC}"
    echo ""
    echo -e "Or from the host:"
    echo -e "  ${BOLD}cat one-liners/<filename>${NC}"

    pause
}

# Open test data directory
open_test_data() {
    clear_screen
    print_header
    print_section "🧪 Test Data Directory"

    echo -e "${WHITE}Test data is located at:${NC} ${BOLD}${TEST_DATA_DIR}${NC}"
    echo ""
    echo -e "${WHITE}Directory structure:${NC}"
    tree -L 2 ${TEST_DATA_DIR} 2>/dev/null || find ${TEST_DATA_DIR} -maxdepth 2 -type d
    echo ""
    echo -e "${CYAN}Opening shell in test data directory...${NC}"
    echo -e "${YELLOW}Type 'exit' to return to menu${NC}"
    echo ""

    cd ${TEST_DATA_DIR}
    bash
}

# Main loop
main() {
    while true; do
        show_main_menu
        read -r choice

        case $choice in
            1) logs_menu ;;
            2) productivity_menu ;;
            3) disk_usage_menu ;;
            4) security_menu ;;
            5) process_menu ;;
            6) file_search_menu ;;
            7) networking_menu ;;
            8) filesystem_advanced_menu ;;
            9) networking_advanced_menu ;;
            10) aliases_menu ;;
            11) complete_demo ;;
            12) view_docs ;;
            13) open_test_data ;;
            0)
                clear_screen
                echo -e "${GREEN}${BOLD}"
                echo "╔═══════════════════════════════════════════════════╗"
                echo "║                                                   ║"
                echo "║  Thanks for using Linux One-Liners!               ║"
                echo "║                                                   ║"
                echo "║  Keep learning, keep experimenting! 🐧           ║"
                echo "║                                                   ║"
                echo "╚═══════════════════════════════════════════════════╝"
                echo -e "${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid option. Please try again.${NC}"
                sleep 2
                ;;
        esac
    done
}

# Run main menu
main

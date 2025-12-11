# Dockerfile for Linux One-Liners Learning Environment
# Provides a complete, reproducible environment for testing and learning

FROM ubuntu:22.04

LABEL maintainer="Linux One-Liners Project"
LABEL description="Complete environment for learning and testing Linux one-liners"
LABEL version="1.0"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Update and install all dependencies
RUN apt-get update && apt-get install -y \
    # Core utilities (usually pre-installed but ensuring they're there)
    coreutils \
    findutils \
    grep \
    sed \
    gawk \
    mawk \
    bash \
    bash-completion \
    # Process management
    procps \
    psmisc \
    lsof \
    iotop \
    htop \
    # Networking tools
    iproute2 \
    iputils-ping \
    netcat-openbsd \
    dnsutils \
    tcpdump \
    net-tools \
    traceroute \
    curl \
    wget \
    # System utilities
    util-linux \
    bsdmainutils \
    bsdextrautils \
    # Security & permissions
    attr \
    acl \
    libcap2-bin \
    # Log colorization
    ccze \
    # Filesystem tools
    btrfs-progs \
    xfsprogs \
    quota \
    # Text editors (for exploration)
    vim \
    nano \
    # Additional useful tools
    less \
    man-db \
    manpages \
    manpages-posix \
    tree \
    file \
    rsync \
    strace \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory for one-liners
WORKDIR /oneliners

# Create directory structure first
RUN mkdir -p /oneliners/docs /oneliners/test-data

# Copy the one-liners documentation
COPY one-liners/*.md /oneliners/docs/
COPY REQUIREMENTS.md README.md revision.md /oneliners/

# Copy the interactive test menu script
COPY test-menu.sh /oneliners/
RUN chmod +x /oneliners/test-menu.sh

# Generate sample data for testing
RUN bash -c 'echo "Creating sample test data..." && \
    # Sample log files
    mkdir -p /oneliners/test-data/logs && \
    for i in {1..100}; do echo "$(date "+%Y-%m-%d %H:%M:%S") [INFO] Normal log line $i" >> /oneliners/test-data/logs/app.log; done && \
    echo "$(date "+%Y-%m-%d %H:%M:%S") [ERROR] Critical error occurred" >> /oneliners/test-data/logs/app.log && \
    echo "$(date "+%Y-%m-%d %H:%M:%S") [WARN] Warning message" >> /oneliners/test-data/logs/app.log && \
    echo "$(date "+%Y-%m-%d %H:%M:%S") [FAIL] Operation failed" >> /oneliners/test-data/logs/app.log && \
    # Sample files with various sizes
    mkdir -p /oneliners/test-data/files && \
    echo "Small file content" > /oneliners/test-data/files/small.txt && \
    dd if=/dev/zero of=/oneliners/test-data/files/medium.bin bs=1M count=10 2>/dev/null && \
    # Files with spaces in names
    echo "File with spaces" > "/oneliners/test-data/files/file with spaces.txt" && \
    # Sample CSV data
    echo -e "name,email,age\nJohn,john@example.com,30\nJane,jane@example.com,25" > /oneliners/test-data/files/data.csv && \
    # Sample configuration files
    mkdir -p /oneliners/test-data/config && \
    echo -e "[server]\nport=8080\nhost=localhost\n\n[database]\nhost=db.example.com\nport=5432" > /oneliners/test-data/config/app.conf && \
    # Directory structure for testing
    mkdir -p /oneliners/test-data/project/{src,bin,docs,tests} && \
    echo "Source code" > /oneliners/test-data/project/src/main.c && \
    echo "Binary" > /oneliners/test-data/project/bin/app && \
    echo "Documentation" > /oneliners/test-data/project/docs/README.md && \
    # Files with different extensions
    touch /oneliners/test-data/files/script.sh && \
    touch /oneliners/test-data/files/document.pdf && \
    touch /oneliners/test-data/files/image.png && \
    # Duplicate content for testing uniq
    echo -e "line1\nline2\nline1\nline3\nline2" > /oneliners/test-data/files/duplicates.txt && \
    # Sample with IPs for extraction
    echo "192.168.1.100 - Failed login attempt" >> /oneliners/test-data/logs/auth.log && \
    echo "10.0.0.50 - Successful login" >> /oneliners/test-data/logs/auth.log && \
    echo "192.168.1.100 - Failed login attempt" >> /oneliners/test-data/logs/auth.log && \
    echo "172.16.0.10 - Connection established" >> /oneliners/test-data/logs/auth.log'

# Create a sample syslog symlink to test data
RUN ln -sf /oneliners/test-data/logs/app.log /var/log/test-syslog

# Create useful aliases
RUN echo '# Useful aliases for one-liners testing' >> /root/.bashrc && \
    echo 'alias ll="ls -lha --color=auto"' >> /root/.bashrc && \
    echo 'alias testdata="cd /oneliners/test-data"' >> /root/.bashrc && \
    echo 'alias docs="cd /oneliners/docs"' >> /root/.bashrc && \
    echo 'alias menu="/oneliners/test-menu.sh"' >> /root/.bashrc && \
    echo 'export PS1="\[\033[1;36m\][oneliners]\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] \$ "' >> /root/.bashrc && \
    echo '' >> /root/.bashrc && \
    echo '# Show welcome message' >> /root/.bashrc && \
    echo 'cat /oneliners/welcome.txt' >> /root/.bashrc

# Create welcome message
RUN cat > /oneliners/welcome.txt << 'EOF'
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     🐧 Linux One-Liners Learning Environment 🐧          ║
║                                                           ║
║  Welcome to the interactive Linux one-liners playground! ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝

📚 Available Resources:
   /oneliners/docs/          - All one-liner documentation
   /oneliners/test-data/     - Sample data for testing
   /oneliners/REQUIREMENTS.md - Dependencies documentation
   /oneliners/revision.md     - Testing report

🎮 Quick Start:
   menu                      - Interactive test menu
   testdata                  - Go to test data directory
   docs                      - Go to documentation

💡 Example Commands to Try:
   # View process by CPU usage
   ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head

   # Find large files
   find /oneliners/test-data -type f -printf '%s %p\n' | sort -nr | head

   # Extract IPs from logs
   grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" /oneliners/test-data/logs/auth.log | sort | uniq -c

📖 Documentation:
   All one-liners are categorized in /oneliners/docs/
   - logs.md
   - productivity.md
   - disk-usage.md
   - security.md
   - processes.md
   - networking.md
   - file-search.md
   - filesystem-advanced.md
   - network-advanced.md

🚀 Type 'menu' to start the interactive tutorial!

EOF

# Set the entrypoint to bash for interactive use
CMD ["/bin/bash"]

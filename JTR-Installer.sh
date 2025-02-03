#!/bin/bash

# Exit on any error
set -e

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Function to display ASCII Art
ascii_art() {
    clear
    echo -e "${YELLOW}${BOLD}"
    echo "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
    echo "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
    echo -e "${CYAN}JTR-Installer by Unknown${RESET}"
    echo -e "${YELLOW}${BOLD}"
}

# Show ASCII Art
ascii_art

# Check for existing installation
echo -e "${WHITE}Checking for existing John the Ripper installation...${RESET}"
if [ -d "$HOME/john" ]; then
    echo -e "${RED}Existing installation detected! Removing conflicting files...${RESET}"
    rm -rf "$HOME/john"
    echo -e "${GREEN}Old installation removed successfully.${RESET}"
else
    echo -e "${GREEN}No previous installation found. Proceeding...${RESET}"
fi

# Update packages
echo -e "${CYAN}Updating packages...${RESET}"
apt update -y || { echo -e "${RED}Failed to update packages. Exiting.${RESET}"; exit 1; }

# Upgrade packages
echo -e "${CYAN}Upgrading packages...${RESET}"
apt upgrade -y || { echo -e "${RED}Failed to upgrade packages. Exiting.${RESET}"; exit 1; }

# Install dependencies
echo -e "${CYAN}Installing dependencies...${RESET}"
apt install -y git build-essential binutils python || { echo -e "${RED}Failed to install dependencies. Exiting.${RESET}"; exit 1; }

# Clone the repository with retries
REPO_URL="https://github.com/openwall/john.git"
MAX_RETRIES=3
RETRY_DELAY=5
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    echo -e "${CYAN}Cloning John the Ripper repository (attempt $((RETRY_COUNT + 1))/${MAX_RETRIES})...${RESET}"
    git clone "$REPO_URL" "$HOME/john" && break

    echo -e "${RED}Clone failed. Retrying in ${RETRY_DELAY} seconds...${RESET}"
    RETRY_COUNT=$((RETRY_COUNT + 1))
    sleep $RETRY_DELAY
done

if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
    echo -e "${RED}Failed to clone repository after ${MAX_RETRIES} attempts. Exiting.${RESET}"
    exit 1
fi

# Build John the Ripper
echo -e "${CYAN}Building John the Ripper...${RESET}"
cd "$HOME/john/src" || { echo -e "${RED}Source directory not found. Exiting.${RESET}"; exit 1; }
./configure || { echo -e "${RED}Configuration failed. Exiting.${RESET}"; exit 1; }
make -s clean || { echo -e "${RED}Failed to clean build files. Exiting.${RESET}"; exit 1; }
make -sj8 || { echo -e "${RED}Build failed. Exiting.${RESET}"; exit 1; }

# Ensure bin directory exists
mkdir -p "$HOME/bin"

# Create a wrapper script for John the Ripper
echo -e "${CYAN}Setting up global accessibility for John the Ripper...${RESET}"
echo '#!/bin/bash' > "$HOME/bin/john"
echo 'cd $HOME/john/run && ./john "$@"' >> "$HOME/bin/john"
chmod +x "$HOME/bin/john"

# Add bin directory to PATH
if ! grep -q 'export PATH=$HOME/bin:$PATH' "$HOME/.bashrc"; then
    echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.bashrc"
fi

# Apply the updated PATH
source "$HOME/.bashrc"

# Verify installation
if command -v john >/dev/null 2>&1; then
    echo -e "${GREEN}Installation complete! You can now use John the Ripper by running: john${RESET}"
else
    echo -e "${RED}Installation failed. Ensure PATH is updated or retry manually.${RESET}"
    exit 1
fi

# Direct user to YouTube channel
echo -e "${GREEN}Setup complete, $name! Show your support by subscribing to our YouTube channel.${NC}"
echo -e "${BLUE}Opening YouTube now...${NC}"
sleep 2

xdg-open "https://youtube.com/@Unknown-yt?si=FXFGJa59W95"

echo -e "${PURPLE}Thank you for using JTR-Installer. Goodbye!${NC}"
sleep 2
clear

# Cleanup and exit
echo -e "${PURPLE}Cleaning up temporary files...${NC}"
rm -rf /data/data/com.termux/files/home/JTR-Installer
sleep 1
# fix owner of files and folders recursively
sudo chown -vR $(whoami) /usr/local /opt/homebrew-cask /Library/Caches/Homebrew

# fix read/write permission of files and folders recursively
chmod -vR ug+rw /usr/local /opt/homebrew-cask /Library/Caches/Homebrew

# fix execute permission of folders recursively
find /usr/local /opt/homebrew-cask /Library/Caches/Homebrew -type d -exec chmod -v ug+x {} +

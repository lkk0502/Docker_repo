# 自訂 repo sync 行為
repo() {
    if [ "$1" = "sync" ]; then
        # 執行原始的 repo sync
        command repo sync
        # 檢查 repo sync 是否成功
        if [ $? -eq 0 ]; then
            echo "Sync completed, starting branch 'CapyBara' for all projects..."
            command repo start CapyBara --all
        else
            echo "Sync failed, skipping repo start."
        fi
    else
        # 如果不是 repo sync，執行原始的 repo 命令
        command repo "$@"
    fi
}

function obs -d "start obsidian"
    obsidian > /dev/null 2>&1 &
    while not ps -C obsidian > /dev/null
        sleep 0.1
    end
    disown (jobs -p)
end

function esprs --argument repository_name
    if test -z "$repository_name"
        echo "Please provide a repository name."
        return 1
    end

    set -l repo_path "$HOME/Documents/Espressif/esp-rs/$repository_name"
    set -l origin_url "https://github.com/SergioGasquez/$repository_name"
    set -l upstream_url "https://github.com/esp-rs/$repository_name"

    if not test -d "$repo_path"
        echo "Cloning $origin_url into $repo_path"
        git clone "$origin_url" "$repo_path"
        if test $status -ne 0
            echo "Error: Failed to clone the repository."
            return 1
        end
    else
        echo "Repository $repository_name already exists in $repo_path"
    end

    if not git -C "$repo_path" rev-parse --git-dir >/dev/null 2>&1
        echo "Error: $repo_path is not a Git repository."
        return 1
    end

    if git -C "$repo_path" remote get-url origin >/dev/null 2>&1
        git -C "$repo_path" remote set-url origin "$origin_url"
    else
        git -C "$repo_path" remote add origin "$origin_url"
    end
    if test $status -ne 0
        echo "Error: Failed to configure origin."
        return 1
    end

    if git -C "$repo_path" remote get-url upstream >/dev/null 2>&1
        git -C "$repo_path" remote set-url upstream "$upstream_url"
    else
        git -C "$repo_path" remote add upstream "$upstream_url"
    end
    if test $status -ne 0
        echo "Error: Failed to configure upstream."
        return 1
    end

    echo "Opening the repository with Cursor"
    if command -sq cursor
        cursor "$repo_path"
    else
        echo "Error: cursor is not available in PATH."
        return 1
    end
end

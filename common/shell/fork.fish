function fork --argument repository_name
    if test -z $repository_name
        echo "Please provide a repository name."
        return 1
    end

    set repo_path $HOME/Documents/Espressif/forks/$repository_name

    if not test -d $repo_path
        echo "Cloning https://github.com/SergioGasquez/$repository_name into $repo_path"
        git clone "https://github.com/SergioGasquez/$repository_name" $repo_path
        if test $status -ne 0
            echo "Error: Failed to clone the repository."
            return 1
        end
    else
        echo "Repository $repository_name already exists in $repo_path"
    end

    echo "Opening the repository with VS Code"
    cursor $repo_path
end

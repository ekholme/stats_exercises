#recursion refers to a function calling itself within its own definition
function factorial(x::Int64)
    if x < 0
        error("x must be non-negative")
    elseif x == 0
        return 1
    else
        return x * factorial(x - 1)
    end
end

factorial(6)

#directory walking recursion
function walk_directory(path::String)
    for item in readdir(path, join=true)
        if isdir(item)
            println("Directory: ", item)
            walk_directory(item) # Recursive call for subdirectories
        else
            println("File: ", item)
        end
    end
end

walk_directory(".") #start in the current directory.
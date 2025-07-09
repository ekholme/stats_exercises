# this is a basic implementation of a hash table in julia

# struct to hold generic key-value pairs. note that K and V are defined when we instantiate our hash table
struct KeyValuePair{K,V}
    key::K
    value::V
end

# struct to implement the hash table
mutable struct MyHashTable{K,V}
    buckets::Vector{Vector{KeyValuePair{K,V}}}
    capacity::Int
    count::Int
    #note that buckets is a vector of vectors to help handle collisions. If we specified buckets as simply a vector of k-v pairs, then we'd have to overwrite data in the case of a hash collision. By storing a vector of vectors, we can store any collisions in a vector at a given index.

    function MyHashTable{K,V}(capacity::Int) where {K,V}
        if capacity <= 0
            error("Capacity must be positive")
        end
        buckets = [Vector{KeyValuePair{K,V}}() for i in 1:capacity]
        return new(buckets, capacity, 0)
    end
end

#helper to create a has table with a default capacity of 10
MyHashTable(capacity::Int=10) = MyHashTable{Any,Any}(capacity)

# methods
#1. hash function
function _get_bucket_index(ht::MyHashTable, key)
    return (hash(key) % ht.capacity) + 1
end
# the hash() function, which is built into Julia, takes a string (or some other input type) and runs it through a cryptographic algorithm that returns a large integer -- the 'hash code'. We can use the modulo operator to divide by the hash table's capacity, then take the remainder (and add 1, so our index is 1-indexed), and use this as the item's index in our hash table

#2. insert function
function put!(ht::MyHashTable{K,V}, key::K, value::V) where {K,V}
    idx = _get_bucket_index(ht, key)
    b = ht.buckets[idx]

    #update value if key already exists
    for (i, pair) in enumerate(b)
        if pair.key == key
            b[i] = KeyValuePair(key, value)
            return value
        end
    end

    #add a new pair to bucket
    push!(b, KeyValuePair(key, value))
    ht.count += 1
    return value
end

#3. retrieval function
function Base.get(ht::MyHashTable{K,V}, key::K) where {K,V}
    idx = _get_bucket_index(ht, key)
    b = ht.buckets[idx]

    for i in b
        if i.key == key
            return i.value
        end
    end
    return nothing #key not found
end

#4. delete method
# todo

#5. length function to get the number of items in the hash table
Base.length(ht::MyHashTable) = ht.count

# usage
mht = MyHashTable{String,Int}(8)

# show initial status
print(mht)
length(mht)

put!(mht, "apple", 10)
put!(mht, "banana", 20)
put!(mht, "cherry", 30)
put!(mht, "date", 40)

print(mht)
length(mht)

get(mht, "apple")

#update
put!(mht, "apple", 100)
get(mht, "apple")
length(mht)
print(mht)
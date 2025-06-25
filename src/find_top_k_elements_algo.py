# if given a list of integers, find the k most frequently occuring integers and return them
def find_k_most_frequent_integers(nums, k):
    freq = {}
    for i in nums:
        if i in freq:
            freq[i] += 1
        else:
            freq[i] = 1
    r = sorted(freq, key=freq.get, reverse=True)[:k]
    return r


candidates = [1, 1, 1, 2, 2, 3]

res = find_k_most_frequent_integers(candidates, 2)
print(res)

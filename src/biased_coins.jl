# answering the question:
# You have two biased coins. Coin A has a probability of landing heads (H) of 0.6, and Coin B has a probability of landing heads of 0.3. You randomly select one of the coins with equal probability and flip it. The result of the flip is heads. What is the probability that you selected Coin A?

using Distributions
using Random

Random.seed!(0408)

#bayes theorem
# p(a|h) = p(h|a) * p(a) / p(h)
# p(h) = p(h|a) * p(a) + p(h|b) * p(b)
p_h_a = 0.6
p_a = 0.5
p_h_b = 0.3
p_b = 0.5

p_h = (p_h_a * p_a) + (p_h_b * p_b)

p_a_h = (p_h_a * p_a) / p_h

# there's a 2/3 probability of the coin being A

# solve via sampling ---------

#bernoulli distributions with probabilities for each coin
da = Bernoulli(p_h_a)
db = Bernoulli(p_h_b)

n = 1_000_000

# samples from distributions for each coin
sa = rand(da, n)
sb = rand(db, n)

# logical vector where there's at least one heads
k = sa .+ sb .>= 1

# filter samples to only indices in k
ksa = sa[k]
ksb = sb[k]

# calculate pct of heads that come from coin a
p_a_h2 = sum(ksa) / sum(ksa .+ ksb)
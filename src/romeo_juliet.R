# solving the problem:
# Romeo and Juliet agree to meet between 8am and 9am. each arrives at a random tiem in the house and then waits 15 minutes. What is the probability that they meet?

n <- 1e6

r <- runif(n, min = 0, max = 60)
j <- runif(n, min = 0, max = 60)

v <- abs(r - j) <= 15

sum(v) / n

# but what if we make some assumption here -- that, since r & j are in love, they'll probably arrive earlier in the window.

t <- 0:60
plot(t, dpois(t, lambda = 10))

rp <- rpois(n, 10)
jp <- rpois(n, 10)

vp <- abs(rp - jp) <= 15

sum(vp) / n

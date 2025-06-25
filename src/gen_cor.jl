using Distributions
using Random
using CairoMakie

Random.seed!(0408)

# value for the correlation coefficient we want
σ = 0.8

#construct our covariance matrix
Σ = [[1.0, σ] [σ, 1.]]

# construct our mean vector
μ = zeros(2)

# define a multivariate normal distribution
d = MvNormal(μ, Σ)

# sample the data
s = rand(d, 200)'

# estimate the correlation matrix
cor(s)
# .81 is close enough

#and we can plot this, too
scatter(s)
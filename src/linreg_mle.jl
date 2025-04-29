# this script shows how to estimate beta parameters of a linear regression using maximum likelihood

using Distributions
using LinearAlgebra
using Random
using Optim

# Generate Random Data ----------

n = 1_000
m = 2
X = hcat(ones(n), rand(Float64, (n, m)))
β = [0.5, 1.5, 2.0]
σ = 0.1
ϵ = rand(Normal(0, σ), n)

y = X * β + ϵ

#ok, so the goal is to estimate beta coefficients using maximum likelihood
# we could do this using the gradient descent algorithm, but it's easier to just use a pre-built optimizer
# to do this, we first need to define the function to optimize

function mle_lm(X, y, b)
    ŷ = X * b

    e = y .- ŷ

    ll = -loglikelihood(Normal(0, 0.1), e) # I could pass in a sigma value to optimize as well, but we'll just hard code it in here as .1 for now

    return ll
end

# then we run the actual optimization
start_params = [1.0, 1.0, 1.0]

res = optimize(params -> mle_lm(X, y, params), start_params)

Optim.minimizer(res)
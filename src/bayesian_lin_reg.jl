using Turing
using Distributions
using Statistics
using Random
using LinearAlgebra

Random.seed!(0408)

n = 1_000
m = 3

X = hcat(ones(n), rand(Float64, (n, m)))
β = [0.5, 1.5, 2.0, 3.0]
σ = 0.1
ϵ = rand(Normal(0, σ), n)

y = X * β + ϵ

#define model
@model function linreg(X, y)
    #housekeeping
    n_feat = size(X, 2)

    #priors
    b ~ MvNormal(zeros(n_feat), 2.0 * I)
    σ ~ Exponential(1)

    μ = X * b
    return y ~ MvNormal(μ, σ * I)
end

#simulate posterior
model = linreg(X, y)

chn = sample(model, NUTS(), MCMCThreads(), 5_000, 2);

#summarize model
summarize(chn)

#check that betas are close enough

coefs = summarize(chn)[:, :mean]

isapprox.(coefs[1:4], X \ y, atol=0.01)
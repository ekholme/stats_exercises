How does maximum likelihood estimation work?

So, we can use maximum likelihood to estimate parameters of some model. Like the name suggests, the algorithm estimates parameters by maximizing the likelihood function.

I'll assume we're fitting a linear regression model here when describing this.

One thing to keep in mind is that MLE is not an algorithm but a framework. We use an optimization algorithm (like gradient descent) as part of the MLE framework.

The way this works is that we give an algorithm some starting parameter values. Using these starting parameter values, we generate predictions from our model. We then take these predictions and calculate residuals. We use the residuals to estimate the likelihood of the parameters.

What does this mean? We assume that the residuals come from some distribution -- a Normal distribution with mean 0 and variance $\sigma^2$. Once we have the residuals, we can calculate the likelihood (since the parameters are generating the data). This essentially addresses the question "given my data, how likely are these parameters?" And we want the parameters that maximize the likelihood.

In practice, we use the negative loglikelihood. We use the loglikelihood because it allows us to sum the log of likelihoods rather than taking the product of the untransformed likelihoods. And we take the negative because many optimization functions want to minimize quantity rather than maximizing it.
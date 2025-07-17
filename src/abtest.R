# You are a Data Scientist at an e-commerce company. The marketing team has designed two new versions of a product page (Page A and Page B) and wants to determine which one is more effective at converting visitors into customers. They ran an A/B test for one week, randomly assigning users to either Page A or Page B. The following data was collected:

# page a: 10k views, 250 conversions
# page b: 10.5k views, 300 conversions

# 0. set up problem

set.seed(0408)

pa_conv <- 250
pa_views <- 10000
pb_conv <- 300
pb_views <- 10500

# 1. calculate conversion rates
pa_rate <- pa_conv / pa_views
pb_rate <- pb_conv / pb_views

pb_rate - pa_rate

# 2. set up hypothesis test
# is there a difference in conversion rate between page a and page b?
# null hypothesis is that there is no difference

# 3. sample data from binomial distributions to perform hypothesis test
s_a <- rbinom(pa_views, prob = pa_rate, size = 1)
s_b <- rbinom(pb_views, prob = pb_rate, size = 1)

res <- t.test(s_a, s_b)
# can interpret p-value as a significant difference

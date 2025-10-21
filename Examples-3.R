## Probability distributions

## Prefix: d (probability density function)
xvalues=seq(-4,4, len=100)
plot(dnorm(xvalues, mean=0, sd=1) ~ xvalues, type="l")

## Prefix: p (cumulative probability distribution)
pnorm(c(-1.96, 0, 1.96), mean=0, sd=1)  ## e.g.  zero and 2 sigma levels = (0.025,0.5,0.975) 

## Prefix: q (quantiles, where argument 0<p<1)
qnorm( c(0, 0.5, 0.95), mean=0,sd=1)

## Prefix: r generate samples 
rnorm(5)  ##(default mean=0, sd=1)
runif(5,min=-1,max=1)


## Parametric and non parametric hypothesis tests:

# Simple example:
# Student's T-test
# Two samples from same distribution:
sample1=rnorm(10, mean=1, sd=0.5)
sample2=rnorm(10, mean=1, sd=0.5)

# standard plot
# Use ?points to see the "pch" numbers corresponding to different symbol shapes
stripchart(data.frame(sample1, sample2),
	method="jitter",
	vertical=TRUE,
	pch=16,
	ylim=c(0,1.04*max(sample1, sample2))
	)
tt=t.test(sample1, sample2)

# R returns an object with the results of the test, and prints a summary
is.list(tt)
# look at what tt contains
names(tt)
tt$p.value


######################################################
# Linear regression
######################################################

# make some data
x=0:10
slope=1
intercept=0.5
y.obs=intercept + slope*x+ rnorm(length(x), mean=0,sd=1)
plot(y.obs ~ x)

# linear regression requires a formula object as its first argument
# here we use a simple example -   y ~ x is shorthand for y=a + bx
fit=lm(y.obs ~ x)
model.matrix(fit)
fit.no.intercept =lm(y.obs ~ x-1) # or y.obs ~ 0 +x
model.matrix(fit.no.intercept)
abline(fit, col="red") # add fitted line to a plot
abline(fit.no.intercept, col="blue")
# add some reference lines - "abline" lets you draw straight lines
abline(v=0, col="grey", lty=2)
abline(h=0, col="grey", lty=2)

# Again, R packages the results
is.list(fit)
names(fit)

# "summary" is a generic function (like "plot") that operates differently on different objects
summary(fit)
summary(rnorm(100))

# get info - can use the first few characters of a component name that identify it uniquely 
fit$coef
coef(fit) # alternative - extractor function

# get the estimate of the intercept
coef(fit)[1]

# confidence intervals on parameter estimates - use "confint"
confint(fit)

# R is a bit odd about giving you extractor functions for p-values etc.
# you get them from the object "summary(fit)" rather than "fit" itself
summary(fit)$coef

# or use extractor function
coef(summary(fit)) 

# quality of fit - Residual sum of squares RSS. 
summary(fit)$r.squared

# RSS always increases when you add terms to a model - better assessment of quality of fit is
# adjusted RSS, which penalizes for extra parameters
summary(fit)$adj.r.squared

# nested models;
curvature.coef=0.1

y.obs=intercept + slope*x+ curvature.coef*x^2 +  rnorm(length(x), mean=0,sd=1)
fit1=lm(y.obs ~ x)

# to add an x^2 term the formula structure needs I(x^2) rather than x^2 
fit2=lm(y.obs ~ x + I(x^2))

# use "anova" - here it's essentially an F-test (var.test() in R)  to assess whether the decrease in RSS
# achieved by adding the x^2 coefficient is significant
anova(fit1,fit2)

# to see this in more detail
nParams1 = 2
nParams2 = 3
df1 = length(y.obs)-nParams1
df2 = length(y.obs)-nParams2
rss1 = sum( (y.obs-predict(fit1))^2 )
rss2 = sum( (y.obs-predict(fit2))^2 )
## no need here to divide numerator by (nParams2-nParams1)=1
fStatistic = (rss1-rss2)/(rss2/df2) 
## alternatively we can use accessor functions
fStatistic = (deviance(fit1)-deviance(fit2))/(deviance(fit2)/df.residual(fit2))
pValue = 1-pf(fStatistic,1,df2)

## We can see that this same P-value appears under the "Pr(>|t|)"
## column of the summary, usually used as the significance of the variable
## The "t-value" is simply sqrt(fStatistic) and uses a t-distribution with
## d.f. for the full model
print(summary(fit2))
tstat = sqrt(fStatistic)
print(summary(fit2)$coef[3,3])
print( 2*(1-pt(sqrt(fStatistic),df2)) )

## note that the P-value for "x" is for the full (quadratic model) without x,
## not for y.obs~x compared to y.obs~1 (intercept only)

## now we'll display both fits
plot(y.obs~x)
abline(fit1, col="red") # show straight line fit

# show quadratic fit
lines(fitted(fit2) ~ x, col="blue")

# looks blocky as we are connecting with straight lines
# use "predict" to add smooth curve with finer values of x
# new x.values

fine.x=seq(0,10,len=100)
# predict needs you to pass in dataframe with the new x values you want to plot with
fine.y=predict(fit2, newdata=data.frame(x=fine.x))
lines(y=fine.y, x=fine.x)


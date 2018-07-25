---
layout: single
title:  "Welcome, R Markdown!"
date:   2018-07-25 21:34:40 +0100
categories: r jekyll
---

This post was written as an R Markdown file.
[Travis](https://travis-ci.org) was used to convert the `.rmd` file to `.markdown`.
I followed instructions [here](https://selbydavid.com/2017/06/16/rmarkdown-jekyll/).

I am now able to take R code like this:

{% highlight r %}
plot(iris$Petal.Width, iris$Petal.Length,
     col = as.numeric(iris$Species) + 1,
     xlab = 'Petal Width', ylab = 'Petal Length',
     main = "Fisher's iris data")
{% endhighlight %}

And convert to this:

![plot of chunk plot](/figure/source/2018-07-24-hello-r-markdown/plot-1.png)

Thanks to Travis, which has R installed.

I am also able to have R-style tables. I think my LaTeX (thanks MathJax) look better. But coding them is a _very_ manual task.


{% highlight r %}
knitr::kable(head(iris))
{% endhighlight %}



| Sepal.Length| Sepal.Width| Petal.Length| Petal.Width|Species |
|------------:|-----------:|------------:|-----------:|:-------|
|          5.1|         3.5|          1.4|         0.2|setosa  |
|          4.9|         3.0|          1.4|         0.2|setosa  |
|          4.7|         3.2|          1.3|         0.2|setosa  |
|          4.6|         3.1|          1.5|         0.2|setosa  |
|          5.0|         3.6|          1.4|         0.2|setosa  |
|          5.4|         3.9|          1.7|         0.4|setosa  |



{% highlight r %}
# Source: http://www.htmlwidgets.org/showcase_plotly.html
library(plotly)
{% endhighlight %}



{% highlight text %}
## Loading required package: ggplot2
{% endhighlight %}



{% highlight text %}
## 
## Attaching package: 'plotly'
{% endhighlight %}



{% highlight text %}
## The following object is masked from 'package:ggplot2':
## 
##     last_plot
{% endhighlight %}



{% highlight text %}
## The following object is masked from 'package:stats':
## 
##     filter
{% endhighlight %}



{% highlight text %}
## The following object is masked from 'package:graphics':
## 
##     layout
{% endhighlight %}



{% highlight r %}
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
            geom_bar(position = "dodge")
ggplotly(p)
{% endhighlight %}



{% highlight text %}
## Error in loadNamespace(name): there is no package called 'webshot'
{% endhighlight %}

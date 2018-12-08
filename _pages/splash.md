---
layout: splash
title: "adrian.ng"
permalink: /
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/splash/kinabalu.jpg
  actions:
    - label: "LinkedIn"
      url: "https://www.linkedin.com/in/adrian-ng-2a2aa62b/"
    - label: "GitHub"
      url: "https://github.com/Adrian-Ng/"
    - label: "contact@adrian.ng"
      url: "mailto:contact@adrian.ng"
excerpt: "This is the website of __Adrian Ng__. _My_ website. Here you will see examples of my _Java projects_ and my notes on writing _SQL_. 

Along the way, you'll also visit some places I photographed long ago. Like myself, this website is very much a work in progress."

java:
  - title: Java Projects
    excerpt: "After cutting my teeth on _Java_ during my _MSc_ dissertation project, I found it stimulating and a joy to work with. Since then I have been fortifying my Java. My code makes use of, for instance, _interfaces & abstract_ classes, _Java 8 Streams_, and multithreading in the form of _callable futures_."

feature_row:
  - image_path: assets/images/splash/optionpricer.jpg
    image_caption: "Borobudur"  
    alt: "Option Pricer"
    title: "Option Pricer"
    excerpt: "The implementation of three models for pricing options: __Binomial Trees__, __Monte Carlo__ simulation, and __Black Scholes__ equations"
    url: "/java/options/"
    btn_label: "Read More"
    btn_class: "btn--primary"    

  - image_path: /assets/images/splash/var.jpg    
    image_caption: "Kinabalu"  
    alt: "Value at Risk"
    title: "Value at Risk"
    excerpt: "How bad could it get for our financial portfolio? This _dissertation project_ looks at a number of ways of estimating __VaR__."
    url: "/java/var/"
    btn_label: "Read More"
    btn_class: "btn--primary"

  - image_path: /assets/images/splash/hadoop.jpg
    image_caption: "Kinabalu"  
    alt: "Apache Spark"
    title: "Apache Spark"      
    excerpt: "Coming soon... Having worked on some Hadoop projects in the past, it should be interesting to try to translate these to Spark."

feature_row2:
  - image_path: /assets/images/splash/yahoofinance.jpg
    image_caption: "Skaftafellsjökull"  
    alt: "Yahoo Finance"
    title: "Fun with the Yahoo Finance API"
    excerpt: 'As of March 2018, something happened to Google Finance - it got taken to the __chopping board__ and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data... or a sensible JSON of option prices.

Thankfully there are many alternatives out there, such as the __Yahoo Finance API__'
    url: "/java/yahoofinance/"
    btn_label: "Read More"
    btn_class: "btn--primary"

sql:
  - title: SQL Notes
    excerpt: "In a past life, my expertise lay in working with SQL databases and writing queries and stored procedures. During this period, I spent many occasion mentoring and educating. Here are some of my notes."  

fr_sql_ddl_dml:
  
  - title: 'Structured Query Language '
    excerpt: 'SQL is used in essentially two ways - _building databases_ and _manipulating data_. 

    <br/><br/>

    That is, we can divide the language into two broad categories:

    <br/><br/>
    __Data Definition Language__ (DDL)
    <br/>   &<br/>
    __Data Manipilation Language__ (DML)'

  - image_path: /assets/images/splash/ddl.jpg
    image_caption: "Singapore"  
    alt: "DDL"
    title: "DDL"
    excerpt: 'Data Definition Language is what we use when we are creating, altering, or dropping database objects.

    <br/><br/>
    [__Create__](/SQL/ddl/create/){: .btn .btn--success} [__Alter__](/SQL/ddl/alter/){: .btn .btn--warning} [__Drop__](/SQL/ddl/drop/){: .btn .btn--danger} [__Truncate__](/SQL/ddl/truncate/){: .btn .btn--info}    
    '

  - image_path: /assets/images/splash/dml.jpg
    image_caption: "Boh Tea Plantation"  
    alt: "DML"
    title: "DML"
    excerpt: 'Data Manipulation Language is what we use when are working with the data itself.

    <br/><br/><br/>
    [__Select__](/SQL/dml/select/){: .btn .btn--success} [__Insert__](/SQL/dml/insert/){: .btn .btn--warning} [__Select Into__](/SQL/dml/selectinto/){: .btn .btn--danger} [__Update__](/SQL/dml/update/){: .btn .btn--info} [__Delete__](/SQL/dml/delete/){: .btn .btn--inverse}
    '

fr_sql_2:  
  - image_path: /assets/images/splash/joins.jpg
    image_caption: "Iceland"  
    alt: "Joins"
    title: 'Joins'
    excerpt: '

    <br/><br/><br/>
    [__Cartesian Joins__](/SQL/joins/cartesian/){: .btn .btn--success} [__Semi Joins__](/SQL/joins/semi/){: .btn .btn--warning} [__Aliasing__](/SQL/joins/aliases/){: .btn .btn--danger} [__Associativity__](/SQL/joins/associativity/){: .btn .btn--info} [__Commutativity__](/SQL/joins/commutativity/){: .btn .btn--inverse}'   

  - image_path: /assets/images/splash/aggregation.jpg
    image_caption: "Reynisdrangar"  
    alt: "Summarizing Data"
    title: "Summarizing Data"
    excerpt: '    

    <br/><br/><br/>
    [__Operations__](/SQL/aggregation/functions/){: .btn .btn--success} [__Group By__](/SQL/aggregation/groupby/){: .btn .btn--warning} [__Having__](/SQL/aggregation/having/){: .btn .btn--danger} [__Over__](/SQL/aggregation/over/){: .btn .btn--info} [__Data Cubes__](/SQL/aggregation/cubes/){: .btn .btn--inverse}'

  - image_path: /assets/images/splash/cte.jpg
    image_caption: "Vík"  
    alt: "CTE"
    title: "CTEs"
    excerpt: 'The _Common Table Element_ is a powerful subquery that you can name.'
    url: "/SQL/cte/"
    btn_label: "Read More"
    btn_class: "btn--primary"

datascience:
  - title: Data Science Stuff
    excerpt: "In 2017, I graduated from Royal Holloway with an MSc in Data Science. While I have no aspirations to be a _Data Scientist_, I did enjoy the experience of writing my own implementations of algorithms such as _K Nearest Neighbours_, _Neural Networks_, and _Hierarchical Clustering_ in __R__. Also used was __MATLAB__, which no-one uses. Therefore projects worked on in these languages will be added last."
---



{% include feature_row id="java" type="center" %}

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}


{% include feature_row id="sql" type="center" %}

{% include feature_row id="fr_sql_ddl_dml" %}

{% include feature_row id="fr_sql_2" %}

{% include feature_row id="datascience" type="center" %}


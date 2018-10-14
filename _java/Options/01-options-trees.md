---
title: "Options Pricing: Binomial Trees"
permalink: /java/options/trees/
excerpt: "Pricing European and American options using Binomial Trees"
toc: true
mathjax: true
---

### Formula



$$
u = e^{\sigma\sqrt{\Delta t}}\\
d = e^{-\sigma\sqrt{\Delta t}} = \frac{1}{u}\\
ud = 1\\
$$

$$
\require{enclose}
\def\uline#1#2{\enclose{updiagonalstrike}{\phantom{\Rule{#1em}{#2em}{0em}}}}
\def\dline#1#2{\enclose{downdiagonalstrike}{\phantom{\Rule{#1em}{#2em}{0em}}}}
%
\def\place#1#2#3{\smash{\rlap{\hskip{#1em}\raise{#2em}{#3}}}}
%
\hskip 1em
%
%\place{0}{12}{\bullet}

%
\place{1}{5.5}{\uline{3}{1}}
\place{1}{4}{\dline{3}{1}}

%
\place{.3}{4.4}{\frac01}

%
\hskip18em\Rule{0em}{14em}{1.5em}
$$
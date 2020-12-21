---
author_profile: true
permalink: /about/
title: "GitHub Pages Docker"
---

<html>
<head>
  <link rel="stylesheet" href="/assets/css/main.css">
</head>
</html>

[![Build Status](https://travis-ci.org/bitcoincore-dev/org-builder.svg?branch=master)](https://travis-ci.org/bitcoincore-dev/org-builder)


```
Install docker
Install make
```
then

```
git clone https://github.com/bitcoincore-dev/org-builder.git
cd org-builder

make image
OR
SITE=. make image
OR
SITE=<path to jekyll project> make server
```

## License

Distributed under the [MIT License](https://raw.githubusercontent.com/RandyMcMillan/pages-gem/master/LICENSE){: .btn .btn--primary}.
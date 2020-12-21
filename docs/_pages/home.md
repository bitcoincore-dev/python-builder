---
title: "GitHub Pages Docker"
layout: home
permalink: /
title: "GitHub Pages Docker"
author_profile: true

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
make server
SITE=. make image
SITE=. make server
```

## License

Distributed under the [MIT License](https://raw.githubusercontent.com/bitcoincore-dev/org-builder/master/LICENSE){: .btn .btn--primary}.

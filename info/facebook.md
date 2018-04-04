---
layout: default-static
sitemap: false
title: "Facebook message"
permalink: /facebook/
---

The St Margarets Community Website weekly newsletter is out... This week there is:

{% for post in site.posts limit: 8 %}
* [{{ post.title }}](https://stmargarets.london{{ post.url }})
{% endfor %}

and more... visit [stmargarets.london](https://stmargarets.london/)

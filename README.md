# Clojure Timeline

A dataviz of weighted clojure event types, "stacked over the years".

_Inspired by Clojure/conj 2014 T-shirt design_

[http://michaelparenteau.github.io/clojure-timeline/](http://michaelparenteau.github.io/clojure-timeline/)

## Development

Ruby 2.1.1 is required.

To run the site locally and develop, in the command line, `cd` into this
project directory and run:

```
Gem install bundler
bundle install
bundle exec middleman
```

Then visit [localhost:4567](http://localhost:4567) in your browser.

Documentation for languages/frameworks in use:

* [middleman](http://middlemanapp.com); _Ruby static site generator_
* [Sass](http://sass-lang.com); _CSS preprocessor in use (SCSS syntax)_
* [Compass](http://compass-style.org); _CSS authoring framework_
* [HAML](http://haml.info/); _Less verbose than HTML templating_
* [CoffeeScript](http://coffeescript.org/); _Less verbose than regular JS_
* [underscore](http://underscorejs.org/); _JS Framework for prototyping behavior_


---

Contributers to this little web sketch:

* [Sam Umbach](http://cognitect.com/team/#sam-umbach)
* [Michael Parenteau](http://cognitect.com/team/#michael-parenteau)

Thanks to [Alex Miller](https://github.com/puredanger) for helping me wrangle all the data points for
the timeline from many other people in the community.

Done during "Friday Time" at [Cognitect, Inc.](http://cognitect.com)

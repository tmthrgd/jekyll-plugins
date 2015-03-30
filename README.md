Custom plugins for the Jekyll static site generator.

## css_mathches.rb

css_mathches.rb returns a value indicating whether the css selector matches any elements.

It depends upon nokogiri: `$ [sudo] gem install nokogiri`.

For example with `{% assign x = content | css_matches: "li:not(:empty)" %}`, `x` will be true if `content` contains a non-empty `<li>` tag.

## xpath_mathches.rb

xpath_mathches.rb is a counterpart to css_mathches.rb returns a value indicating whether the xpath selector matches any elements.

It depends upon nokogiri: `$ [sudo] gem install nokogiri`.

For example with `{% assign x = content | xpath_matches: "a[@href='help.php']" %}`, `x` will be true if `content` contains an anchor tag, `<a>`, with a href attribute of value help.php.

## filehash.rb

filehash.rb generates a SHA1 hex digest for a given file.

It has no dependencies.

## h1kramdown.rb

h1kramdown.rb patches `Kramdown::Converter::Html.convert_header` so that it inserts an empty `a` element as the first child of h[1..6] elements, with href pointing to the id of the h[1..6] element. It can be styled with the selector `h[1..6] > a:first-child:empty`.

It depends on kramdown: `$ [sudo] gem install kramdown`.

It will produce HTML markup such as the following: `<h4 id="social-media"><a href="#social-media"></a>Social Media</h4>`.

## ~~handleize.rb~~

~~handleize.rb is a liquid filter that forms a valid handle/slug from an input string. On <https://tomthorogood.co.uk/> it is used to create a class token: `<body class="{{ page.path | handleize }}">` -> `<body class="pages-home-md">`.~~

~~It has no dependencies.~~

handleize.rb has been removed in favour of the builtin `slugify` filter.

## linguist.rb

linguist.rb contains the tag `linguist_colors` that outputs css rules corresponding to languages that [linguist](https://github.com/github/linguist) (used by GitHub) detects.

It depends on linguist: `$ [sudo] gem install github-linguist`.

It accepts a property to assign the colour to and a css selector that replaces the `{language}` token with a slug derived from the language name.

## math.rb

math.rb provides liquid filters to access the following [`Math` module](http://www.ruby-doc.org/core-1.9.3/Math.html) methods: [acos](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-acos) [acosh](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-acosh) [asin](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-asin) [asinh](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-asinh) [atan](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-atan) [atan2](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-atan2) [atanh](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-atanh) [cbrt](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-cbrt) [cos](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-cos) [cosh](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-cosh) [erf](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-erf) [erfc](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-erfc) [exp](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-exp) [frexp](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-frexp) [gamma](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-gamma) [hypot](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-hypot) [ldexp](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-ldexp) [lgamma](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-lgamma) [log](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-log) [log10](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-log10) [log2](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-log2) [sin](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-sin) [sinh](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-sinh) [sqrt](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-sqrt) [tan](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-tan) [tanh](http://www.ruby-doc.org/core-1.9.3/Math.html#method-c-tanh).
It also provides filters to access the following [`Numeric` module](http://ruby-doc.org/core-1.9.3/Numeric.html) methods: [abs](http://ruby-doc.org/core-1.9.3/Numeric.html#method-i-abs) [abs2](http://ruby-doc.org/core-1.9.3/Numeric.html#method-i-abs2) [divmod](http://ruby-doc.org/core-1.9.3/Numeric.html#method-i-divmod) [remainder](http://ruby-doc.org/core-1.9.3/Numeric.html#method-i-remainder).

It has no dependencies.

## mathml.rb

mathml.rb converts TeX into MathML. It provides a liquid tag `math` (and closing tag `endmath`), TeX within the tag will be converted into MathML. If kramdown is installed it will also replace `Kramdown::Converter::Html.convert_math` so that MathML can be generated using kramdown builtins. To clarify you can always use `{% math %}...{% endmath %}` but when using the kramdown parser you can also use `$$...$$`.

It depends on either MathJax-node, itextomml or ritex.

To install MathJax-node: `$ [sudo] npm install [-g] https://github.com/mathjax/MathJax-node/tarball/master` then you should add `node_modules/MathJax-node/bin` to your `PATH` environment variable. 

To install itextomml: `$ [sudo] gem install itextomml`

To install ritex: `$ [sudo] gem install ritex`.

The following TeX (a cubic function):
```
{% math %}
f(x) = a{x^3} + b{x^2} + cx + d
{% endmath %}
```
will produce the following MathML/HTML using MathJax-node:
```html
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <semantics>
    <mrow>
      <mi>f</mi>
      <mo stretchy="false">(</mo>
      <mi>x</mi>
      <mo stretchy="false">)</mo>
      <mo>=</mo>
      <mi>a</mi>
      <mrow class="MJX-TeXAtom-ORD">
        <msup>
          <mi>x</mi>
          <mn>3</mn>
        </msup>
      </mrow>
      <mo>+</mo>
      <mi>b</mi>
      <mrow class="MJX-TeXAtom-ORD">
        <msup>
          <mi>x</mi>
          <mn>2</mn>
        </msup>
      </mrow>
      <mo>+</mo>
      <mi>c</mi>
      <mi>x</mi>
      <mo>+</mo>
      <mi>d</mi>
    </mrow>
    <annotation encoding="application/x-tex">f(x) = a{x^3} + b{x^2} + cx + d</annotation>
  </semantics>
</math>
```

The same TeX will produce the following MathML/HTML using itextomml:
```html
<math xmlns='http://www.w3.org/1998/Math/MathML' display='block'><semantics><mrow><mi>f</mi><mo stretchy="false">(</mo><mi>x</mi><mo stretchy="false">)</mo><mo>=</mo><msup><mi>ax</mi> <mn>3</mn></msup><mo>+</mo><msup><mi>bx</mi> <mn>2</mn></msup><mo>+</mo><mi>cx</mi><mo>+</mo><mi>d</mi></mrow><annotation encoding='application/x-tex'>f(x) = ax^3 + bx^2 + cx + d</annotation></semantics></math>
```
which renders as: ![f(x)=ax3+bx2+cx+d](https://raw.githubusercontent.com/tmthrgd/jekyll-plugins/master/mathml.png)

The same TeX will produce the following MathML/HTML using ritex:
```html
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><mi>f</mi><mo stretchy="false">(</mo><mi>x</mi><mo stretchy="false">)</mo><mo>=</mo><mi>a</mi><mrow><msup><mi>x</mi><mn>3</mn></msup></mrow><mo>+</mo><mi>b</mi><mrow><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mi>c</mi><mi>x</mi><mo>+</mo><mi>d</mi></math>
```

**Note**: while `ab^2` is valid TeX only MathJax-node is capable of parsing it. Both itextomml and ritex require it to instead be written as `a{b^2}`.

## ~~needs_highlighter.rb~~

~~needs_highlighter.rb returns a value indicating whether any `code` tags with `class` attribute that contain `language-` exist in the input string.~~

~~It depends upon nokogiri: `$ [sudo] gem install nokogiri`.~~

needs_highlighter.rb has been removed in favour of css_mathches.rb. It can be replicated with: `css_matches: "code[class*=language-]:not(.nohighlight)"`. 

## urn.rb

urn.rb adds Uniform Resource Names in the urn:uuid format to site, posts and pages. It creates a v5 UUID with `NameSpace_DNS` if it can recover a domain name from the base URL, falling back to a `NameSpace_URL` of the base URL if it cannot. Posts and pages have v5 UUIDs with `NameSpace_URL` created from their full URL. If it is present the base URL will be set to `url`, `uri` or `domain` from _config.yml prefixing with `http://` if no protocol is specified. Finally if none are present the base URL is set to `file://#{site.source}`.

It depends on ruby-uuid.rb.

## ruby-uuid.rb

ruby-uuid.rb is a UUID library and is solely a dependency of urn.rb. It is Copyright(c) 2005 URABE, Shyouhei.

*[UUID]: universally unique identifier
*[UUIDs]: universally unique identifiers
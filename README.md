Custom plugins for the Jekyll static site generator.

## handleize.rb

handleize.rb is a liquid filter that forms a valid handle/slug from an input string. On <http://tomthorogood.co.uk/> it is used to create a class token: `<body class="{{ page.path | handleize }}">`.

It has no dependencies.

## mathml.rb

mathml.rb converts TeX into MathML. It provides a liquid tag `math` (and closing tag `endmath`), TeX within the tag will be converted into MathML.

It depends on ritex: `gem install ritex`.

The following TeX (a cubic function):
```
{% math %}
f(x) = a{x^3} + b{x^2} + cx + d
{% endmath %}
```
will produce the following MathML/HTML:
```html
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><mi>f</mi><mo stretchy="false">(</mo><mi>x</mi><mo stretchy="false">)</mo><mo>=</mo><mi>a</mi><mrow><msup><mi>x</mi><mn>3</mn></msup></mrow><mo>+</mo><mi>b</mi><mrow><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mi>c</mi><mi>x</mi><mo>+</mo><mi>d</mi></math>
```
which renders as:
![f(x)=ax3+bx2+cx+d](https://raw.githubusercontent.com/tmthrgd/jekyll-plugins/master/mathml.png)

## needs_highlighter.rb

needs_highlighter.rb returns a value indication whether any `code` tags with `class` attribute that contain `language-` exist in the input string.

It depends upon nokogiri: `gem install nokogiri`.

## urn.rb

urn.rb adds Uniform Resource Names in the urn:uuid format to site, posts and pages. It creates a v5 UUID with `NameSpace_DNS` if it can recover a domain name from the base URL, falling back to a `NameSpace_URL` of the base URL if it cannot. Posts and pages have v5 UUIDs with `NameSpace_URL` created from their full URL. If it is present the base URL will be set to `url`, `uri` or `domain` from _config.yml prefixing with `http://` if no protocol is specified. Finally if none are present the base URL is set to `file://#{site.source}`.

It depends on ruby-uuid.rb.

## ruby-uuid.rb

ruby-uuid.rb is a UUID library and is solely a dependency of urn.rb. It is Copyright(c) 2005 URABE, Shyouhei.

*[UUID]: universally unique identifier
*[UUIDs]: universally unique identifiers

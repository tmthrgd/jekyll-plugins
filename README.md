Custom plugins for the Jekyll static site generator.

## h1kramdown.rb

h1kramdown.rb patches `Kramdown::Converter::Html.convert_header` so that it inserts an empty `a` element as the first child of h[1..6] elements, with href pointing to the id of the h[1..6] element. It can be styled with the selector `h[1..6] > a:first-child:empty`.

It depends on kramdown: `$ [sudo] gem install kramdown`.

It will produce HTML markup such as the following: `<h4 id="social-media"><a href="#social-media"></a>Social Media</h4>`.

## handleize.rb

handleize.rb is a liquid filter that forms a valid handle/slug from an input string. On <https://tomthorogood.co.uk/> it is used to create a class token: `<body class="{{ page.path | handleize }}">` -> `<body class="pages-home-md">`.

It has no dependencies.

## mathml.rb

mathml.rb converts TeX into MathML. It provides a liquid tag `math` (and closing tag `endmath`), TeX within the tag will be converted into MathML. If kramdown is installed it will also replace `Kramdown::Converter::Html.convert_math` so that MathML can be generated using kramdown builtins. To clarify you can always use `{% math %}...{% endmath %}` but when using the kramdown parser you can also use `$$...$$`.

It depends on either itextomml: `$ [sudo] gem install itextomml`
or ritex: `$ [sudo] gem install ritex`.

The following TeX (a cubic function):
```
{% math %}
f(x) = a{x^3} + b{x^2} + cx + d
{% endmath %}
```
will produce the following MathML/HTML using itextomml:
```html
<math xmlns='http://www.w3.org/1998/Math/MathML' display='block'><semantics><mrow><mi>f</mi><mo stretchy="false">(</mo><mi>x</mi><mo stretchy="false">)</mo><mo>=</mo><msup><mi>ax</mi> <mn>3</mn></msup><mo>+</mo><msup><mi>bx</mi> <mn>2</mn></msup><mo>+</mo><mi>cx</mi><mo>+</mo><mi>d</mi></mrow><annotation encoding='application/x-tex'>f(x) = ax^3 + bx^2 + cx + d</annotation></semantics></math>
```
which renders as: ![f(x)=ax3+bx2+cx+d](https://raw.githubusercontent.com/tmthrgd/jekyll-plugins/master/mathml.png)

The same Tex will produce the following MathML/HTML using ritex:
```html
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><mi>f</mi><mo stretchy="false">(</mo><mi>x</mi><mo stretchy="false">)</mo><mo>=</mo><mi>a</mi><mrow><msup><mi>x</mi><mn>3</mn></msup></mrow><mo>+</mo><mi>b</mi><mrow><msup><mi>x</mi><mn>2</mn></msup></mrow><mo>+</mo><mi>c</mi><mi>x</mi><mo>+</mo><mi>d</mi></math>
```

## needs_highlighter.rb

needs_highlighter.rb returns a value indicating whether any `code` tags with `class` attribute that contain `language-` exist in the input string.

It depends upon nokogiri: `$ [sudo] gem install nokogiri`.

## urn.rb

urn.rb adds Uniform Resource Names in the urn:uuid format to site, posts and pages. It creates a v5 UUID with `NameSpace_DNS` if it can recover a domain name from the base URL, falling back to a `NameSpace_URL` of the base URL if it cannot. Posts and pages have v5 UUIDs with `NameSpace_URL` created from their full URL. If it is present the base URL will be set to `url`, `uri` or `domain` from _config.yml prefixing with `http://` if no protocol is specified. Finally if none are present the base URL is set to `file://#{site.source}`.

It depends on ruby-uuid.rb.

## ruby-uuid.rb

ruby-uuid.rb is a UUID library and is solely a dependency of urn.rb. It is Copyright(c) 2005 URABE, Shyouhei.

*[UUID]: universally unique identifier
*[UUIDs]: universally unique identifiers
+++
title = "Behind the portal"
date = "Sun, 26 Feb 2017 19:01:41 +0100"
tags = ["golang","portal", "hugo"]
categories = ["tech stack"]
banner = "img/blog/hugo.jpg"
draft = true
+++

## From static page to static portal

Any product should have at least a web page to describe briefly its purpose.
Github or Gitlab help us with the README file of our repository. It is a
convenient way to get quickly a public and referenced description of your
product.

At the beginning, I wrote this cool README file mainly focus on technical
aspects of the product. Write a good README file is not so easy. Fortunately
there is some good articles to help you in the quest of writing [README][readme]
files.

However, README files are good for developers but not really useful for a non
developer to figure out what does the product.
That's why we should not only focusing on the technical part and provide some
product information to the end user.
Therefore I added to the web application a welcome page:

![Home page][old-homepage]

Add a static page into the web app code is easy but I was not comfortable with.
First I don't like the idea to add static contents to the web app.
I would like to get the tiniest deployable artifact in order to:

- minimize the build time
- minimize the global size of the app
- minimize the user loading time
- etc.

A second point is that the web app is powered by a dynamic web framework (React).
As a result, first implementation of the welcome page was a React dynamic page.
It means that the welcome page is loaded with javascript.

It is not annoying for the end user but it is not ideal to be correctly indexed
by crawlers. In your quest of Search Engine Optimization (SEO) you have to make
something else.

I could have made a dedicated fully static page but I would have complexified
the build process. Nowadays, build a javascript web app is complex enough.
Grunt/Gulp/Webpack are powerful tools, but I saw too many projects having a
build configuration too complex and barely readable.

I think that the web app should be focused only on its own concerns: the app.

Therefore I need to  delegate the marketing to a better tool:
**a static website generator**.

## Spoiled for choice

When you want to create a static web portal you have a huge choice!
There are many good solutions to do the job:

- [Jekyll][jekyll]
- [Metalsmith][metalsmith]
- [Middleman][middleman]
- [Hugo][hugo]
- [and many many more!][staticgen]

Your choice can be influenced by your technological preferences. Ruby lovers
will choose Jekyll, NodeJs lovers will choose Metalsmith, Java lovers will
choose Maven Sites... I am kidding.

Personally I am doing almost everything with Docker therefore technology choice
is not so important. What matter for me is simplicity. And maybe one of the most
simple solution is Hugo.

![Hugo][hugo-logo]

Hugo is developed in Go. Ideal for installation. You have only one binary to put
into your path. Obiously, you can still install it using your favorite
distribution packaging system. Hugo is well distributed: Linux x86/amd64/ARM,
OSX, Windows, FreeBSD... what is missing? Go is truly portable!

Maybe because it's go, it's fast... damn fast. In less than a second (47 ms to
be precise) you have a development server up and running with live reload!

![Hugo CLI][hugo-cli]

Another good point with Hugo is the layout. It is delegated to the theme and you
have only one TOML file to configure Hugo and the Theme. No more kitchen sink to
setup. Super simple.

The community is also very active and you can find a large variety of themes.
For my needs I chose the [universal theme][universal-theme] that is very well
designed.
With few changes in the TOML configuration you quickly obtain a clean result.

Hugo is this kind of software that make you feel confident from the beginning.

The second objective of choosing a static website generator is to be able to add
content over the time: **To blog**.

Some pages (such as the welcome page) are produced by the theme but one of the
main feature of Hugo is to provide a static blog engine.
Each articles are written in a markup language (Markdown) and converted into a
static HTML page integrated and decorated by the theme.
This article is a simple text file written in Markdown.
It is very easy to create but furthermore to maintain, archive and work with.
Your file system is your database and all your website can be managed through a
version control system such as Git.
It is super cool because it enables the ability of wrote a document in
collaboration or make some review with merge/pull request.

This website is, as other keeper projects, an open source project hosted
[here][here]. By the way, feel free to suggest an article or to contribute ;)

Unlike traditional CMS, static web site generators are great tools to create
robust, secure, scalable, collaborative and **simple** websites.


[old-homepage]: /img/blog/old-homepage.png "Old homepage"
[hugo-logo]: /img/blog/hugo-logo.png "Hugo logo"
[hugo-cli]: /img/blog/hugo-cli.png "Hugo CLI"
[readme]: https://thejunkland.com/blog/how-to-write-good-readme.html
[jekyll]: https://jekyllrb.com/
[metalsmith]: http://www.metalsmith.io/
[middleman]: https://middlemanapp.com/
[hugo]: https://gohugo.io/
[staticgen]: https://www.staticgen.com/
[universal-theme]: https://themes.gohugo.io/hugo-universal-theme/
[here]: https://github.com/nunux-keeper/nunux-keeper.github.io

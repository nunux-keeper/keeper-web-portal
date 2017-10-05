+++
title = "Nunux Keeper with Android"
date = "2017-10-03T23:26:58+02:00"
tags = ["android","api"]
categories = ["howto"]
banner = "img/blog/android-255.jpg"
+++

Content curation is a day to day activity. Due to that, you may expect an
availability on your day to day device: your smartphone.

A good thing is that the Web App of Nunux Keeper try to be a [Progressive Web
App][pwa].
Therefore you can appreciate a decent ergonomic on your smartphone.
However the user experience is restricted to the browser capabilities.
Even if the browser tend to be more and more integrated with the system
(notifications, camera, etc), interactions between natives applications and web
app are still limited.

![Android][android]

With Android apps you can exchange data thanks to [Intent][intent] mechanisms.
So it's possible to share a Tweet coming from the Twitter app with another app
like Hangout.

How can we do that with Nunux Keeper? How can we keep a tweet without leaving
the Twitter app?

The obvious solution is to create a new Android app that implements the share
intent. Unfortunately I am not an Android developer.
So I have to find out another solution.

*By the way, if YOU are an Android developer and you enjoy Nunux Keeper... we
have to talk :)*

A solution came from a great Android app named:
[HTTP Shortcuts][http-shortcuts].

![Http Shortcuts logo][http-shortcuts-logo]

> A simple Android app that allows you to create shortcuts that can be placed on
> your home screen. Each shortcut, when clicked, triggers an HTTP request.

It is very simple yet very powerful with many features among them: the ability
to trigger an HTTP request on a share Intent. In other words, you can send a
tweet to an HTTP endpoint. This is precisely what we want.
We just have to create a shortcut to a Nunux Keeper endpoint and we will be able
to create documents from any Android shared content.

**Let's do that!**

The [Nunux Keeper API][nunux-keeper-api] is protected by OpenID Connect.
That's great but barely usable for a simple HTTP call. This is why some API
endpoints are also exposed with a simple API key. It is the case for the
document creation API endpoint. You can create a document with a simple HTTP
call providing the API key as credentials.

You can obtain your API key from the setting panel of Nunux Keeper (or using the
API).
Think to copy paste your API key somewhere because this secret is stored hashed
into the database. It is impossible to retrieve afterward.

Once your API key has been saved somewhere, you can call the API using:

```bash
$ curl https://api:c987ab4cf39a9d56cf8cb@api.nunux.org/keeper/v2/documents
```

Now it's time to configure HTTP Shortcuts app.
Let's create a shortcut to send a URL to Nunux Keeper:

First we have to declare a `Text Input` variable called `payload`
(Menu -> Variables).
Don't forget to check the `Allow 'Share...'` check box.

Once the variable has been created you can create a new shortcut:

- Shortcut Name: `Nunux Keeper (URL)`
- Method: `POST`
- URL: `https://api.nunux.org/keeper/v2/documents`
- Authentication Method: `Basic Authentication`
- Username: `api`
- Password: `<YOUR API KEY>`
- Request Headers:
  - `Content-Type`: `application/json`
- Request Body: `{"origin":"{{payload}}"}`
- Response Type: `Simple Toast`

The, you should be able to create a document from a URL shared by any Android
app.
This work very well when you share a page from your smartphone browser.

However, all Android apps don't send URL as a sharing payload. For instance, the
Twitter app send a short text with the link of the tweet.
For this kind of app, we can directly send the payload as the document content.
Let's duplicate the shortcut and update it as following:

- Shortcut Name: `Nunux Keeper (content)`
- URL: `https://api.nunux.org/keeper/v2/documents?title=Form my phone`
- Request Headers:
  - `Content-Type`: `text/html`
- Request Body: `{{payload}}`

And now we have two HTTP shortcuts able to create different type of content from
our smartphone.

Of course it would be better to avoid having to know the intent payload type and
be able to send whatever we get to the API endpoint.
That's possible, but you will need an intermediate tool like NodeRED, and this
is another story...

[intent]: https://developer.android.com/reference/android/content/Intent.html
[pwa]: https://developers.google.com/web/progressive-web-apps/
[http-shortcuts]: https://github.com/Waboodoo/HTTP-Shortcuts
[http-shortcuts-logo]: /img/blog/http-shortcut-logo.png "HTTP Shortcuts"
[android]: /img/blog/android.jpg "Android"
[nunux-keeper-api]: https://api.nunux.org/keeper/api-docs/

+++
title = "Self-hosting Nunux Keeper"
date = "2017-05-17T22:30:22+02:00"
tags = ["docker"]
categories = ["howto"]
banner = "img/blog/docker-logo.png"
draft = false
+++

![Self hosted][self-hosted]

Before running any script, let's have a quick overview of the software
architecture.
Many software are used to power the solution, and a first glance at the
architecture may give you the feeling that the solution is a bit complex.
You would be wrong.

A great approach to describe an architecture is a good drawing.
An efficient schema model is the [C4][c4] model introduced by
[Simon Brown][@simonbrown]. This model is inspired by the geographic mapping.
By analogy with Google Map you start at a global scale of the system: the
context. Your system is summed up as a big box with short phrases explaining
global features. All interactions with external systems or actors are also
illustrated.
Then you zoom in to an area of the map: the container level.
It is the internal scaffolding of your systems.
Which containers compounds the system and how they interact each other.
Zoom in to the component level. It is the internal structure of a container.
Finally you zoom again to see classes of a component. A class is a direct
binding with the code.

Context, Container, Components and Class: Here come the C4 model.

By the way, if you enjoy this kind of diagram, feel free to download and adapt
them. It is SVG format and it's open source!

So let's start with a overview of the system:

![System context diagram][context-diagram]

As you can see the system is straightforward:
The system consumes web content of external systems and expose this content thru
an REST API. This API handles main features that we can expect from a content
curation system. Finally, the API can be consumed by other systems like a CLI,
a Web App, etc.

Now, like using Google Map, we zoom in a bit to figure out how the system is
structured.

Here the container diagram:

![Container diagram][container-diagram]

The core of the system is the API container. It is a Node.js app powered by
[Express][express]. This container exposes a RESTFul API protected with
[JWT][jwt].
The token creation is delegated to an external system. It can be forged by
[Auth0][auth0] but in our case it will be forged by a great open source IAM
product: [Keycloak][keycloak].

The Core API stores web documents and meta data inside a NoSQL Data Store. This
document data store can be [MongoDB][mongodb] or [ElasticSearch][elasticsearch].
The data store also persists other entity like labels, users and sharing
informations.

In order to enable full text search, documents are indexed by a search engine:
[ElasticSearch][elasticsearch].

Binary files attached to documents are stored inside an object storage
container. This container can be a classic file system or [S3][s3] compatible
object storage service. These files are downloaded by a job worker.

All asynchronous tasks are handled by Job Workers. This container implementation
is based on [Kue][kue].
This distributed job framework uses [Redis][redis] as job queuing system.
Job Workers are autonomous and can be deployed in parallel to handle the load.
There are Job Workers to handle file downloads, import/export tasks and some
administration task like database cleanup.

The Core API and some job workers produce metrics using the [StatsD][statsd]
protocol.
Any [StatsD][statsd] collector can be used to collect, aggregate and forward
metrics to a Time Series Database (such as [OpenTSDB][opentsdb],
[Prometheus][prometheus] or [InfluxDB][influxdb]).
For instance, the hosting platform of Nunux Keeper uses [Telegraf][telegraf]
and [InfluxDB][influxdb] to handle those metrics.

Regarding the self-hosting need, we can stop here. 
You should now have a good understanding of Nunux keeper architecture.

Now, it is time to set up all of them. To handle this task, our best friend will
be [Docker][docker] and its new stack creation capability.

![Docker][docker-logo]

For this purpose we create a dedicated project: [keeper-docker][keeper-docker]

Installation is simple:

```bash
$ git clone https://github.com/nunux-keeper/keeper-docker.git
$ cd keeper-docker
$ make deploy
```

With a bit of patience you will get the following services up and running:

- [Traefik][traefik]: A dynamic reverse proxy used to route incoming requests to
  appropriate backend.
- [MongoDB][mongodb]: The database backend.
- [Elasticsearch][elasticsearch]: The search engine backend.
- [Redis][redis]: The in-memory database used as an event bus by the job
  scheduler.
- [Keycloak][keycloak]: The Identity and Access Management service. This service
  is auto configured by scripting.
- [Nunux Keeper Core API][nunux-keeper-core-api]: The core API of Nunux Keeper.
- [Nunux Keeper job worker][nunux-keeper-job-worker]: A job worker for Nunux
  Keeper background tasks.
- [Nunux Keeper Web App][nunux-keeper-web-app]: The Web App of Nunux Keeper.

Check the project repository [README][keeper-docker-readme] for more details
about the installation and what could be missing to get a full and production
ready installation.

Welcome in the wonderful world of the self hosting!

*But if you don't want to handle this you are welcome on our [hosting
platform][keeper-app].*


[c4]: http://static.codingthearchitecture.com/c4.pdf
[@simonbrown]: https://twitter.com/simonbrown
[keeper-docker]: https://github.com/nunux-keeper/keeper-docker
[keeper-docker-readme]: https://github.com/nunux-keeper/keeper-docker/blob/master/README.md
[keeper-app]: https://app.nunux.org
[self-hosted]: /img/blog/self-hosted.png "Self hosted"
[docker-logo]: /img/blog/docker-logo.png "Docker Logo"
[context-diagram]: /img/blog/keeper-ctx-diag.svg "Keeper context diagram"
[container-diagram]: /img/blog/keeper-ctn-diag.svg "Keeper container diagram"

[express]: http://expressjs.com
[jwt]: https://jwt.io/introduction/
[auth0]: https://auth0.com/
[keycloak]: http://www.keycloak.org/
[s3]: https://aws.amazon.com/s3/
[kue]: http://automattic.github.io/kue/
[traefik]: https://traefik.io/
[keycloak]: http://www.keycloak.org
[mongodb]: https://www.mongodb.com
[elasticsearch]: https://www.elastic.co
[redis]: http://redis.io/
[statsd]: https://github.com/b/statsd_spec
[s3]: https://aws.amazon.com/s3
[influxdb]: https://www.influxdata.com/
[opentsdb]: http://opentsdb.net/
[prometheus]: https://prometheus.io
[telegraf]: https://www.influxdata.com/telegraf/
[docker]: https://www.docker.com/

[nunux-keeper-core-api]: https://github.com/nunux-keeper/keeper-core-api
[nunux-keeper-job-worker]:https://github.com/nunux-keeper/keeper-core-api/tree/master/src/job
[nunux-keeper-web-app]: https://github.com/nunux-keeper/keeper-web-app
[nunux-keeper-web-portal]:https://github.com/nunux-keeper/nunux-keeper.github.io

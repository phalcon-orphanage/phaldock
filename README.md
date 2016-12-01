# PhalDock

PhalDock helps you to run your **Phalcon** app on **Docker** quickly and with ease.

## Contents
- [Intro](#intro)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Single project setup](#installation-single-project-setup)
    - [Install](#installation-single-project-setup-install)
  - [Multiple projects setup](#installation-multiple-projects-setup)
    - [Install](#installation-multiple-projects-setup-install)
  - [Location of the hosts file](#installation-location-hosts-file)
- [Usage](#usage)

<a name="intro"></a>
## Intro

PhalDock strives to get closer to developers, providing flexible, powerful and simple tools. We would like a Phalcon development process to be effortless and pleasant. It contains pre-packaged Docker images that provides you a wonderful development environment without requiring you to install PHP, NGINX, MySQL, Redis or any other software on your local machine.

**Usage overview:** Run `NGINX`, `MySQL` and `Redis`.

```shell
docker-compose up nginx mysql redis
```

<a name="requirements"></a>
## Requirements

- [Git](https://git-scm.com)
- [Docker](https://www.docker.com) `>= 1.12`

<a name="installation"></a>
## Installation

Before you can use PhalDock you have to install Docker. Go to [Dockers installation page](https://docs.docker.com/engine/installation/) and select your OS.

Next you have to decide what setup that best suits your workflow.

<a name="installation-single-project-setup"></a>
### Single project setup

A single project setup means that each project has its own Docker environment. You would then access your project from `http://127.0.0.1` or `http://localhost`. The hierarchy would look like the following example.

```
- projects
  - project1
    - docker
  - project 2
    - docker
  - project 3
    - docker
```

Before you decide your setup, have a look at the [multiple projects setup](#installation-multiple-projects-setup).

<a name="installation-single-project-setup-install"></a>
#### Install

Clone this repository to your projects root directory.

```shell
git clone https://github.com/phalcongelist/phaldock.git
```

Now we are done. Yep, it's that easy. Have a look at the [Usage](#usage) section to find out how to proceed.

<a name="installation-multiple-projects-setup"></a>
### Multiple projects setup

A multiple projects setup means that you have multiple projects that share the same Docker environment. If you're developing applications that depends or communicates with each other this may be a good way to achieve it. This approach makes it possible to access each project as `http://project1.dev` or `http://whatever.you.prefer`. The hierarchy would look like the following example.

```
- projects
  - docker
  - project1
  - project 2
  - project 3
```

Before you decide your setup, have a look at the [single project setup](#installation-single-project-setup).

<a name="installation-multiple-projects-setup-install"></a>
#### Install

Clone this repository to anywhere.

```shell
git clone https://github.com/phalcongelist/phaldock.git
```

Go to the phaldock folder and open `docker-compose.yml`. Edit the `applications` service and map your projects.

```
application:
    build: ./application
    volumes:
        - ../project1:/var/www/project1
        - ~/projects/project2:/var/www/project2
        - /Users/you/projects/project3:/var/www/project3
```

Now copy `nginx/sites/sample.conf.example` and name the file to something like `project1.conf`. You need a new configuration file for each project.

Open each of your newly created configuration files and edit `server_name` and `root` to something like the following.

```
server_name project1.dev;
root /var/www/project1/public;
```

As a final step you have to add your project domains to your `hosts` file.

```
127.0.0.1 project1.dev
127.0.0.1 project2.dev
127.0.0.1 project3.dev
```

<a name="installation-location-hosts-file"></a>
### Location of the hosts file

Are you having trouble finding your hosts file?

| OS       | Path                                    |
|--------- | --------------------------------------- |
| Linux    | /etc/hosts                              |
| Mac OS X | /etc/hosts                              |
| Windows  | %SystemRoot%\System32\drivers\etc\hosts |

## Usage

Let's start by going to your `phaldock` folder.

#### Example with NGINX and MySQL

The following example is a very basic example with NGINX and MySQL. The `workspace` and `php-fpm` container runs automatically in most cases, so there's no need specify them.

```shell
docker-compose up nginx mysql
```

#### Example with NGINX, MariaDB, Redis and Beanstalkd.

It's easy to switch out and add more containers.

```shell
docker-compose up nginx mariadb redis beanstalkd
```

#### Running in detached/background mode

You can run Docker in the background by adding `-d` after `up`.

```shell
docker-compose up -d nginx mariadb redis beanstalkd
```

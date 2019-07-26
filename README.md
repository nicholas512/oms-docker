# Supported tags and respective ```Dockerfile``` links
* (beta) *[```beta```, (beta/Dockerfile)][]*
* (0.1_py2) *[```0.1_py2```, (0.1_py2/Dockerfile)][]*
* (0.1_py3) *[```0.1_py3```, (0.1_py3/Dockerfile)][]*
* (0.2_py3) *[```0.2_py3```, (0.2_py3/Dockerfile)][]*

# Bundled OMS3 version in each Docker image
* (beta): OMS 3.6.21
* (0.1_py2): OMS 3.6.11
* (0.1_py3): OMS 3.6.11
* (0.2_py3): OMS 3.6.14

# Bundled JVM version in each Docker image
* (beta): openjdk-11
* (0.1_py2): openjdk-8
* (0.1_py3): openjdk-8
* (0.2_py3): openjdk-8


# OMS (Object Modeling System)

The **Object Modeling System** is a framework for designing, building, validating, and deploying agro-environmental models.
It is lightweight, open, less invasive and more flexible than other environmental modeling frameworks.

> [https://alm.engr.colostate.edu/cb/wiki/16961][]

# How to use this image?

This image packages the OMS framework and following features:

* Python binding (```*_py2``` for python 2, ```*_py3``` for python 3)
* R binding

Its availability makes running OMS and related features much easier on every box. No linking and environment variables set up are required anymore.

Follow these steps to set up Docker for GEOtop. 

## 1. Install Docker

Installing Docker is first required to run this (and any ohther) image. Docker works on most operating systems (Windows, Mac OS X, GNU/Linux) and cloud platforms (AWS, Google).


Install Docker and follow the instructions for your platform:

* [GNU/Linux][] (choose your distribution)
* [Mac OS X][]
* [Windows][] 


## 2. Download the [ex01][] project

If you have never used OMS before, please download the [ex01][] project and unpack it. 

```$ unzip ex01.zip```

This small data helps exercising an OMS run. More OMS examples are made available at [Basic Examples][] web page.


## 3. Run OMS

To run OMS, open a terminal and change into the [ex01][] folder.


```$ cd ex01```

Copy and paste the following command. This should work on all platforms. 

```$ docker run --rm -it -v $(pwd):/work omslab/oms:beta simulation/ex00_HelloWorld.sim```

The following command works for Windows users

```$ docker run --rm -it -v C:\<full_path>\<project>:/work omslab/oms:beta simulation/ex00_HelloWorld.sim```

Options:

* ```run``` will download the image and executes it afterwards.
* ```--rm``` will remove the container when the model is finished.
* ```-v $(pwd):/work``` maps the current folder as the internal data folder 
  for OMS.
* ```omslab/oms```: this is the image name ```<organization_name>/<image_name>```
  to run.
* ```simulation/ex00_HelloWorld.sim```: this is the path to sim file you want to run

The command above will automatically download the **latest** Docker image of OMS from DockerHub (the download is required just for the very first time) and run it. Next time you invoke the ```run``` command, OMS will just simply start on your machine.


To run a specific version of OMS, just add ```:<tag>``` to the image name.

```$ docker run --rm -it -v $(pwd):/work omslab/oms:beta simulation/ex00_HelloWorld.sim```


## Output

The following output shows the first time output of the OMS run for [ex01][] example:

```
$ docker run --rm -it -v $(pwd):/work omslab/oms simulation/ex00_HelloWorld.sim

Buildfile: /work/build.xml

-init:
    [mkdir] Created dir: /work/build/classes
    [mkdir] Created dir: /work/build/obj
    [mkdir] Created dir: /work/build/gensrc
    [mkdir] Created dir: /work/dist
    [mkdir] Created dir: /work/output

compile-fortran:

nap:

nap_r:

nap_py:

compile-java:
    [javac] Compiling 1 source file to /work/build/classes
    [javac] warning: [options] bootstrap class path not set in conjunction with -source 1.7
    [javac] 1 warning

compile:

jar:
      [jar] Building jar: /work/dist/ex01.jar

all:

BUILD SUCCESSFUL
Total time: 0 seconds
Hello World  ...
$ _
```

Further times output is going to be:

```
$ docker run --rm -it -v $(pwd):/work omslab/oms simulation/ex00_HelloWorld.sim


Hello World  ...
$_
```


## Building error

If you get a similar error

```
$ docker run --rm -it -v $(pwd):/work omslab/oms simulation/ex00_HelloWorld.sim

Buildfile: /work/build.xml

BUILD FAILED
/work/build.xml:7: The following error occurred while executing this line:
/work/.oms/project.xml:65: /root/.oms/3.5.25 does not exist.

Total time: 0 seconds
ERROR: OMS project not built

*********************************
***     SIMULATION ABORTED    ***
*********************************

An error occured. Exiting...
OMS version: 3.5.59
$_
```
check the last line printed out by the Docker image (```OMS version: 3.5.59``` in this example).
Open the file ```.oms/project.properties``` (the .oms/ folder is a hidden folder in the OMS project) and change the flag at line 14 ```oms.version``` to ```3.5.59```. The latter is the OMS version bundled in the Docker image.

# Supported Docker versions

This image is officially supported on Docker version 1.13.0.

Support for older versions (down to 1.6) is provided on a best-effort basis. Please see [the Docker installation documentation][] for details on how to upgrade your Docker daemon.


# Summary

Following a summary of the steps to take for installing and running GEOtop.

1. Install [Docker][]:
   [GNU/Linux][], [Mac OS X][], [Windows][] 
2. Download and unpack the [ex01][] example:
   ```$ unzip ex01.zip```
3. Open a terminal and change into the [ex01][] directory:
   ```$ cd ex01```
4. Run the OMS Docker image:
   ```$ docker run --rm -it -v $(pwd):/work omslab/oms simulation/ex00_HelloWorld.sim```


# Feedback

# Known Issues

* The Docker OMS image runs as the ```root``` user, thus the output files have root ownership. However, you can always open and read them without any problem;
* To stop OMS mid-run, use the ```docker stop``` or ```docker kill``` command.
* OMS runs from within the container. This is the reason why the screen output shows ```/work/<file or folder>``` instead of your current path.
* On certain Linux distributions (e.g. Ubuntu) you have to either run docker via ```sudo docker run ...``` or you configure the ```sudoers``` file for Docker. 

## Bibliography

David, O., Ascough, J. C., Lloyd, W., Green, T. R., Rojas, K. W., Leavesley, G. H., & Ahuja, L. R. (2013). [A software engineering perspective on environmental modeling framework design: The Object Modeling System][]. Environmental Modelling & Software, 39, 201-213.

Ahuja, L. R., Ii, J. A., & David, O. (2005). [Developing natural resource models using the object modeling system: feasibility and challenges][]. Advances in Geosciences, 4, 29-36.

Kralisch, S., Krause, P., & David, O. (2005). [Using the object modeling system for hydrological model development and application][]. Advances in Geosciences, 4, 75-81.

[```beta```, (beta/Dockerfile)]: https://github.com/sidereus3/oms-docker/blob/master/beta/Dockerfile
[```0.1_py2```, (0.1_py2/Dockerfile)]: https://github.com/sidereus3/oms-docker/blob/master/0.1_py2/Dockerfile
[```0.1_py3```, (0.1_py3/Dockerfile)]: https://github.com/sidereus3/oms-docker/blob/master/0.1_py3/Dockerfile
[```0.2_py3```, (0.2_py3/Dockerfile)]: https://github.com/sidereus3/oms-docker/blob/master/0.2_py3/Dockerfile
[https://alm.engr.colostate.edu/cb/wiki/16961]: https://alm.engr.colostate.edu/cb/wiki/16961
[http://oms.colostate.edu/]: http://oms.colostate.edu/
[GNU/Linux]: https://docs.docker.com/engine/installation/
[Mac OS X]: https://docs.docker.com/docker-for-mac/
[Windows]: https://docs.docker.com/docker-for-windows/
[ex01]: https://github.com/sidereus3/oms-docker/blob/master/ex01.zip?raw=true
[Basic Examples]: https://alm.engr.colostate.edu/cb/wiki/17119
[A software engineering perspective on environmental modeling framework design: The Object Modeling System]: http://www.sciencedirect.com/science/article/pii/S1364815212000886
[Developing natural resource models using the object modeling system: feasibility and challenges]: https://hal.archives-ouvertes.fr/hal-00296806/
[Using the object modeling system for hydrological model development and application]: https://hal-insu.archives-ouvertes.fr/file/index/docid/296816/filename/adgeo-4-75-2005.pdf

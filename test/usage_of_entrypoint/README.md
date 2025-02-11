# Lets undestand how ENTRYPOINT works:


```
cd /directory/where/dockerfile/exists
docker build -t test .
```

```
docker run -it --rm --name test-container test -H

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0    8872   4704   2828 R   0.0   0.1   0:00.02 top
```


<br/>

```
docker exec -it test-container ps aux

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   8840  5056 pts/0    Ss+  05:05   0:00 top -b -H
root         7  0.0  0.0   2800  1068 pts/1    Ss+  05:05   0:00 /bin/sh
root        14 33.3  0.0   7888  3892 pts/2    Rs+  05:08   0:00 ps aux
```


<br/>

```
docker stop test-container

test-container
```


<br/>

```
docker run -it --rm --name test-container test

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0    8716   4628   2752 R   0.0   0.1   0:00.04 top -b -c
```


<br/>

```
docker exec -it test-container ps aux

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.1  0.0   8716  4628 pts/0    Ss+  05:20   0:00 top -b -c
root         7  200  0.0   7888  3904 pts/1    Rs+  05:21   0:00 ps aux
```


<br/>

```
docker stop test-container

test-container
```



### My Understanding:
- What ENTRYPOINT does is, when the container starts, the ENTRYPOINT executes provided executable inside that container as PID=1 , in our case the executable top -b (i.e. "ENTRYPOINT ["top", "-b"]") and most important CMD ["-c"] defines the default arguments to the "top -b"
- So we can run/start this container with two options
    1. By providing command line argument to docker run which will override the "-c" argument, this will start the container and run "top -b -H" command inside the container
        ```
        docker run -it --rm --name test-container test -H
        ```
			
    2. By just runnning/starting the container without passing any arguments to docker run command, this will start the container and run "top -b -c" command inside the container
        ```
        docker run -it --rm --name test-container test
        ```

> [!Note]<br/>
> `top -b` Allows top to run in the background and output results non-interactively<br/>
> `top -H` To monitor treads<br/>
> `top -c` To monitor process

-------------------------------------------------
<br/>

```
docker build -f Dockerfile_with_entrypoint_script -t test-with-entrypoint-script .
```

#### Option 1: Default 

```
docker run -d --name test-with-entrypoint-script-container test-with-entrypoint-script
```

Checks logs of container on Docker Desktop:
`2025-02-03 11:30:26 Running first_fun....`

```
docker rm test-with-entrypoint-script-container
```


#### Option 2: Override Default 

```
docker run -d --name test-with-entrypoint-script-container test-with-entrypoint-script second
```

Checks logs of container on Docker Desktop:
`2025-02-03 11:36:22 Running second_fun....`


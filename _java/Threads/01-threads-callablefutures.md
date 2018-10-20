---
title: "Threads: Callable Future"
permalink: /java/threads/callablefutures/
excerpt: "Multithreading using Callable Futures"
toc: false
mathjax: true
classes: wide
---

## Notes

This is how I did it, and this what worked for me.

```java
ExecutorService executor = Executors.newCachedThreadPool();
Callable<String> callable = () -> {
                    // Do stuff
                    return String;
                };
                Future<String> future = executor.submit(callable);
                list.add(future);
            }
            // Get Futures
            try{
                for(Future<String> fut : list) {
                    String string = fut.get();
                    System.out.println(string);                    
                    }
                }
            }catch(InterruptedException | ExecutionException e){
                e.printStackTrace();
            }finally{
                executor.shutdown();
            }
```
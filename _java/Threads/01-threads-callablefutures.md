---
title: "Threads: Callable Future"
permalink: /java/threads/callablefutures/
excerpt: "Multithreading using Callable Futures"
toc: false
mathjax: true
classes: wide
---

## Notes

### My Way

This is how I did it, and this what worked for me.

```java
public class MyCallableLambda {
    public static void main(String[] args) {
        ArrayList<Future<String>> list = new ArrayList<>();
        ExecutorService executor = Executors.newCachedThreadPool();
        Callable<String> callable = () -> {
            // Do stuff
            return Thread.currentThread().getName();
        };
        Future<String> future = executor.submit(callable);
        list.add(future);
        // Get Futures
        try {
            for (Future<String> fut : list) {
                String string = fut.get();
                System.out.println(string);
            }
        } catch (InterruptedException | ExecutionException e){
            e.printStackTrace();
        } finally {
            executor.shutdown();
        }
    }
}            
```

### This way did not work

```java
public class MyCallable implements Callable<String> {
    @Override
    public String call() throws Exception {
        Thread.sleep(1000);
        //return the thread name executing this callable task
        return Thread.currentThread().getName();
    }

    public static void main(String args[]){
        //Get ExecutorService from Executors utility class, thread pool size is 10
        ExecutorService executor = Executors.newFixedThreadPool(10);
        //create a list to hold the Future object associated with Callable
        List<Future<String>> list = new ArrayList<Future<String>>();
        //Create MyCallable instance
        Callable<String> callable = new MyCallable();
        for(int i=0; i< 100; i++){
            //submit Callable tasks to be executed by thread pool
            Future<String> future = executor.submit(callable);
            //add Future to the list, we can get return value using Future
            list.add(future);
        }
        for(Future<String> fut : list){
            try {
                //print the return value of Future, notice the output delay in console
                // because Future.get() waits for task to get completed
                System.out.println(new Date()+ "::"+fut.get());
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }
        }
        //shut down the executor service now
        executor.shutdown();
    }
}
```




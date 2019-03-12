---
layout: single
title: "Optional"
permalink: /java/optional
---

While working on exercises contained in the Object-oriented programming MOOC from the University of Helsinki, I found myself trying to `get` a non-existent _key_ from a `HashMap`.

This returned a `NullPointerException`. I thought this would be a sensible situtation to work with the `Optional` API.

## Scenario

Suppose we have the following usernames and passwords stored in a `HashMap`:

| Username  |Password   |
|---|---|
|alex|mightyducks|
|emily|cat|


```java
HashMap<String, String> credMap = new HashMap<>();

credMap.put("alex", "mightyducks");
credMap.put("emily", "cat");
```

We have written a program that prompts for username and password:

```java
System.out.println("Type your username:");
String username = reader.nextLine();

System.out.printf("Type your password:");
String password = reader.nextLine();
```

If we type in the correct credentials then good. And if we type in the incorrect credentials for _alex_ or _emily_, then we can handle that too.

```java
if(credMap.get(username).equals(password))
System.out.println("You are now logged into the system!");
else
System.out.println("Your username or password was invalid!");     

```

But what if we type in, say, _John_-- a nonexistent username? The HashMap will return a `NULL` which will cause Java to error as soon as we attempt to invoke `equals()`.

We can simply wrap the HashMap in an `Optional`. Now:

```java
Optional<String> cred = Optional.ofNullable(credMap.get(username));
if(cred.isEmpty())
    System.out.println("Your username or password was invalid!");
else if(cred.get().equals(password))
    System.out.println("You are now logged into the system!");
```
Not convinced this is a good application of `Optional`. Still, it's a start.

The course's submission system didn't seem to like me using this API, so I rewrote my code:

```java
if(credMap.get(username) == null)
    System.out.println("Your username or password was invalid!");
else if(credMap.get(username).equals(password))
    System.out.println("You are now logged into the system!");
```



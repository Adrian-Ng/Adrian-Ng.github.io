---
title: "Java: readTxt()"
permalink: "/java/utils/readtxt/"
excerpt: "A method for reading text files line-by-line. Returns String[]. Text qualifiers and delimiters ignored."
toc: false
classes: wide
---

A __method__ for reading text files line-by-line. Returns `String[]`. Text qualifiers and delimiters ignored.

```java
public static String[] readTxt(String filename) throws FileNotFoundException {
        Scanner inFile = new Scanner(new FileReader(filename));
        ArrayList<String> stringArrayList = new ArrayList<String>();
        while(inFile.hasNextLine()){
            String strLine = inFile.nextLine();
            stringArrayList.add(strLine);
        }
        String[] stringArray = stringArrayList.toArray(new String[stringArrayList.size()]);
        return stringArray;
    }
```
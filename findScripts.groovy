// Copyright (c) 2011-2025  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

// find all references to scripts
//
// it takes one optional argument, which is appended to the output

if (args.length == 0) {
  println "groovy findScripts.groovy <directory> [suffix]"
  System.exit(0)
}

def folder = args[0]

def suffix = ""
if (args.length == 2) suffix = args[1]

def basedir = new File(folder)
files = basedir.listFiles().grep(~/.*i.md$/)
files.each { file ->
  file.eachLine { line ->
    try {
      if (line.contains("<guidance>")) {
        start = line.indexOf("<guidance>")
        end = line.indexOf("</guidance>")
        text = line.substring(start + 10, end)
        println "" + text + suffix
      }
    } catch (Exception exception) {
      println "Error reading line: " + line
      System.exit(-1)
    }
  }
}


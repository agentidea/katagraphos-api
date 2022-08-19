Say you want to represnt a song, send a list to

    http://katagraphos.net:8090/api/record/Augustism01/Grant.Steinfeld

    list example 
  ```JSON
  [
  {
    "Title": "Love Is a Stranger (Remastered Version)",
    "Album": "Sweet Dreams (Are Made Of This)",
    "SongBy": "Annie Lennox, Dave Stewart and Blancmange",
    "Year":"1983",
    "Label":"RCA Records",
    "Lyrics":"https://genius.com/Eurythmics-love-is-a-stranger-lyrics",
    "Source":"YouTube",
    "src":"https://www.youtube.com/watch?v=xwDlfDdum8s"
  },
      "Title": "Love Is a Stranger (Remastered Version)",
    "Album": "Sweet Dreams (Are Made Of This)",
    "SongBy": "Annie Lennox, Dave Stewart and Blancmange",
    "Year":"1983",
    "Label":"RCA Records",
    "Lyrics":"https://genius.com/Eurythmics-love-is-a-stranger-lyrics",
    "Source":"YouTube",
    "src":"https://www.youtube.com/watch?v=xwDlfDdum8s"
  }
  ]
  ```

  or maybe a short form
  ```JSON
  [
  {
    "Title": "Living on the Ceiling",
    "Album": "Happy Families",
    "SongBy": "Blancmange",
    "Year":"1982"
  },

  {
    "Title": "Starman",
    "Album": "The Rise and Fall of Ziggy Stardust and the Spiders from Mars",
    "SongBy": "David Bowie",
    "Year":"1972"
  }

]
```

ANY record(s) using this format

```JSON
[
    {"ITEM":"eggs, ham",
    "COLOR":"Yellow"},
    {"ITEM":"spinach, kale, broccolini",
    "COLOR":"Green"}
]
```
HTTP Project

markdown URL: https://github.com/turingschool/curriculum/blob/master/source/projects/http_yeah_you_know_me.markdown

  Learning Goals:
  1) Receiving a request from a user
  2) Comprehending the request's intent and source
  3) Generating a response
  4) Sending the response to the user

  Iteration 0:
  -listens on port 9292
  -responds to HTTP request
  responds with a valid HTML response that displays the words Hello, World! (0) <-- the 0 increments each request until the server is restarted

  Iteration 1: Outputting diagnostics:
  Make request look like this:

  <pre>
  Verb: POST
  Path: /
  Protocol: HTTP/1.1
  Host: 127.0.0.1
  Port: 9292
  Origin: 127.0.0.1
  Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
  </pre>

  This should be in the 'body of your response' including the actual information from the request.

  Iteration 2: Supporting Paths
  -If user requests the root, / , respond with JUST the debug info from Iteration 1
  -If user requests the /hello path, respond with "Hello, World! (0)" <-- the 0 increments each time
  the path is requested, but not when any other path is requested.
  -If user requests the /datetime path, respond with todays date and time, like this: 7:23PM on Monday, October 24, 2016
  -If user requests the /shutdown path, respond with "Total Requests: 12" where 12 is the aggregate of all
  requests. Causes server to exit/stop serving requests, as well.

  Iteration 3: Supporting Parameters
  *remember comp has a dictionary located at: /usr/share/dict/words
    -The path is /word_search
    -The verb will always be a GET
    -parameter should be named word
    -The value will be a possible word fragment(?)
        *Should print out: WORD is a known word OR,
        * WORD is not a known word
          -word is the parameter from the URL

  Iteration 4: Verbs & Parameters
  -PATH is the primary way the user specifies what they're requesting, secondary tool is the VERB(servers
    typically use GET and POST verbs)
      *use GET to fetch info, use POST to send info to the server.
        -Parameters in a POST are typically in the body of the request rather than in the URL.

    *Let's practice applying these techniques by building a simple guessing game that can be played via our HTTP server.

      The game will work like this:

      -When a player starts a new game, the server picks a random number between 0 and 100.
      -The player can make a new guess by sending a POST request containing the number they want to guess.
      -When the player requests the game path, the server should show some information about the game including how many guesses have been made, what the most recent guess was, and whether it was too high, too low, or correct.

###
Raconteur story scaffold, copyright (c) Bruno Dias 2015.

Distributed under the MIT license. See LICENSE for information.

In a finished game file, almost all of this scaffold will have been replaced
by new content (the new game does not carry "substantial parts" of this code)
so this copyright notice may be removed and replaced with your own.
###

# Require the libraries we rely on

situation = require('raconteur')
undum = require('undum-commonjs')
oneOf = require('raconteur/lib/oneOf.js')
elements = require('raconteur/lib/elements.js')
qualities = require('raconteur/lib/qualities.js')

a = elements.a
span = elements.span
img = elements.img

# ----------------------------------------------------------------------------
# IFID and game version - Edit this

undum.game.id = "5113b18d-4a6e-4e12-a45b-1212e33bf388"
undum.game.version = "0.1"

# ----------------------------------------------------------------------------
# Game content

situation 'start',
  content: """

  # Welcome to Research Adventures

  This is a simple, interactive adventure to help you improve your research skills.

  ![a map of your adventure](img/map.png)


  Research adventures are created by artefacto and you can find out more at [Github Repository], where you can report issues or
  send feedback.



  The important thing to remember is that there is no single path to your research destination.But some routes are more scenic than others.




  So, now we've introduced ourselves, [let's begin](research_challenge)

  [Github Repository]: https://github.com/artefacto/
  """
situation 'research_challenge',
  content: """
    Your challenge, if you choose to accept it is research:

    > _How many Eskimo words are there for snow?_


  Again, a deceptively simple question that will touch on the ways language reflects cultural, values and our perception.

  It's often said that Eskimos have 99 words for snow (the number quoted changed but we’ll get to that). But what does this even mean?


In this adventure, we’ll explore a bit of linguistics, cultural studies, anthropology and maybe even a bit about memes.


If you’re ready to get started, then [let’s go](first_steps).


  """

  situation 'first_steps',
  content: """
  Our search begins, as searches often do, with a simple search engine. You go to Google and stare briefly at the empty search box.

  What to type? We’re not 100% sure of the number and well, we feel a bit awkward about using the word Eskimo. Shouldn't it be Inuit? But, no, the quoted phrase is definitely _eskimo_ so maybe it's better to stick with that...

What we need here is a search strategy. [It's time to make a plan](write_search_strategy)


"""

  situation 'write_search_strategy',
    content: """

    ### A strategy called search
      So, what do we need to include in a search stategy? We need to be clear what we're trying to answer and what the keywords are for starters.

      One of the things they tell you about navigating a maze is to always keep your hand on the wall. Eventually this will lead you to the way out. And this is a handy way to think about search strategies. Have a strategy will keep you on a path to finding the answer to the question you are researching.

      ![thinking music](img/thinking1.gif)

      Take a second to think about what you'll include. What are other possible terms that could be used, alternative ways of looking at this, things that we don't want to include.  [before we create our strategy](complete_search_strategy)



    """

situation 'complete_search_strategy',
  after: (character, system) ->
    system.setQuality('hasStrategy', character.qualities.hasStrategy + 1);

      # after: (character) ->
      #    system.setQuality('hasStrategy', character.qualities.hasStrategy + 1);
  content: """
    You are now equiped with a search strategy which means you're ready to get researching.
  """
  choices: ['commence_search_mission']
  optionText: 'Collect your strategy and put it in backpack',


situation 'commence_search_mission',
  content: """
    Where to start? There are two passages, you can head to the library website or turn the other direction and start with an internet search.
  """
  optionText: 'Research is go'
  choices: ['to_the_library', 'to_the_google']

situation 'to_the_library',
  content: (character) ->
    """
    <h3>At the library</h3>
  
    You head off to the main catalogue page. As always, you need to decide on the search terms you will use.

    The initial online research has helped shed some light on the topic so now you’re interested in following up on this with academic sources. We know that both the issue of what languages are spoken by different ‘Eskimo’ communities will have an impact on our research as is the concept of how we dinstinguish between concepts, words and ‘lexemes’.

    Here you can #{a('collect some points for your diligence').once().action('increase-diligence')}.
  """
  actions:
    'increase-diligence': (character, system) ->
      system.setQuality('diligence', character.qualities.diligence + 10)
  optionText: 'To the library'
  choices: ['further_in_the_library']
  canView: (character) -> character.qualities.hasStrategy

situation 'further_in_the_library',
  content: """
  The library has a range of different resources, from the dead tree varieties to online databases that bring together a huge amount of different academic publications online.

  """
  optionText: 'Head deeper into the library'

situation 'to_the_google',
  after: (character, system) ->
    system.setQuality('googleFu', character.qualities.googleFu + 10);
  content: """

  <h2>A simple Google search</h2>
  You put the cursor in the search box and type "eskimo words for snow".

  According to Google, you received About 411,000 results (0.33 seconds). And as is often the case, the first search result is from Wikipedia.
  """
  optionText: 'To the Google'
  choices: ['search_results_in_detail', 'i_feel_lucky']
  canView: (character) -> character.qualities.googleFu;


situation 'search_results_in_detail',
  after: (character, system) ->
    system.setQuality('googleFu', character.qualities.googleFu + 40);
  content: """
  <h2>Diving deeper into search engine results</h2>
  You decide to take a closer look at the search results from Google in case there's something beyond the first couple of results that looks useful.

  You scan over the other entries on the first page of Google search results (and even glance at the second page if you’re feeling brave).

  One of the top results is titled 'Counting Eskimo words for snow - Princeton University’ which sounds promising and suitably academic so you click on that to take a look.

 This article lists lexemes referring to snow in the Yup'ik Eskimo language. The distinction between words and lexemes is interesting. You can already start to see how you not only need to define ‘Eskimo language’ but also what constitutes a word. This is getting complicated.

 Time to follow up on some of these journal sources now that we've got a bit of Google fu to our name.
 """
  optionText: 'Google search results'
  choices: ['to_the_library', 'google_scholar']


  wikipediaMisuse = oneOf("keeps getting into edit wars with bronies", "keeps getting into edit wars about the correct pronunciation of JK Rowling's surname", "keeps getting into edit wars about Edina's racist past", "keeps adding new names to the list of So Solid Crew members", "keeps trying to singlehandedly restore Pluto's status as a planet").trulyAtRandom()

situation "i_feel_lucky",
  content: () ->
  """
  You click on the first result and it takes you to the wikipedia page called (funnily enough) "Eskimo words for snow".

  Right from the very first paragraph, you find out that this is generally attributed to someone called Franz Boas and that "Eskimo–Aleut languages" (whatever they are) don’t have many more words for snow than English does.

  It goes on and on about the history of this claim and the different attempts to debunk it. And something about Edward Sapir's and Benjamin Whorf's hypothesis of linguistic relativity. Which is all very interesting but, c’mon, this is wikipedia. Can you really believe what you read in Wikipedia? Not when you’re cousin’s best friend’s sister #{wikipediaMisuse}.

What we are asking about here is ‘authority’. To know whether the information we’ve found is reliable and true, we need to know something about the credibility of the source. Who wrote it? What biases might they have? What is their expertise?

And the thing about Wikipedia is that the authority of its entries can vary so it’s important to verify the information you get from here. But that’s really true of any information source. The important thing is to make sure you know where the information comes from and wikipedia’s citations are an important source for this.

So, we next look a bit closer at the wikipedia entry for ‘Eskimo words for snow’.
    """
  optionText: 'Wikipedia feels lucky'

situation 'google_scholar',
  after: (character, system) ->
    system.setQuality('googleFu', character.qualities.googleFu + 100);
  content: () ->
    """
      You put the cursor in the search box and type eskimo words for snow.

      According to Google, you received About 411,0o000 results (0.33 seconds). And as often happens, the first search result is from Wikipedia.
    """
  optionText: 'Goolge Scholar'

# ----------------------------------------------------------------------------
# Qualities

qualities
  stats:
    name: 'Statistics',
    curiosity: qualities.integer('Curiosity', {priority: '001'}),
    diligence: qualities.integer('Diligence', {priority: '002'}),
    skills: qualities.integer('Skills', {priority: '003'}),
  possessions:
    name: 'Possessions',
    googleFu: qualities.integer('Google fu'),
    hasStrategy: qualities.integer('Search strategy')
    options:
      extraClasses: ["possessions"]


#-----------------------------------------------------------------------------
# Initialise Undum

undum.game.init = (character, system) ->
  # Add initialisation code here
  character.qualities.curiosity = 10
  character.qualities.diligence = 12
  character.qualities.skills = 14
  character.qualities.googleFu = 0
  character.qualities.hasStrategy = 0

# Get the party started when the DOM is ready.

window.onload = undum.begin

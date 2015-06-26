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
  ![a storyteller](img/storyteller.jpg)

  # Welcome to Research Adventures

  This is a simple, interactive adventure to help you improve your research skills.



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
  content: """
    You decide it’s time to try the library catalogue so you head off to the main catalogue page. As always, you need to decide on the search terms you will use.
    [conditional on whether already done searching with google]
    The initial online research has helped shed some light on the topic so now you’re interested in following up on this with academic sources. We know that both the issue of what languages are spoken by different ‘Eskimo’ communities will have an impact on our research as is the concept of how we dinstinguish between concepts, words and ‘lexemes’. 

    Here you can #{a('collect some points for your diligence').once().action('increase-diligence')}.
  """
  actions:
    'increase-diligence': (character, system) ->
      system.setQuality('diligence', character.qualities.diligence + 10)
  optionText: 'To the library'
  choices: ['to_the_google', 'further_in_the_library']
  canView: (character) -> character.qualities.hasStrategy

situation 'further_in_the_library',
  content: """
  The library has a range of different resources, from the dead tree varieties to online databases that bring together a huge amount of different academic publications online.

  """
  optionText: 'Header deeper into the library'

situation 'to_the_google',
  content: """
  You put the cursor in the search box and type 'eskimo words for snow'.

  According to Google, you received 'About 411,000 results (0.33 seconds)’. And as is often the case, the first search result is from Wikipedia.
  """
  optionText: 'To the Google'
  choices: ['search_results_in_detail', 'i_feel_lucky']

situation 'search_results_in_detail',
  content: """
  You decide to take a closer look at the search results from Google in case there's something beyond the first couple of results that looks useful.
  """
  optionText: 'Google search results'

situation 'i_feel_lucky',
  content: """
    I feel lucky wikipedia content here
    """
  optionText: 'Wikipedia feels lucky'



# ----------------------------------------------------------------------------
# Qualities

qualities
  stats:
    name: 'Statistics',
    curiosity: qualities.integer('Curiosity', {priority: '001'}),
    diligence: qualities.integer('Diligence', {priority: '002'}),
    skills: qualities.integer('Skills', {priority: '003'}),
    perception: qualities.integer('Perception', {priority: '005'}),
  possessions:
    name: 'Possessions',
    enlightenment: qualities.integer('enlightenment'),
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
  character.qualities.perception = 16
  character.qualities.enlightenment = 100
  character.qualities.hasStrategy = 0

# Get the party started when the DOM is ready.

window.onload = undum.begin

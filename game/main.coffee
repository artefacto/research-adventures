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

wikipediaMisuse = oneOf("keeps getting into edit wars with bronies", "keeps getting into edit wars about the correct pronunciation of JK Rowling's surname", "keeps getting into edit wars about Edina's racist past", "keeps adding new names to the list of So Solid Crew members", "keeps trying to singlehandedly restore Pluto's status as a planet").trulyAtRandom()

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



Remember, there is no single path to your research destination.But some routes are more scenic than others.


  So, now we've introduced ourselves, [let's begin](research_challenge)

  [Github Repository]: https://github.com/artefacto/
  """
situation 'research_challenge',
  content: """
  ## Your challenge
    Your challenge, if you choose to accept it is research:

    > _Research challenge goes here_

If you’re ready to get started, then [let’s go](first_steps).


  """

  situation 'first_steps',
  content: """
  Our search begins, as searches often do, with a simple search engine. You go to Google and stare briefly at the empty search box.


What we need here is a search strategy. [It's time to make a plan](write_search_strategy)


"""

  situation 'write_search_strategy',
    content: """

    ### A strategy called search
      So, what do we need to include in a search stategy? We need to be clear on what are topic is and what the _keywords_ are for starters. Ask yourself if there are other words or phrases that might also be relevant to the information you seek.

      One of the things they tell you about navigating a maze is to always keep your hand on the wall. Eventually this will lead you to the way out. And this is a handy way to think about search strategies. Have a strategy will keep you on a path to finding the answer to your research question.


    [Create a search strategy](complete_search_strategy)



    """

situation 'complete_search_strategy',
  after: (character, system) ->
    system.setQuality('hasStrategy', character.qualities.hasStrategy + 1);

      # after: (character) ->
      #    system.setQuality('hasStrategy', character.qualities.hasStrategy + 1);
  content: """
  ## Search strategy collected
    You are now equiped with a search strategy and are clear on what your searching for, what keywords you will use and what some possible synonyms and alterative phrasings are to get this information.  Basically, you're ready to get researching.
  """
  choices: ['commence_search_mission']
  optionText: 'Collect your strategy and put it in backpack',


situation 'commence_search_mission',
  content: """
  <h3>Starting your search</h3>
    Where to start? There are two passages, you can head to the library website or turn the other direction and start with an internet search.

  """
  optionText: 'Research is go'
  choices: ['to_the_library', 'to_the_google']

situation 'to_the_library',
  content: (character) ->
    """
    <h3>At the library</h3>
    You head off to the main catalogue page. As always, you need to decide on the search terms you will use.

    The initial online research has helped shed some light on the topic so now you’re interested in following up on this with academic sources.

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
  The library has a range of different resources, from the dead tree variety to online databases that bring together a huge amount of different academic publications and make them available online.

  """
  optionText: 'Head deeper into the library'
  choices: ['library_databases', 'find_a_librarian']

situation 'to_the_google',
  after: (character, system) ->
    system.setQuality('googleFu', character.qualities.googleFu + 10);
  content: """
  You put the cursor in the search box and type your keywords {[suggestions welcome]}.

  According to Google, you received About 411,000 results (0.33 seconds). And as is often the case, the first search result is from <a href="i_feel_lucky">Wikipedia</a>.
  """
  optionText: 'To the Google'
  choices: ['search_results_in_detail','i_feel_lucky']

situation 'search_results_in_detail',
  after: (character, system) ->
    system.setQuality('googleFu', character.qualities.googleFu + 40);
  content: """
  <h2>Diving deeper into search engine results</h2>
  You decide to take a closer look at the search results from Google in case there's something beyond the first couple of results that looks useful.

  You scan over the other entries on the first page of Google search results (and even glance at the second page if you’re feeling brave).

 Time to follow up on some of these journal sources now that we've got a bit of Google fu to our name.
 """
  optionText: 'Dive deeper into the Google search results'
  choices: ['to_the_library', 'google_scholar']
  # can't see the option unless you have some Google Fu
  # canView: (character) -> character.qualities.googleFu; > 10


situation 'google_scholar',
  after: (character, system) ->
    system.setQuality('googleFu', character.qualities.googleFu + 100);
  content: () ->
    """
    <h3>About Google Scholar</h3>
      Google scholar is a bit of a hidden treasure that let's you search scholarly literature. What Google deems to be scholarly can vary a bit but generally it includes journal articles, citations, patents and other academic materials.

      Some of these are freely available but may will just return the citation.

      That is unless your a member of a library that uses a Link Resolver, a little bit of interweb magic that means that you can access your library's database resources via the Google Scholar interface. In full text!

      Anyway, enough of the background of Google Scholar, time to search.

      You type in your keywords and hit enter.
    """
  optionText: 'Google Scholar'
  choices: ['google_scholar_results', 'to_the_library']

  situation 'i_feel_lucky',
  content: (character) ->
    """
  ### Wikipedia feels lucky
  You click on the first result and it takes you to the wikipedia page called (funnily enough) "Eskimo words for snow".

Which is all very interesting but, c’mon, this is wikipedia. Can you really believe what you read in Wikipedia when you’re cousin’s best friend’s sister #{wikipediaMisuse}?


  """
  choices: ['authority']
  optionText: "Wikipedia feels lucky"

  situation 'google_scholar_results',
    content: """
    Amazing, the very first result in Google Scholar is:
      _Eskimo Words for Snow": A Case Study in the Genesis and Decay of an Anthropological Example_

      Sounds perfect _and_ it's available in PDF. Full text for the win. You download the article and get to reading, getting one step closer to finding out how many words for snow there are.

    """
    optionText: 'Google Scholar Results!'

    situation 'find_a_librarian',
      content: """
      ### How to get help
      Add details about contacting a librarian to get help with a research query.
      Here you can #{a('collect some points for not being too cool to ask for help').once().action('seek-help')}.

      """
      actions:
        'seek-help': (character, system) ->
          system.setQuality('curiosity', character.qualities.curiosity + 20)
      optionText: 'Find a librarian'
      choices: ['subject_guides']


  situation 'library_databases',
    content: """
    ### Databases in the library
    Add details about the specific the databases available in your library.
    """
    optionText: 'Library databases'

    situation 'subject_guides',
      content: """
      ### Find a subject guide
      Add details about subject guides users can download or find online
      """
      optionText: 'Subject guides available'


    situation 'authority',
      content: """
      ## A little thing called authority

      What we are asking about here is ‘authority’. To know whether the information we’ve found is reliable and true, we need to know something about the credibility of the source. Who wrote it? What biases might they have? What is their expertise?

      And the thing about Wikipedia is that the authority of its entries can vary so it’s important to verify the information you get from here. But that’s really true of any information source.

      So, we next look a bit closer at the wikipedia entry for your topic.

      """
      optionText: 'Authority?'
      choices: ['more_wikipedia']

    situation 'more_wikipedia',
      content: """
      ## Diving deeper into Wikipedia
      A lot of the useful stuff in Wikipedia comes from the __See also__ and the __References__ sections. Here's where you find the citations and original sources for the information in the main article.

      """
      optionText: 'Back to Wikipedia with an authoritative vengence'
      choices: ['to_the_library']


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

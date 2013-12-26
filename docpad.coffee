# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON

marked = require('marked')
#moment = require('moment')

docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The default title of our website
			title: "Google IO 2013 slides template"
			keywords: "html5, slideshow"
			author: "@novogeek"

		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.event}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.event

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.title

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')
		parseMarkdown: (str) -> marked(str)

	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
	# Google-IO slides
		slides: (database) ->
			database.findAllLive({relativeOutDirPath: 'slides', hide: {$exists: false}, slideOrder: {$exists: true}},{slideOrder:1})
}


# Export our DocPad Configuration
module.exports = docpadConfig

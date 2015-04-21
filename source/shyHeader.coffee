	$.fn.shyHeader = (options) ->
		@addClass "shyHeader"
		defaults = 
			distanceBeforeHide: 250
			distanceBeforeShow: 50
			elemToHide: @
			visiblePos: 0
			hiddenPos: -@outerHeight()
			duration: 0.3
			delay: 500 
			visibleClass: "visible"
			hiddenClass: "hidden"
			useJS: true  #Turns this off to hide the element via css, with the classes provided
			destroy: false #Call the plugin with this options set to true to destroy the current instance of the plugin


		options = $.extend defaults,options
		startingPos = options['elemToHide'].offset().top
		currentOffset = $(window).scrollTop()
		lastScrollPos = 0
		lastScrollPosUp = 0
		gotScrollPos = false
		isHidden = false
		reachedFooter = false

		$(window).on "scroll", ->
			$(window).trigger("shy-scroll")

		scrollHandler = (e) ->

			_scrollTop = $(window).scrollTop();
			_end = $("footer").offset().top - $("header").outerHeight()

			if _scrollTop > _end
				reachedFooter = true
				$('header').css
					"position": 'absolute'
					"top":  _end
			else
				if reachedFooter
					$('header').css
						"position": 'fixed'
						"top":  options['hiddenPos']
					reachedFooter = false

				if _scrollTop > lastScrollPos
					downHandler(_scrollTop, options['elemToHide'])

				else
					upHandler(_scrollTop, options['elemToHide'])

			lastScrollPos = _scrollTop
		if !options['destroy']

			_debounceTimer = null
			$(window).on "shy-scroll", ()->
				clearTimeout(_debounceTimer)
				setTimeout ()->
					scrollHandler();
				, options['delay']

			downHandler = (_st,el) ->
				
				if (_st >= currentOffset + options['distanceBeforeHide']) && !isHidden
					if options['useJS']
						TweenLite.to(
							options['elemToHide']
							options['duration']
							{
								top: options['hiddenPos']
								ease: Quint.easeOut
							}
						)

					el.removeClass "shy-visible"
					el.addClass "shy-hidden"
					gotScrollPos = false
					isHidden = true
				else
					return 

			upHandler = (_st,el) ->
				if !gotScrollPos
					gotScrollPos = true
					lastScrollPosUp = _st
				if _st <= lastScrollPosUp - options['distanceBeforeShow'] && isHidden
					if options['useJS']
						TweenLite.to(
							options['elemToHide']
							options['duration']
							{
								top: options['visiblePos']
								ease: Quint.easeOut
							}
						)
					
					isHidden = false
					el.removeClass "shy-hidden"
					el.addClass "shy-visible"
				currentOffset = _st
		else
			$(window).unbind("shy-scroll")
			@removeClass "shyHeader"
			@removeClass "shy-visible"
			@removeClass "shy-hidden"
			options['elemToHide'].css
				"top": ""
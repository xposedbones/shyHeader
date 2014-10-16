	$.fn.shyHeader = (options) ->
		@addClass "shyHeader"
		defaults = 
			distanceBeforeHide: 250
			distanceBeforeShow: 0
			elemToHide: @
			visiblePos: 0
			hiddenPos: -@outerHeight()
			duration: 0.3
			visibleClass: "visible"
			hiddenClass: "hidden"
			useJS: true  #Turns this off to hide the element via css, with the classes provided
			destroy: false #Call the plugin with this options set to true to destroy the current instance of the plugin


		options = $.extend defaults,options
		startingPos = options['elemToHide'].offset().top
		currentOffset = $(window).scrollTop()
		lastScrollPos = 0
		isHidden = false
		if !options['destroy']
			
			$(window).on "scroll", (e) ->
	
				_scrollTop = $(window).scrollTop();

				if _scrollTop > lastScrollPos
					downHandler(_scrollTop, options['elemToHide'])

				else
					upHandler(_scrollTop, options['elemToHide'])

				lastScrollPos = _scrollTop

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
					isHidden = true
				else
					return 

			upHandler = (_st,el) ->
				
				if isHidden
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

			@removeClass "shyHeader"
			@removeClass "shy-visible"
			@removeClass "shy-hidden"
			options['elemToHide'].css
				"top": ""
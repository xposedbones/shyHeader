	$.fn.shyHeader = (options) ->
		@addClass "shyHeader"
		defaults = 
			distanceBeforeHide: 250
			distanceBeforeShow: 0
			elemToHide: @
			visiblePos: 32
			hiddenPos: -5
			duration: 0.3
			visibleClass: "visible"
			hiddenClass: "hidden"
			useJS: true  #Turns this off to hide the element via css, with the classes provided


		options = $.extend defaults,options
		startingPos = options['elemToHide'].offset().top
		currentOffset = 0
		lastScrollPos = 0
		isHidden = false

		$(window).on "scroll", (e) ->
			_scrollTop = $(window).scrollTop();

			if _scrollTop > lastScrollPos
				downHandler(_scrollTop)

			else
				upHandler(_scrollTop)

			lastScrollPos = _scrollTop

		downHandler = (_st) ->
			
			if (_st >= currentOffset + options['distanceBeforeHide']) && !isHidden
				if useJS
					TweenLite.to(
						options['elemToHide']
						options['duration']
						{
							top: options['hiddenPos']
							easing: Quint.easeOut
						}
					)

				@addClass "hidden"
				isHidden = true
			else
				return 

		upHandler = (_st) ->
			
			if isHidden
				if useJS
					TweenLite.to(
						options['elemToHide']
						options['duration']
						{
							top: options['visiblePos']
							easing: Quint.easeOut
						}
					)
				isHidden = false
				@addClass "visible"
			currentOffset = _st
// Generated by CoffeeScript 1.9.2
(function() {
  $.fn.shyHeader = function(options) {
    var _debounceTimer, currentOffset, defaults, downHandler, gotScrollPos, isHidden, lastScrollPos, lastScrollPosUp, reachedFooter, scrollHandler, startingPos, upHandler;
    this.addClass("shyHeader");
    defaults = {
      distanceBeforeHide: 250,
      distanceBeforeShow: 50,
      beforeHide: function() {},
      afterHide: function() {},
      beforeShow: function() {},
      afterShow: function() {},
      elemToHide: this,
      visiblePos: 0,
      hiddenPos: -this.outerHeight(),
      duration: 0.3,
      delay: 500,
      visibleClass: "visible",
      hiddenClass: "hidden",
      useJS: true,
      destroy: false
    };
    options = $.extend(defaults, options);
    startingPos = options['elemToHide'].offset().top;
    currentOffset = $(window).scrollTop();
    lastScrollPos = 0;
    lastScrollPosUp = 0;
    gotScrollPos = false;
    isHidden = false;
    reachedFooter = false;
    scrollHandler = function(e) {
      var _end, _scrollTop;
      _scrollTop = $(window).scrollTop();
      _end = $("footer").offset().top - $("header").outerHeight();
      if (_scrollTop > _end) {
        reachedFooter = true;
        $('header').css({
          "position": 'absolute',
          "top": _end
        });
      } else {
        if (reachedFooter) {
          $('header').css({
            "position": 'fixed',
            "top": options['hiddenPos']
          });
          reachedFooter = false;
        }
        if (_scrollTop > lastScrollPos) {
          downHandler(_scrollTop, options['elemToHide']);
        } else {
          upHandler(_scrollTop, options['elemToHide']);
        }
      }
      return lastScrollPos = _scrollTop;
    };
    if (!options['destroy']) {
      _debounceTimer = null;
      $(window).on("scroll", function() {
        clearTimeout(_debounceTimer);
        return setTimeout(function() {
          return scrollHandler();
        }, options['delay']);
      });
      downHandler = function(_st, el) {
        if ((_st >= currentOffset + options['distanceBeforeHide']) && !isHidden) {
          options['beforeHide'].call(this);
          if (options['useJS']) {
            TweenLite.to(options['elemToHide'], options['duration'], {
              top: options['hiddenPos'],
              ease: Quint.easeOut
            });
          }
          el.removeClass("shy-visible");
          el.addClass("shy-hidden");
          if (!options['useJS']) {
            options['afterHide'].call(this);
          }
          gotScrollPos = false;
          return isHidden = true;
        } else {

        }
      };
      return upHandler = function(_st, el) {
        if (!gotScrollPos) {
          gotScrollPos = true;
          lastScrollPosUp = _st;
        }
        if ((_st <= lastScrollPosUp - options['distanceBeforeShow'] && isHidden) || (_st <= options['distanceBeforeHide'])) {
          options['beforeShow'].call(this);
          if (options['useJS']) {
            TweenLite.to(options['elemToHide'], options['duration'], {
              top: options['visiblePos'],
              ease: Quint.easeOut,
              onComplete: options['afterShow']
            });
          }
          isHidden = false;
          el.removeClass("shy-hidden");
          el.addClass("shy-visible");
          if (!options['useJS']) {
            options['afterShow'].call(this);
          }
        }
        return currentOffset = _st;
      };
    } else {
      $(window).off("scroll");
      this.removeClass("shyHeader");
      this.removeClass("shy-visible");
      this.removeClass("shy-hidden");
      return options['elemToHide'].css({
        "top": ""
      });
    }
  };

}).call(this);

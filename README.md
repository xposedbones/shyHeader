shyHeader
=========

Hide the header after the user has scrolled a pre-defined amount of pixels

**Dependencies: TweenLite**

## Usage

$("header").shyHeader();

### Options

distanceBeforeHide: (defaults: 250px) **Distance to scroll to hide the element**

distanceBeforeShow : (defaults: 0px) **TODO, not working as of now**

elemToHide: (defaults to the targeted element) **Element to hide**

visiblePos: (defaults: 0px) **the top position when the element is visible**

hiddenPos: (defaults: - the element's height) **the top position when the element is hidden**

duration: (defaults: 0.3) **Duration of the animation *with tweenlite* if the useJS variable is set to true**

visibleClass: (defaults: "visible") **the class added to the element when the element is visible**

hiddenClass: (defaults: "hidden") **the class added to the element when the element is hidden**

useJS: (defaults: true) **Turns this off to hide the element via css, with the classes provided**

destroy: (defaults: false) **Call the plugin with this options set to true to destroy the current instance of the plugin**
# Javascript Guidelines

These apply to Javascript code and are intended to be used and usable in nearly any project and circumstance.
These rules are intended to augment the [Google Style Guide](https://google.github.io/styleguide/javascriptguide.xml).
In cases where any one rule does not apply or cannot be implemented make best efforts to implements all others regardless.

 1.  All JS files should define their code inside an anonymous function. IE: `(function () { <YOUR CODE HERE>})();` This ensures correct behavior when multiple scripts are concatenated.
 2.  Always `'use strict';` in the outermost set of brackets in each JS file. (Which will be the opening bracket for the anonymous function in rule 1)
 3.  Use Angular whenever possible. This practically forces code to be written so as to enable JS unit testing.
 4.  Avoid hard-coding ajax paths in JS. Populate a json config object into your script/application that contains this and other js config options.
 5.  Keep javascript file versions out of file paths or names. IE. .../jQuery/jQuery.js instead of .../jQuery.1.18.0/jQuery.js or .../jQuery/jQuery.1.18.0.js
 6.  Run all JS through http://jshint.com/ as you develop and before you commit.
 7.  Avoid embedding css in js whenever possible. Prefer to apply/remove class names then use separate css files to define those classes.
 8.  Avoid embedding `<script>` tags in views/templates/pages.
 9.  When available, vendor-provided minified versions of thirdparty javascripts SHOULD be included in projects with the same file name but the ".min.js" file extension. The minified versions SHOULD NOT be referenced in any code. Reference the original script when adding scripts to the bundle. Use an optimization framework to automatically find the correct minified version if it is in the same folder as the original script and has the ".min.js" file extension.
 10. Always use curly braces to define the body of a `try`, `catch`, `if`, `else`, `for`, or `while` statement even if it is only one line. Exception: Simple `return`/`break`/`continue` statements may be placed directly after an `if` on the same line - if placing them on a new line use brackets. Note that `throw` statements are intentionally excluded from this list.
 11. Always log JS errors (especially errors from ajax requests) to the console. When in angular use the `$log` service.

## Javascript - Angular

Rules specific to writing Angular js.

 1.  Never use jQuery selectors - `$('#id')` - inside an angular context. This includes anywhere in controllers, services, or directives. Any DOM manipulation needs to be done through changes to `$scope` properties or directives (which should primarily be using `$scope` properties as well).
 2.  Define all angular components (controllers, services, constants, directives, etc.) before passing them into the associated call on the angular module. [Example](Javascript-Angular-Rule-02.js)
 3.  Define all angular components (controllers, services, constants, directives, etc.) inside an immediately invoked function. [Example](Javascript-Angular-Rule-03.js)
 4.  Do not directly reference global symbols in Angular code. Broweser-provided globals have wrapper services provided by the Angular core library. Many other popular libraries

         Forbidden Reference | Angular Service              | Library URL
        ---------------------|------------------------------|-----------------
        window               | $window   (Angular)          | N/A
        document             | $document (Angular)          | N/A
        setInterval()        | $interval (Angular)          | N/A
        setTimeout()         | $timeout  (Angular)          | N/A
        console              | $log      (Angular)          | N/A
		$() or other JQuery  | N/A		 (See #1 Above)     | N/A
		moment               | $moment   (angular-momentjs) | https://www.npmjs.com/package/angular-momentjs

 5.  Only use prototypes for angular components (such as controllers) when there is another component defined in the same scope (same file) that actually uses the first component as its prototype. Otherwise do not use prototypes.
 
# CSS Guidelines

These apply to CSS and are intended to be used and usable in nearly any project and circumstance.
In cases where any one rule does not apply or cannot be implemented make best efforts to implements all others regardless.

 1.  Avoid inline styles. Define a class or assign an element id and style it using a stylesheet.
 2.  Do not embed `<style>` blocks in views.
 3.  Do not apply styles using the `style="..."` property.
 4.  Prefer more specific styles.
 5.  Do not edit shared stylesheets unless necessary. It almost always suffices to overwrite styles in a more local stylesheet.
 6.  Do not include minified stylesheets in projects (...min.css, etc) only include the full version. Use an optimization framework to minify and bundle css.

# Bemmer

Class utility to turn your insanely long bem class names into something a
little more managable.

This is stupid simple, so don't over-complicate it!

## Including in your project

### Raw Source

> $ npm build

> $ cp ./build/bemifier.js /path/to/your/project/javascripts/

### Npm

## TODO: Add npm install support

# Philosophy

Bem classes are named using blocks, elements, modifiers.  When creating classes,
you can end up with a ton of classes for just one element in a block, which may
look like this:

> .my-block {
    display: 'inline';
    border: 1px black solid;
    background-color: red;
  }

  .my-block__my-element {
    font-size: 16pt;
    font-weight: bold;
    color: white;
  }

  .my-block--active {
    background-color: white;
  }

  .my-block__my-element--active {
    color: red;
  }

Obviously, the pain comes to implementing it in your HTML/javascripts:

```
<div class="my-block my-block--active">
<span class="my-block__my-element my-block__my-element--active">
Hello World!
</span>
</div>
```




# Examples

These examples are written in coffeescript, but I have written them in a way
that they more closely resemble plain old javascript.  You can safely ignore
any arrows ('->'), which just denote functions.

    Bemmer = require './index.litcoffee'


## Basic Usage

    console.log('%cBlue!', 'Basic Usage Example:')

    bem = new Bemmer({
      block: 'header',
      element: 'title',
      modifiers: {
        'shaded': true
      }
    })

    output = bem.classes()

Produces:

    console.log('Expected Output: ', "header__title header__title--shaded")
    console.log('Received Output: ', output)

## With React and Coffeescript

**Warning:** this module hasn't been tested yet, so it may not even work at all

This works similar to the classes mixin in the React Addons package.

    ReactBemmer = require('react/index.litcoffee')
    console.log('%cBlue!', 'Bemifier with React and Coffeescript')

    div = ReactBemmer.DOM.div

    MyComponent = ReactBemmer.createComponent('my-component', {
      render: ->
        classes = @bem.with({
          element: 'container'
          modifiers: {
            active: @props.active
          }
        })

        return div(
          {classNames: classes},
          @props.children
        )
    })

`ReactBemmer` will take care of setting the `displayName`, and instantiating
`@bemmer` on your class, which is accessible from any method.  Bemmer will
assume your component name is also your block.  If this is not the desired
behaviour, although I would highly suggest it means you are going against the
grain, you can override the block name in componentWillMount like this:

> @bemmer = new Bemmer({block: 'whatever'})

## Details

Taking inspiration from [bem.info](http://bem.info/), your bem objects will
look like:

    myFirstBemObject = {
      block: 'what-a-blocky-mark',
      element: 'the-fifth',
      modifiers: {
        'active': true
      }
    }

    console.log('What does a BEM Object look like?', myFirstBemObject)

### Important differences!!!

1. **Blocks don't receive modifiers** - I don't know of a use case where this
is required in CSS.  To work around this, make a root element in your block,
and modify that.
2. **mods renamed modifiers for elements** - Being explicit is better than
typing less!  It makes the code more readable, which means more people can
understand what it does with less effort.
3. **Blocks are inlined** - bem.info's method for allowing blocks to be modified
is to have both type and mods properties on the block, then nested in contents,
you just add elements with modifiers.  I think this is convoluted, and
unnecessary, as addressed in my first point.

### But I'm using some third party libs, and string concat'ing is gross!

Add some custom css classes as the first parameter:

    bem = new Bemmer({
      block: 'my-custom-button',
      modifiers: {
        'large': true
      },
      classes: 'btn btn-primary'
    })
    bemClasses = bem.classes()

Should produce something like this:

> "btn btn-primary my-custom-button my-custom-button--large"

    console.log('CSS class name concatenation with 3rd party classes:', bemClasses)

## Run this in node/your browser!

To run this in your console with node:

`npm run readme`

To run this in your browser:

`npm run webapp`

# Resources

To learn more about BEM, check out some of these resources:

 * [bem.info](https://en.bem.info/method/definitions/)
 * [bem-react](https://github.com/dfilatov/bem-react), a wrapper around react,
using bem.info's JSON notation for components.
 * [react-bem](https://github.com/cuzzo/react-bem), a react mixin handle bem
css classes.
 * [bemify](https://github.com/franzheidl/bemify) is a set of Sass mixins to
write well structured Sass with BEM.


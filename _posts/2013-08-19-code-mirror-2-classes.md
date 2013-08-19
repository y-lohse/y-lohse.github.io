---
layout: post
title: Code Mirror 2 classes
description: A small reference of the classes used in Code Mirror
tags: 
- code mirror 2
- css
- classes
- code
- backets
- mirror
published: true
---
[Code Mirror](http://codemirror.net/) is this pretty sweet web based code editor, designed to be embedded. It's quite a technical achievement and it's no wonder that both [Brackets](http://brackets.io/) and [Light Table](http://www.lighttable.com/) are using it.

Theming is done via css; pretty much every significant word is put in a span with a class name, and you just apply your styles to those classes. The only troubble is I haven't found a good reference of which class names are applied to what. I've thrown a quick one together here for html, css and js.

## CSS

- *cm-qualifier*: class selector
- *cm-tag*: tag selector, pseudo class selector
- *cm-builtin*: id selector
- *cm-operator*: colon between a property and a value
- *cm-property*: property name
- *cm-atom*: colon in hexa-decimal format
- *cm-keyword*: color keyword
- *cm-string*: regular string, likne one passed to a url() call
- *cm-string-2*:css function (like rgba())
- *cm-number*: any number with or without a unit
- *cm-def*: @ rule
- *cm-comment*: comment

## JS

- *cm-def*: variable definition
- *cm-variable*: global variable
- *cm-variable2*: scoped variable
- *cm-property*: object property or method
- *cm-keyword*: control structure keywords (if, else, ...)
- *cm-number*: any number
- *cm-string*: literal string
- *cm-string-2*: regular expression
- *cm-comment*: comment

## HTML

- *cm-tag*: tag name
- *cm-attribute*: attribute name
- *cm-string*: attribute value
- *cm-comment*: comment
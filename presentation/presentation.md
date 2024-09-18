---
title: Blop blop
author: "Eugene"
---

## Introduction

Say we have a list of shapes we want to draw

```scala
import lib.shapes.{Shape, Square, Circle}

val shapes: List[Shape] = List(Square(side = 3), Circle(radius = 5))

def drawAll(xs: List[Shape]): Unit =
  for x <- xs do print(x.draw)

drawAll(shapes)
```

## Introduction

```scala
package lib.shapes

trait Shape:
  def draw: String

class Square(side: Int) extends Shape:
  def draw = ???
```

Problem: the person who did the shapes library forgot about draw
What do we do now?

## Simple solution


<!-- But we can not make `Drawable` a super trait of the library shapes retroactively. -->
```scala
class DrawableSquare(s: Square) extends Drawable:
  def draw = "TODO"

class DrawableCircle(c: Circle) extends Drawable:
  def draw = "TODO"

...

drawAll(DrawableSquare(Square(3)), DrawableCircle(Circle(5)))
```
<!-- But wrapping and unwrapping shapes will obviously not scala satisfactorily -->

##  Type Classes

```scala
trait Drawable[X]:
  def draw(x: X): String

def drawAll[T](xs: List[T])(witness: Drawable[T]): Unit =
  for x <- xs do print(witness.draw(x))

val SquareIsDrawable:
  def draw(x: X) = TODO

drawAll[Square](List(Square(3), Square(4)))(SquareIsDrawable)
```

<!-- Okay great, but still kinda wordy -->

## With Type Classes & Context parameters

```scala
trait Drawable extends TypeClass:
  extension(self: Self) def draw: String

def drawAll[T: Drawable](xs: List[T]): Unit =
  for x <- xs do print(x.draw)

given Square is Drawable:
  extension(self: Square) def draw = TODO

drawAll(List(Square(3), Square(4))) // OK!
```

We got retroactive conformance, usable ergonomically, so problem solved !?

## Problem

```scala
given Circle is Shape:
  extension(self: Square) def draw = TODO

drawAll(List(Square(3), Circle(9))) // Type Error:
```
#TODO exact msg

Are generic definitions using type classes then incomparable with heterogeneous collections ? 😨 


## What Others Do

<!-- Language features -->

```rust
fn drawAll(xs: std::vec<dyn Drawable>) -> () = ...
```

- Swift similarly has `any Drawable`

```
{ 
  value // of any type of shape
  witness // contains the definition of how to draw the value 
}
```

Should we just copy them then, ...
%% r has x many lines ... %%
Or is it  already expressible in Scala? After all it's just a pair
#TODO drawing

## Containers of Showable

```scala
trait AnyDrawable:
  
  val value: ?
  val witness: ?
```

## Containers of Showable

```scala
trait AnyDrawable:
  
  val value: ?
  val witness: ? is Drawable
```

<!-- Something that is Drawable, a type that is the same as the one of the value -->

## Containers of Showable

```scala
trait AnyDrawable:
  type Value
  val value: Value
  val witness: Value is Drawable
```

## This is an existential pair!!!!


$$\langle \exists X, (X, \text{X is Drawable}) \rangle$$


## Containers of Showable

```scala
trait AnyDrawable:
  type Value
  val value: Value
  val witness: Value is Drawable

def drawAll(xs: List[AnyDrawable]): Unit =
  for x <- xs do
    val v: x.Value = x.value
    val w: x.Value is Drawable = x.witness
    print(w.show(x))

val s1 = new AnyShowable:
  type Value = Square
  val value = Square(3)
  val witness = SquareIsShowable

val s2 = new AnyShowable:
  type Value = Circle
  val value = Circle(9)
  val witness = CircleIsShowable

drawAll(List(s1, s2))
```

<!-- But it's wordy, again 😵‍💫 -->

## Containers of Showable

```scala
trait AnyShowable:
  type Value
  val value: Value
  val drawer: Value is Showable

def showAll(xs: List[AnyShowable]): Unit =
  for x <- xs do
    val v: x.Value = x.value
    val w: x.Value is Showable = x.witness
    print(w.show(x))

val s1 = new AnyShowable:
  type Value = Square
  val value = Square(3)
  val witness = SquareIsShowable

val s2 = new AnyShowable:
  type Value = Circle
  val value = Circle(9)
  val witness = CircleIsShowable

showAll(List(s1, s2))
```

But it's wordy, again 😵‍💫
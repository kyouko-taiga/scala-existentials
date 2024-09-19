---
title: Existential Containers in Scala
author: "Dimi Racordon, Eugene Flesselle, Matt Bovel"
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

abstract class Shape:
  def draw: String

class Square(side: Int) extends Shape:
  def draw = "<rect width="200" height="100" fill="blue" />"
```

## Introduction

```scala
package lib.shapes

abstract class Shape:
  def draw: String

class Square(side: Int) extends Shape:
  def draw = "<rect width="200" height="100" fill="blue" />"
```

What if the shapes library omited the `draw` method?

<!-- we can not make `Drawable` a super trait of the library shapes retroactively.  -->

## Wrapper solution

```scala
abstract class Drawable:
  def draw

class DrawableSquare(s: Square) extends Drawable:
  def draw = s"<rect width=${s.side} height=${s.side} fill="blue" />"

class DrawableCircle(c: Circle) extends Drawable:
  def draw = s"<circle r="${c.radius}" fill="red" />"

...

drawAll(DrawableSquare(Square(3)), DrawableCircle(Circle(5)))
```

<!-- But wrapping and unwrapping shapes will obviously not be satisfactorily 

involves tedious boilerplate. 
- class decl 
- wrapping & unwrapping

Involves a runtine cost, possibly even linear if wrapping lists

problem grows with number of 
- imported types 
- but also, triats, DrawableSerializableSquare
 -->


##  Type Classes

```scala
trait Drawable[X]:
  def draw(x: X): String

def drawAll[T](xs: List[T])(witness: Drawable[T]): Unit =
  for x <- xs do print(witness.draw(x))

val SquareIsDrawable:
  def draw(x: X) = s"<rect width=${s.side} height=${s.side} fill="blue" />"

drawAll[Square](List(Square(3), Square(4)))(SquareIsDrawable)
```

<!-- Okay great, but still kinda wordy -->

## Type Classes with Context Parameters

```scala
trait Drawable extends TypeClass:
  extension(self: Self) def draw: String

def drawAll[T: Drawable](xs: List[T]): Unit =
  for x <- xs do print(x.draw)

given Square is Drawable:
  extension(self: Square) def draw = 
    s"<rect width=${s.side} height=${s.side} fill="blue" />"

drawAll(List(Square(3), Square(4))) // OK!
```
<!-- no need to explicitly pass + use the witness -->
We got retroactive conformance, usable ergonomically, problem solved!?

## Problem

```scala
given Circle is Shape:
  extension(self: Square) def draw = 
    s"<circle r="${c.radius}" fill="red" />"

drawAll(List(Square(3), Circle(9))) // Type Error
```
<!-- #TODO exact msg -->

How could we define `drawAll` to accept a heterogenous list of `Shape`s ?


## Existential Containers as a Language Feature

<!-- TODO check syntax -->
```rust
fn drawAll(xs: Vec<Box<dyn Drawable>>) { ... }
```

- Rust has `dyn` traits
<!-- why I am told, you need a box, since `dyn ?` is an unsized type -->
- Swift similarly has `any Drawable`

<!-- ```
{ 
  value // of any type of shape
  witness // contains the definition of how to draw the value 
}
``` -->

<!-- 
Should we just copy them then, and add yet anoter Scala feature  ?

Or is is really just a pair of a value and a witness,
And is it already expressible in Scala?
-->

## Containers of Drawable

```scala
trait AnyDrawable:
  
  val value: ?
  val witness: ?
```

## Containers of Drawable

```scala
trait AnyDrawable:
  
  val value: ?
  val witness: ? is Drawable
```

<!-- Something that is Drawable, a type that is the same as the one of the value -->

## Containers of Drawable

```scala
trait AnyDrawable:
  type Value
  val value: Value
  val witness: Value is Drawable
```

## Containers of Drawable

```scala
trait AnyDrawable:
  type Value
  val value: Value
  val witness: Value is Drawable
```

$$\langle \exists X, (X, \text{X is Drawable}) \rangle$$

## Containers of Drawable

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
```

## Containers of Drawable

```scala
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

<!-- ## Containers of Drawable

```scala
trait AnyDrawable:
  type Value: Drawable as witness
  val value: Value

def drawAll(xs: List[AnyShowable]): Unit =
  for x <- xs do print(x.show)

showAll(Square(1), Circle(9))
``` -->

## Containers of Drawable

```scala
trait AnyDrawable:
  type Value: Drawable as witness
  val value: Value

def drawAll(xs: List[AnyShowable]): Unit =
  for x <- xs do
    val v: x.Value = x.value
    print(v.show/*(using x.witness)*/)
```

## Containers of Drawable

```scala
trait AnyDrawable:
  type Value: Drawable as witness
  val value: Value

def drawAll(xs: List[AnyShowable]): Unit =
  for x <- xs do print(x/*.value*/.show/*(using x.witness)*/)
```

## Containers of Drawable

```scala
object AnyShowable:
  def apply[V: Showable](v: V) = new AnyShowable:
    type Value = V
    val value = v

drawAll(List(
  AnyShowable(Square(1))/*(using SquareIsShape)*/,
  AnyShowable(Circle(9))/*(using CircleIsShape)*/, 
))
```

## Containers of Drawable

```scala
object AnyShowable:
  ...
  given [V: Showable as w] => Conversion[V, AnyShowable] =
    (x: V) => AnyShowable(x)(using w)

showAll(Square(1), Circle(9))
```

## Containers

```scala
trait Container[T <: TypeClass]:
  type Value: T
  val value: Value

def showAll(xs: List[Container[Showable]]): Unit =
  for x <- xs do print(x.show)
```

## Soundness

## Performance

## Conlusion
import RaysExistential

func main() {
  guard CommandLine.arguments.count > 1, let shapeCount = Int(CommandLine.arguments[1]) else {
      print("Please provide the shape count as a command-line argument.")
      return
  }
  var world = initialWorld(shapeCount: shapeCount)
  let res = run(world: &world)
  print("Result: \(res)")
}

main()

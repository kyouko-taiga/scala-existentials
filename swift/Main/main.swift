import Rays

func main() {
  guard CommandLine.arguments.count > 1, let shapeCount = Int(CommandLine.arguments[1]) else {
      print("Please provide the shape count as a command-line argument.")
      return
  }
  let res = run(shapeCount: shapeCount)
  print("Result: \(res)")
}

main()

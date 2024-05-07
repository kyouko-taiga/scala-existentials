brutal_reset() {
    git clean -fdx
}

run_scala_benchmark() {
    json_file="benchmark-results/scala.json"
    txt_file="benchmark-results/scala.txt"
    cd scala
    #rm -rf .bloop .sbt .bsp .metals target
    #sbt clean
    sbt "Jmh / run -rf JSON -rff ../$json_file -o ../$txt_file $name"
    cd ..
}

run_swift_benchmark() {
    json_file="benchmark-results/swift.json"
    txt_file="benchmark-results/swift.txt"
    cd swift
    #rm -rf .build
    swift package --allow-writing-to-package-directory benchmark --format jmh
    mv Current_run.jmh.json ../$json_file
    cd ..
}

run_swift_benchmark
exit 0

read -p "WARNING: This script will brutally reset your Dotty repo (git clean -fdx). Type 'y' to continue." -n 1 -r
echo    # new line

read -p "This script should be run form the repository root repository. Type 'y' to continue." -n 1 -r
echo    # new line

mkdir benchmark-results
#brutal_reset
run_scala_benchmark
run_swift_benchmark

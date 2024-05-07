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
    tsv_folder="benchmark-results"
    cd swift
    #rm -rf .build
    swift package --allow-writing-to-package-directory benchmark --format histogramSamples
    mv *tsv ../$tsv_folder
    cd ..
}

read -p "WARNING: This script will brutally reset your Dotty repo (git clean -fdx). Type 'y' to continue." -n 1 -r
echo    # new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

read -p "This script should be run form the repository root repository. Type 'y' to continue." -n 1 -r
echo    # new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

rm -rf benchmark-results
mkdir benchmark-results
#brutal_reset
run_scala_benchmark
run_swift_benchmark

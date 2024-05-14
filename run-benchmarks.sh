brutal_reset() {
    git clean -fdx
}

run_scala_benchmark() {
    json_file="benchmark-results/scala.json"
    txt_file="benchmark-results/scala.txt"
    cd scala
    sbt "clean; Jmh / run -rf JSON -rff ../$json_file -o ../$txt_file $name"
    cd ..
}

run_swift_benchmark() {
    tsv_folder="benchmark-results"
    cd swift
    swift package clean
    swift package --allow-writing-to-package-directory benchmark --format histogramSamples
    mv *tsv ../$tsv_folder
    cd ..
}

read -p "WARNING: This script will brutally reset the repo (git clean -fdx), your will loose your changes. Type 'y' to continue." -n 1 -r
echo    # new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

read -p "This script should be run form the repository root repository. Type 'y' to continue." -n 1 -r
echo    # new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi

#brutal_reset
rm -rf benchmark-results
run_scala_benchmark
run_swift_benchmark

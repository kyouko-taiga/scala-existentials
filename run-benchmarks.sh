brutal_reset() {
    git clean -fdx
}

run_scala_benchmark() {
    jvm=$1
    jvm_coursier_id=$2
    run=$3

    echo "Running benchmars with JVM $jvm, run $run out of $runs"
    eval "$(coursier java --jvm "$jvm_coursier_id" --env)"
    json_file="benchmark-results/$jvm/$run/scala.json"
    txt_file="benchmark-results/$jvm/$run/scala.txt"
    mkdir -p "benchmark-results/$jvm/$run"
    cd scala
    sbt "clean; Jmh / run -rf JSON -rff ../$json_file -o ../$txt_file $name"
    cd ..
}

run_swift_benchmark() {
    $run=$1

    tsv_folder="benchmark-results/$run"
    mkdir -p "benchmark-results/$run"
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

runs=4
for run in $(seq 1 $runs); do
    run_scala_benchmark openjdk "adoptium:1.21.0.3" $run
    run_scala_benchmark graal "graalvm-java21:21.0.2" $run 
    run_swift_benchmark $run
done

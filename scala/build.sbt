val scala3Version = "3.4.1"

lazy val root = project
  .in(file("."))
  .settings(
    name := "rays",
    version := "0.1.0-SNAPSHOT",
    scalaVersion := scala3Version)

val scala3Version = "3.5.0-RC1-bin-SNAPSHOT"

lazy val root = project
  .in(file("."))
  .settings(
    name := "rays",
    version := "0.1.0-SNAPSHOT",
    scalaVersion := scala3Version)

libraryDependencies += "org.scalameta" %% "munit" % "1.0.0-RC1" % Test

enablePlugins(JmhPlugin)

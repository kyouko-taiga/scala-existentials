val scala3Version = "3.5.0-RC1-bin-SNAPSHOT"

lazy val root = project
  .in(file("."))
  .settings(
    name := "rays",
    version := "0.1.0-SNAPSHOT",
    scalaVersion := scala3Version)

Compile / scalacOptions ++= Seq(
  "-deprecation",
  "-language:experimental.modularity"
)

libraryDependencies += "org.scalameta" %% "munit" % "1.0.0-RC1" % Test

enablePlugins(JmhPlugin)

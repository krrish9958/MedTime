import com.android.build.gradle.LibraryExtension
import org.gradle.kotlin.dsl.configure

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")

    // AGP 8+ requires namespace for Android library modules.
    // isar_flutter_libs may not declare it in older versions.
    if (name == "isar_flutter_libs") {
        plugins.withId("com.android.library") {
            extensions.configure<LibraryExtension>("android") {
                if (namespace.isNullOrBlank()) {
                    namespace = "dev.isar.isar_flutter_libs"
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

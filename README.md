# jenkins_server


### Script to run in jenkins to dump all manually instlled plugins
```
import jenkins.model.Jenkins

def pm = Jenkins.instance.pluginManager
def allPlugins = pm.plugins

// Collect all dependency shortNames
def dependencyNames = allPlugins
    .collectMany { it.getDependencies() }
    .collect { it.shortName }
    .toSet()

// Filter plugins that are NOT dependencies of others
def manuallyInstalled = allPlugins.findAll { plugin ->
    !dependencyNames.contains(plugin.shortName)
}

manuallyInstalled
    .sort { it.getShortName() }
    .each { plugin ->
        println("${plugin.getShortName()}: ${plugin.getVersion()}")
    }
```
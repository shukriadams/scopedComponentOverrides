Scoped Component Overrides
===
A linter for scss-lint (https://github.com/brigade/scss-lint). Warns on root-level selectors that are not native to a component. Example, in the component myComponent.scss

    // good : overrides to myOtherComponent are limited to myComponent
    .myComponent {
       
        .myOtherComponent-element {
            
        }

    }

    // bad : overrides to myOtherComponent are global
    .myOtherComponent-element {
        ... 
    }



Config
---

linters:

    ScopedComponentOverrides:
        # set to true to enable
        enabled: true
        # optional : list of components to ignore
        ignoredComponents : []
        # optional : divider between component and element in selector, default is "-"
        divider : "_"

Use
---
This linter is currently not available as a Gem. To use it, place /lib/ScopedComponentOverrides.rb in a folder on your system, then add that folder to your .scss-lint.yml file as follows

    plugin_directories: ['/foo/bar']

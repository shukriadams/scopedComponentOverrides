require 'pathname'

module SCSSLint
    class Linter::ScopedComponentOverrides < Linter
        include LinterRegistry

        def visit_root(_node)
            @divider="-"
            @depth = 1
            @root = ""
            @ignoredComponents = []

            if (config['ignoredComponents'] != nil)
                 @ignoredComponents = config['ignoredComponents']
            end

            @componentName =  File.basename(engine.filename, '.scss')
            if @componentName.start_with?("_")
                @componentName = @componentName[1..-1]
            end

            if (config['divider'] != nil)
                 @divider = config['divider']
            end

            if !@ignoredComponents.include?@componentName
                yield # Continue linting children
            end
        end


        def visit_rule(node)

            selectors = node.parsed_rules.to_s.split(" ")

            selectors.each do |selector|
                #print selector + " " + @depth.to_s + " : " + @componentName + " ¤¤¤¤¤¤¤¤¤¤¤¤¤"

                if selector == "." + @componentName or selector.start_with?("." + @componentName + @divider)
                    next
                end

                if @depth > 1
                    next
                end

                add_lint(node, "Selector \"#{selector}\" is located in component #{@componentName}, but isn't scoped to that component.")
            end

            @depth += 1
            yield # Continue linting children
            @depth -= 1
        end

    end
end

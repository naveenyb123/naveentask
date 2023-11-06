# .simplecov

SimpleCov.configure do
    # Exclude files or directories from code coverage reports
    # You can use regex patterns to match files or directories
    add_filter 'config/'   # Exclude the config directory
    add_filter 'lib/custom_exceptions.rb'  # Exclude a specific file
    add_filter 'vendor/'   # Exclude the vendor directory
  
    # Set the desired output format (HTML, console, etc.)
    formatter SimpleCov::Formatter::HTMLFormatter
  
    # You can specify additional formatters if needed
    # formatter SimpleCov::Formatter::Console
    # formatter SimpleCov::Formatter::JSONFormatter
    # ...
  
    # Set the coverage minimum threshold (optional)
    minimum_coverage 90
  
    # Set the coverage maximum threshold (optional)
    maximum_coverage_drop 5
  
    # Enable tracking code coverage on merging or branching in Git (optional)
    enable_coverage :branch
  end
  
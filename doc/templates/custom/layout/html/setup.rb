def init
  sections :layout
end

# @return [Array<String>] core javascript files for layout
# @since 0.7.0
def javascripts
  %w(js/jquery-1.11.0.js js/bootstrap.min.js)
end

# @return [Array<String>] core stylesheets for the layout
# @since 0.7.0
def stylesheets
  %w(css/bootstrap.css css/bootstrap-responsive.css css/custom.css)
end

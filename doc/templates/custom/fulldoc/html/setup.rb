include Helpers::ModuleHelper

def init
  options.objects = objects = run_verifier(options.objects)
end



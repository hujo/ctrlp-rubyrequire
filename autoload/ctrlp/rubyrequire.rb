(lambda do

  paths = {}
  def paths.regist_path(paths, expr='/**/lib/**/*.rb', regexp=/^.*\/lib\//)
    for path in Array(paths) do
      sp_start = path.length + 1
      for p in Dir.glob("#{path}#{expr}") do
        sp_path = p[sp_start ... -3]
        sp_path.sub!(regexp, '') if regexp
        self[sp_path] = p
      end
    end
  end

  paths.regist_path $LOAD_PATH, '/**/*.rb', nil
  paths.regist_path Gem.default_path
  begin
    defined? ::Bundler or require 'bundler' and
      paths.regist_path Bundler.bundle_path.to_s
  rescue
  end

  paths = paths.sort_by(&:first).to_s

  if defined?(::VIM) && VIM::evaluate('s:use_rubyfile()') == 1
    VIM::command('return %s' % paths)
  else
    print paths
  end

end).call

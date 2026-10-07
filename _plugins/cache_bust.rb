require "digest"

module CacheBust
  def cache_bust(path)
    site = @context.registers[:site]
    asset_path = path.to_s.split("?", 2).first
    source_path = File.join(site.source, asset_path.sub(%r{\A/}, ""))

    unless File.file?(source_path)
      raise Jekyll::Errors::FatalException, "Cannot cache bust missing asset: #{asset_path}"
    end

    digest = Digest::SHA256.file(source_path).hexdigest[0, 12]
    separator = path.include?("?") ? "&" : "?"
    "#{path}#{separator}v=#{digest}"
  end
end

Liquid::Template.register_filter(CacheBust)

module Jekyll
  class PhotoTagGenerator < Generator
    safe true

    def generate(site)
      per_page = (site.config["photo_tag_per_page"] || 24).to_i
      names = {}
      by_slug = Hash.new { |hash, key| hash[key] = [] }

      # site.posts.docs is oldest first, so reverse for newest events first
      site.posts.docs.reverse.each do |post|
        (post.data["photos"] || []).each do |photo|
          (photo["tags"] || []).each do |tag|
            slug = Utils.slugify(tag.to_s)
            names[slug] ||= tag.to_s
            by_slug[slug] << photo.merge(
              "post_url" => post.url,
              "post_title" => post.data["title"],
              "post_date" => post.date
            )
          end
        end
      end

      by_slug.each do |slug, items|
        base = "/photos/#{slug}/"
        total_pages = (items.size / per_page.to_f).ceil
        path_for = ->(n) { n == 1 ? base : "#{base}page/#{n}/" }

        items.each_slice(per_page).with_index(1) do |slice, n|
          trail = ((n - 2)..(n + 2)).select { |i| i >= 1 && i <= total_pages }
                                    .map do |i|
            {
              "num" => i,
              "path" => path_for.call(i),
              "title" => i == 1 ? names[slug] : "#{names[slug]} - page #{i}"
            }
          end

          dir = path_for.call(n).sub(%r{\A/}, "").chomp("/")
          page = PageWithoutAFile.new(site, site.source, dir, "index.html")
          page.data.merge!(
            "layout" => "photo_tag",
            "title" => names[slug],
            "photo_tag" => names[slug],
            "photo_items" => slice,
            "paginator" => {
              "page" => n,
              "total_pages" => total_pages,
              "total_photos" => items.size,
              "previous_page" => n > 1 ? n - 1 : nil,
              "previous_page_path" => n > 1 ? path_for.call(n - 1) : nil,
              "next_page" => n < total_pages ? n + 1 : nil,
              "next_page_path" => n < total_pages ? path_for.call(n + 1) : nil,
              "first_page_path" => path_for.call(1),
              "last_page_path" => path_for.call(total_pages),
              "page_trail" => trail
            }
          )
          site.pages << page
        end
      end
    end
  end
end

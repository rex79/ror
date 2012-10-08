module Admin::ApplicationHelper
	
  def full_title(page_title)
		base_title = "888 Internal Consulting"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end	
	end

	def get_element_title(mod)
		mod.sml.first.title
	end

	def find_published(mod)
		logger.info mod.published
		if mod.published == 1
			"icon-eye-open"
		else
			"icon-eye-close"
		end
	end

	def breadcrumb(id, last_divider = false, list_element = false)
		html = ""
		tree = ModCat.getCatTree(id, []).reverse

		logger.info tree

		tree.each_with_index do |ele, index|
			html += "<li><a href=\"/admin/mods?idserv=#{ele[:idserv]}&idp=#{ele[:id]}\">#{ele[:title]}</a></li> "
			if (index+1) == tree.count && !last_divider
				html += ""
			elsif (index+1) == tree.count && list_element
				html += "<span class='divider'> > </span><a href='/admin/mods/list?idserv=#{ele[:idserv]}&idc=#{ele[:id]}'>Elementi #{ele[:title]}</a></li>"
			else
				html += "<span class='divider'> > </span></li>"
			end
		end
		
		html
	end

end	
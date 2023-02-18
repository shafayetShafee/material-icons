local function ensure_html_deps()
  quarto.doc.add_html_dependency({
    name = "material-icons",
    version = "0.14.2",
    stylesheets = {"assets/css/mi.css"}
  })
end


local function isEmpty(s)
  return s == nil or s == ''
end

local str = pandoc.utils.stringify


return {
  ['mi'] = function(args, kwargs, meta) 
    local icon = str(args[1])
    local size = str(kwargs["size"])
    local color = str(kwargs["color"])
    local class = str(kwargs["class"])
    
    if not isEmpty(size) then
      size = "font-size: " .. size .. ";"
    else
      size = ''
    end
    
    if not isEmpty(color) then
      color = "color: " .. color  .. ";"
    else
      color = ''
    end
    
    local style = "style=\"" .. size .. color .. "\""
    
    if isEmpty(class) then
      class = ''
    end
    

    if quarto.doc.is_format("html:js") then
      ensure_html_deps()
      return pandoc.RawInline(
          'html',
          "<span class=\"material-icons" .. " " .. class .. "\"" .. style .. ">" .. icon .. "</i>"
        )
    else
      return pandoc.Null()
    end
  end
}

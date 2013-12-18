module ThermalModelsHelper
  def ddgif_image_link(image_file,alt="Degree-Day Map")
    url =<<-END
    <a href="http://agwx.soils.wisc.edu/soils-agwx-assets/uwex_agwx/images/ddgifs/#{image_file}">
      <IMG SRC="http://agwx.soils.wisc.edu/soils-agwx-assets/uwex_agwx/images/ddgifs/#{image_file}" ALT="#{alt}" height="400" width="480"></a>
      END
    url.html_safe
  end
  
  def ddgif_url(link_text,image_file)
    link_to link_text, "http://agwx.soils.wisc.edu/soils-agwx-assets/uwex_agwx/images/ddgifs/#{image_file}"
  end
  
end

module ApplicationHelper
  
  def logo
    link_to image_tag("../images/logo.gif", :width => 334, :height => 38, :alt => "Volunteer Event Handler"), root_path
  end
end

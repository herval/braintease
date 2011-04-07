module UsersHelper
  
  def user_pic_link(user)
    link_to image_tag(user.picture_url, :width => 20), user_path(user)
  end
end

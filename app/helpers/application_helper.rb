module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def get_photo_key(object)
    if object.img_key.present?
      photo_key = object.img_key
    else
      photo_key = "https://res.cloudinary.com/ducqpxfso/image/upload/v1614857823/no-img-profile_og8ezm.jpg" #no photo image on cloudinary
    end 
  end
end

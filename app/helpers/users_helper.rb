module UsersHelper
  def opposite_gender(user)
    if user.gender == "male"
      "female"
    else
      "male"
    end
  end

  def contact_methods(user)
    case user.alternate_contact_method
    when "WeChat"
      [["WeChat", "WeChat"], ["Facebook", "Facebook"], ["Whatsapp", "Whatsapp"], ["Instagram", "Instagram"], ["Line", "Line"], ["None", "nil"]]
    when "Facebook"
      [["Facebook", "Facebook"], ["WeChat", "WeChat"], ["Whatsapp", "Whatsapp"], ["Instagram", "Instagram"], ["Line", "Line"], ["None", "nil"]]
    when "Whatsapp"
      [["Whatsapp", "Whatsapp"], ["WeChat", "WeChat"], ["Facebook", "Facebook"], ["Instagram", "Instagram"], ["Line", "Line"], ["None", "nil"]]
    when "Instagram"
      [["Instagram", "Instagram"], ["WeChat", "WeChat"], ["Facebook", "Facebook"], ["Whatsapp", "Whatsapp"], ["Line", "Line"], ["None", "nil"]]
    when "Line"
      [["Line", "Line"], ["WeChat", "WeChat"], ["Facebook", "Facebook"], ["Whatsapp", "Whatsapp"], ["Instagram", "Instagram"], ["None", "nil"]]
    else
      [["Please select one", "nil"], ["WeChat", "WeChat"], ["Facebook", "Facebook"], ["Whatsapp", "Whatsapp"], ["Instagram", "Instagram"], ["Line", "Line"], ["None", "nil"]]
    end
  end

  def user_back_button(user)
    if request.referrer && URI(request.referrer).path == "/unverified_drivers"
      link_to "< Unverified drivers", unverified_drivers_path
    else
      link_to "< Your profile", user_path(user)
    end
  end
end

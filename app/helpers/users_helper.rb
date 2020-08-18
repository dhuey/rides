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
end

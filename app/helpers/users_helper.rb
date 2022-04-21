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

  def user_back_button_path
    if request.referrer && URI(request.referrer).path == "/app/users/#{params[:id]}/edit"
      dashboard_path
    else
      :back
    end
  end

  def alt_contact_icon(user)
    case user.alternate_contact_method
    when "WeChat"
      "weixin"
    when "Facebook"
      "facebook"
    when "Instagram"
      "instagram"
    when "Line"
      "line"
    when "Whatsapp"
      "whatsapp"
    end
  end

  def no_vehicles_message(user)
    if current_user == user
      "You haven't added any vehicles yet. Click the button below to get started!"
    else
      "This user hasn't added any vehicles yet."
    end
  end
end

helpers do

  def all_logic(args)
    agent = Mechanize.new

    error_log = []

    page = agent.get('https://github.com/login')

    login_form = page.forms[1]

    password_field = login_form.field_with(name: "password")
    username_field = login_form.field_with(name: "login")

    username_field.value = args[:username]
    password_field.value = args[:password]
    login_form.submit

    next_page = agent.get(args[:link]).search('article').css('a')

    link_noko_elements = next_page.select{|element| element.attributes["id"] == nil}
    mech_links = link_noko_elements.map{|link| Mechanize::Page::Link.new(link, agent, page)}


    mech_links.each do |link|
      begin
        apple = Mechanize::ResponseCodeError.new(link.click).message
        error_log << apple
      rescue Mechanize::ResponseCodeError
        error_log << "PAGE NOT FOUND ---- Check the link to '#{link}'"
      end
    end

    error_log

  end

  def formatter(string_array)
    formatted = string_array.map do |string|
      "<li>#{string}</li>"
    end

    formatted
  end

end

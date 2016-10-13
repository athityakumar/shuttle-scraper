require 'mechanize'

def get_agent

  mechanize = Mechanize.new
  mechanize.follow_meta_refresh = true 
  mechanize.verify_mode = OpenSSL::SSL::VERIFY_NONE
  mechanize.pluggable_parser.default = Mechanize::Download 
  mechanize.set_proxy(nil,nil)
  return mechanize

end

def init_files

  html_files , css_files , js_files , image_files = [] , [] , [] , []
  
  html_files.push("material.html")
  html_files.push("left-sidebar.html")
  html_files.push("right-sidebar.html")
  html_files.push("dual-sidebar.html")
  html_files.push("blank.html")
  html_files.push("index.html")
  html_files.push("index-sliced.html")
  html_files.push("index-slider.html")
  html_files.push("index-drawer.html")
  html_files.push("index-walkthrough.html")
  html_files.push("article.html")
  html_files.push("event.html")
  html_files.push("project.html")
  html_files.push("player.html")
  html_files.push("todo.html")
  html_files.push("category.html")
  html_files.push("product.html")
  html_files.push("checkout.html")
  html_files.push("search.html")
  html_files.push("faq.html")
  html_files.push("coming-soon.html")
  html_files.push("404.html")
  html_files.push("calendar.html")
  html_files.push("profile.html")
  html_files.push("timeline.html")
  html_files.push("chat.html")
  html_files.push("login.html")
  html_files.push("signup.html")
  html_files.push("forgot.html")
  html_files.push("lockscreen.html")
  html_files.push("chart.html")
  html_files.push("blog.html")
  html_files.push("blog-masonry.html")
  html_files.push("gallery-filter.html")
  html_files.push("gallery-masonry.html")
  html_files.push("gallery-card.html")
  html_files.push("portfolio-filter.html")
  html_files.push("portfolio-masonry.html")
  html_files.push("portfolio-card.html")
  html_files.push("shop.html")
  html_files.push("news.html")
  html_files.push("contact.html")

  css_files.push("css/animate.css")
  css_files.push("css/materialize.min.css")
  css_files.push("css/swipebox.min.css")
  css_files.push("css/swiper.min.css")
  css_files.push("css/normalize.css")
  css_files.push("css/main.css")  
  
  js_files.push("js/vendor/modernizr-2.7.1.min.js")
  js_files.push("js/vendor/jquery-2.1.0.min.js")
  js_files.push("js/helper.js")
  js_files.push("js/vendor/HeadsUp.js")
  js_files.push("js/vendor/jquery.smoothState.js")
  js_files.push("js/vendor/chart.min.js")
  js_files.push("js/vendor/jquery.mixitup.min.js")
  js_files.push("js/vendor/jquery.swipebox.min.js")
  js_files.push("js/vendor/masonry.min.js")
  js_files.push("js/vendor/swiper.min.js")
  js_files.push("js/vendor/materialize.min.js")
  js_files.push("js/main.js")

  image_files.push("img/1.jpg")
  image_files.push("img/2.jpg")
  image_files.push("img/3.jpg")
  image_files.push("img/4.jpg")
  image_files.push("img/5.jpg")
  image_files.push("img/6.jpg")
  image_files.push("img/7.jpg")
  image_files.push("img/8.jpg")
  image_files.push("img/9.jpg")
  image_files.push("img/10.jpg")
  image_files.push("img/v1.jpg")
  image_files.push("img/v2.jpg")
  image_files.push("img/v3.jpg")
  image_files.push("img/v4.jpg")  
  image_files.push("img/v5.jpg")
  image_files.push("img/user.jpg")
  image_files.push("img/user2.jpg")
  image_files.push("img/user3.jpg")
  image_files.push("img/user4.jpg")
  image_files.push("img/user5.jpg")
  image_files.push("img/user6.jpg")
  image_files.push("img/user7.jpg")
  image_files.push("img/user8.jpg")
  image_files.push("img/featured.png")  
  image_files.push("img/banner1.jpg")
  image_files.push("img/banner2.jpg")
  image_files.push("img/banner3.jpg")
  image_files.push("img/banner4.jpg")
  image_files.push("img/product.jpg")
  image_files.push("img/product2.jpg")
  image_files.push("img/product3.jpg")
  image_files.push("img/product4.jpg")

  return html_files + css_files + js_files + image_files

end

def setup_dirs files

  base_repo = "/home/ak/github/athityakumar/shuttle-scraper/output/"
  unless Dir.exists? base_repo
    Dir.mkdir(base_repo) 
  end
  
  files.each do |file|
    dir_name = file.gsub(file.split("/").last,"")
    dir_name = (dir_name[dir_name.length-1] == "/") ? dir_name[0..dir_name.length-2] : dir_name
    unless dir_name.length == 0
      nested_dirs = dir_name.split("/")
      for i in 1..nested_dirs.count-1
        nested_dirs[i] = nested_dirs[i-1] + "/" + nested_dirs[i]
      end
      for i in 0..nested_dirs.count-1
        unless Dir.exists? base_repo+nested_dirs[i]
          Dir.mkdir(base_repo+nested_dirs[i]) 
        end
      end  
    end
  end

end

def download_files agent , files

  base_url = "http://www.codnauts.com/themes/shuttle/"
  base_repo = "/home/ak/github/athityakumar/shuttle-scraper/output/"
  i = 1
  files.each do |file|
    dir_name = file.gsub(file.split("/").last,"")
    dir_name = (dir_name[dir_name.length-1] == "/") ? dir_name[0..dir_name.length-2] : dir_name
    abs_dir = file.split("/").count == 1 ? base_repo : base_repo+dir_name
    Dir.chdir(abs_dir)
    agent.get("#{base_url}#{file}").save
    puts "Downloaded file ##{i} - #{file}"
    i = i+1
  end

end

agent , files = get_agent() , init_files()
setup_dirs(files)
download_files(agent,files)

